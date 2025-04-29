//
//  InitialView.swift
//  GoogleSignInApp
//
//  Created by apple on 28/04/25.
//

import SwiftUI

struct InitialView: View {
  
    @StateObject private var session = SessionManager()

    var body: some View {
        Group {
            if session.isSignedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
//        .environmentObject(session)  // Pass session to child views if needed
    }
}

#Preview {
    InitialView()
}
