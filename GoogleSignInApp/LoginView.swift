//
//  LoginView.swift
//  GoogleSignInApp
//
//  Created by apple on 28/04/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthenticationViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("Welcome!")
                    .font(.largeTitle)
                    .padding()

                Button(action: {
                    viewModel.signIn()
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Sign in with Google")
                            .bold()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $viewModel.isSignedIn) {
                HomeView() // Redirect after login
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

