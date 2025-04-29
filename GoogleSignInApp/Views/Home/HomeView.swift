//
//  HomeView.swift
//  GoogleSignInApp
//
//  Created by apple on 28/04/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showPDF = false
    @State private var showImagePicker = false
    @State private var showCameraPicker = false
    @State private var showDummyDataView = false
    @State private var selectedImage: UIImage?
    @EnvironmentObject var session: SessionManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                

                // Profile Picture (Top Center)
                Button(action: {
                    showImagePicker = true
                }) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 220, height: 220)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .resizable()
                            .frame(width: 220, height: 220)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top,40)

                // Centered View Data Button
                Button("View Data") {
                    showDummyDataView = true
                }
                .font(.title2)
                .padding()
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(12)

                Spacer()
                
                Button("Sign Out") {
                              session.signOut()
                          }
                          .padding()
                          .background(Color.red)
                          .foregroundColor(.white)
                          .cornerRadius(8)
                          .padding(.bottom,40)
                
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showPDF = true
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $showPDF) {
                PDFViewScreen()
            }
            .sheet(isPresented: $showImagePicker) {
                ImageSourcePicker(selectedImage: $selectedImage, showCameraPicker: $showCameraPicker)
            }
            .sheet(isPresented: $showCameraPicker) {
                CameraPicker(selectedImage: $selectedImage)
            }
            .fullScreenCover(isPresented:$showDummyDataView) {
                ViewDataView()
            }
        }
    }
}



#Preview {
    HomeView()
}
