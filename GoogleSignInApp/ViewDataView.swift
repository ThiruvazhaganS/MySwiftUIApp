//
//  ViewDataView.swift
//  GoogleSignInApp
//
//  Created by apple on 29/04/25.
//


import SwiftUI

struct ViewDataView: View {
    @Environment(\.dismiss) var dismiss  // For back button
    @StateObject private var viewModel = DeviceViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.devices, id: \.self) { device in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(device.name ?? "")
                            .font(.headline)
                        Text(device.details ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(4)
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.devices[$0] }.forEach(viewModel.deleteDevice)
                }
            }
            .navigationTitle("Devices")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                                   Button(action: { dismiss() }) {
                                       Image(systemName: "chevron.left")
                                           .foregroundColor(.blue)
                                   }
                               }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fetch") {
                        viewModel.fetchDevicesFromAPI()
                    }
                }
            }
//            .onAppear {
//                viewModel.fetchDevicesFromCoreData()
//            }
            .alert(item: Binding(
                get: { viewModel.errorMessage.map { ErrorAlert(message: $0) } },
                set: { _ in viewModel.errorMessage = nil }
            )) { alert in
                Alert(title: Text("Error"), message: Text(alert.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ErrorAlert: Identifiable {
    let id = UUID()
    let message: String
}
