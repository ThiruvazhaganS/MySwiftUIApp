//
//  AuthenticationViewModel.swift
//  GoogleSignInApp
//
//  Created by apple on 28/04/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift
import UIKit

class AuthenticationViewModel: ObservableObject {
    @Published var isSignedIn = false

    func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)

        guard let rootViewController = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first?.rootViewController else {
            print("No root view controller")
            return
        }

        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("Google Sign-In failed:", error.localizedDescription)
                return
            }
            
            guard let user = result?.user else {
                  print("Authentication failed.")
                  return
              }
          
            let idToken = user.idToken?.tokenString
            let accessToken = user.accessToken.tokenString

            let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "", accessToken: accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In failed:", error.localizedDescription)
                    return
                }

                print("User signed in successfully.")
                self.isSignedIn = true

                self.saveUserInfo(user: authResult?.user)
            }
        }
    }


    private func saveUserInfo(user: User?) {
        guard let user = user else { return }
        let db = Firestore.firestore()

        db.collection("users").document(user.uid).setData([
            "name": user.displayName ?? "",
            "email": user.email ?? "",
            "photoURL": user.photoURL?.absoluteString ?? ""
        ]) { error in
            if let error = error {
                print("Failed to save user info:", error.localizedDescription)
            } else {
                print("User info saved successfully to Firestore.")
            }
        }
    }
}
