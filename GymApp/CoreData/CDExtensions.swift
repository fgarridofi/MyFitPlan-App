//
//  CDExtensions.swift
//  GymApp
//
//  Created by Fer on 5/3/24.
//

import Foundation
import CoreData

extension CDRoutineExercise {
    var exerciseRowsArray: [CDExerciseRow] {
        guard let set = exerciseRows as? Set<CDExerciseRow> else { return [] }
        return set.sorted { (first: CDExerciseRow, second: CDExerciseRow) -> Bool in
            return (first.serie ) < (second.serie)
        }
    }
}

// Extensión para convertir los ejercicios de NSSet a Array de forma segura y ordenada, si es necesario
extension CDRoutine {
    var exercisesArray: [CDRoutineExercise] {
        let set = routineExercise as? Set<CDRoutineExercise> ?? []
        
        return set.sorted { $0.id ?? UUID() < $1.id ?? UUID() }
    }
}

