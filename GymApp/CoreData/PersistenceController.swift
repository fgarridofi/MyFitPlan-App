//
//  PersistenceController.swift
//  GymApp
//
//  Created by Fer on 5/3/24.
//

import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "GymAppModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error al cargar el almacén persistente: \(error)")
            }
        }
    }
}
