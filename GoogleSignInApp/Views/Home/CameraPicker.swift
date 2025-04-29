//
//  CameraPicker.swift
//  GoogleSignInApp
//
//  Created by apple on 29/04/25.
//

import SwiftUI

struct CameraPicker: View {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
            .onDisappear {
                presentationMode.wrappedValue.dismiss()
            }
    }
}


