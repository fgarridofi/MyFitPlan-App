//
//  RoutineViewModel.swift
//  GymApp
//
//  Created by Fer on 25/2/24.
//

import Foundation
import CoreData

final class RoutineViewModel: ObservableObject {
    @Published var routines: [CDRoutine] = []
    
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func fetchRoutines() {
        let context = persistentContainer.viewContext
        do {
            routines = try context.fetch(CDRoutine.fetchRequest())
        } catch {
            print("Error fetching routines: \(error)")
            routines = [] // En caso de error, asegurar la limpieza de la lista anterior.
        }
    }

    func addRoutine(_ newRoutine: CDRoutine) {
        let context = persistentContainer.viewContext
        do {
            try context.save()
            print("New routine added successfully.")
            fetchRoutines() 
        } catch {
            print("Error adding routine: \(error)")
        }
    }

    func deleteRoutine(with routineID: UUID) {
        let context = persistentContainer.viewContext
        if let routine = routines.first(where: { $0.id == routineID }) {
            context.delete(routine)
            do {
                try context.save()
                print("Routine deleted successfully.")
            } catch {
                print("Error deleting routine: \(error)")
            }
        }
    }

    
    func addExercise(to routineID: UUID, _ exercise: CDExercise) {
        let context = persistentContainer.viewContext
        if let routine = routines.first(where: { $0.id == routineID }) {
            let newRoutineExercise = CDRoutineExercise(context: context)
            newRoutineExercise.exercise = exercise

            routine.addToRoutineExercise(newRoutineExercise)

            do {
                try context.save()
                print("Exercise added successfully.")
            } catch {
                print("Error adding exercise: \(error)")
            }
        }
    }

    func deleteExercise(from routineID: UUID, exercise: CDRoutineExercise) {
        let context = persistentContainer.viewContext

        
        context.delete(exercise)
        
        do {
            try context.save()
            print("Exercise deleted successfully.")
        } catch {
            print("Error deleting exercise: \(error)")
        }
    }
    
    func findOrCreateAndUpdateExercise(from myExercise: MyExercise, in context: NSManagedObjectContext) -> CDExercise {
        let fetchRequest: NSFetchRequest<CDExercise> = CDExercise.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", myExercise.id)
        
        do {
            let results = try context.fetch(fetchRequest)
            let cdExercise = results.first ?? CDExercise(context: context)
            
            cdExercise.id = myExercise.id
            cdExercise.name = myExercise.name
            cdExercise.bodypart = myExercise.bodyPart
            cdExercise.equipment = myExercise.equipment
            cdExercise.gifUrl = myExercise.gifUrl
            cdExercise.target = myExercise.target

            return cdExercise
        } catch {
            fatalError("Failed to fetch or create CDExercise: \(error)")
        }
    }
    
    func updateExercises() {
        self.objectWillChange.send()
    }
}
