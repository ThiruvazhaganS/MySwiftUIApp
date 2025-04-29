//
//  ContentView.swift
//  GoogleSignInApp
//
//  Created by apple on 28/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session = SessionManager()  // Create the session object here
    @Environment(\.colorScheme) var colorScheme  // Get the color scheme of the app

    var body: some View {
        VStack {
            // Use InitialView and pass session object down the view hierarchy
            InitialView()
                .environmentObject(session)  // Pass the session object to InitialView
        }
        .background(colorScheme == .dark ? Color.black : Color.white)  // Set background based on color scheme
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
