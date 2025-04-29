//
//  ImageSourcePicker.swift
//  GoogleSignInApp
//
//  Created by apple on 29/04/25.
//

import SwiftUI

struct ImageSourcePicker: View {
    @Binding var selectedImage: UIImage?
    @Binding var showCameraPicker: Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var showGallery = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Choose Photo Source")
                .font(.headline)

            Button("Camera") {
                showCameraPicker = true
                presentationMode.wrappedValue.dismiss()
            }

            Button("Photo Library") {
                showGallery = true
            }

            Button("Cancel", role: .cancel) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .sheet(isPresented: $showGallery, onDismiss: {
            presentationMode.wrappedValue.dismiss()
        }) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }

        .padding()
    }
}
