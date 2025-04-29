import Foundation
import CoreData

class DeviceViewModel: ObservableObject {
    @Published var devices: [DeviceEntity] = []
    @Published var errorMessage: String?

    private let context = PersistenceController.shared.container.viewContext

    init(){
        fetchDevicesFromAPI()
    }
    
    func fetchDevicesFromAPI() {
        guard let url = URL(string: "https://api.restful-api.dev/objects") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { self.errorMessage = error.localizedDescription }
                return
            }

            guard let data = data else { return }

            do {
                let decodedDevices = try JSONDecoder().decode([Device].self, from: data)
                DispatchQueue.main.async {
                    self.saveToCoreData(devices: decodedDevices)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    private func saveToCoreData(devices: [Device]) {
        deleteAllDevices()

        for device in devices {
            let entity = DeviceEntity(context: context)
            entity.id = device.id
            entity.name = device.name
            entity.details = device.data?.map { "\($0.key): \($0.value.description)" }
                .joined(separator: "\n") ?? "No details"
        }

        do {
            try context.save()
            fetchDevicesFromCoreData()
        } catch {
            errorMessage = "Failed to save: \(error.localizedDescription)"
        }
    }

    func fetchDevicesFromCoreData() {
        let request: NSFetchRequest<DeviceEntity> = DeviceEntity.fetchRequest()

        do {
            devices = try context.fetch(request)
        } catch {
            errorMessage = "Failed to fetch: \(error.localizedDescription)"
        }
    }

    func deleteDevice(_ device: DeviceEntity) {
        context.delete(device)

        do {
            try context.save()
            fetchDevicesFromCoreData()
        } catch {
            errorMessage = "Failed to delete: \(error.localizedDescription)"
        }
    }

    private func deleteAllDevices() {
        let request: NSFetchRequest<NSFetchRequestResult> = DeviceEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to delete all devices: \(error.localizedDescription)")
        }
    }
}
