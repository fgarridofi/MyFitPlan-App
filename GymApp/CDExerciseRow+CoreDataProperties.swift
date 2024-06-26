//
//  CDExerciseRow+CoreDataProperties.swift
//  GymAppTest1
//
//  Created by Fer on 5/3/24.
//
//

import Foundation
import CoreData


extension CDExerciseRow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExerciseRow> {
        return NSFetchRequest<CDExerciseRow>(entityName: "CDExerciseRow")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var reps: String?
    @NSManaged public var serie: String?
    @NSManaged public var weight: String?
    @NSManaged public var routineExercise: CDRoutineExercise?

}

extension CDExerciseRow : Identifiable {

}
