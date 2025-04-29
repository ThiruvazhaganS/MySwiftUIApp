//
//  SessionManager.swift
//  GoogleSignInApp
//
//  Created by apple on 28/04/25.
//

import SwiftUI
import FirebaseAuth

class SessionManager: ObservableObject {
    @Published var isSignedIn: Bool = false

    init() {
        self.listenToAuthState()
    }

    private func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                self.isSignedIn = true
            } else {
                self.isSignedIn = false
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
        } catch {
            print("Sign out failed: \(error.localizedDescription)")
        }
    }
}

//
//#Preview {
//    SessionManager()
//}
