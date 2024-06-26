//
//  GymAppApp.swift
//  GymApp
//
//  Created by Fer on 23/2/24.
//

import SwiftUI
import CoreData

@main
struct GymAppApp: App {
    
    let persistenceController = PersistenceController.shared


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
