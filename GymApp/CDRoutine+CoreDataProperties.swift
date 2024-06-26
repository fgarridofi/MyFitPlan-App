//
//  CDRoutine+CoreDataProperties.swift
//  GymAppTest1
//
//  Created by Fer on 5/3/24.
//
//

import Foundation
import CoreData


extension CDRoutine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRoutine> {
        return NSFetchRequest<CDRoutine>(entityName: "CDRoutine")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var routineExercise: NSSet?

}

// MARK: Generated accessors for routineExercise
extension CDRoutine {

    @objc(addRoutineExerciseObject:)
    @NSManaged public func addToRoutineExercise(_ value: CDRoutineExercise)

    @objc(removeRoutineExerciseObject:)
    @NSManaged public func removeFromRoutineExercise(_ value: CDRoutineExercise)

    @objc(addRoutineExercise:)
    @NSManaged public func addToRoutineExercise(_ values: NSSet)

    @objc(removeRoutineExercise:)
    @NSManaged public func removeFromRoutineExercise(_ values: NSSet)

}

extension CDRoutine : Identifiable {

}
