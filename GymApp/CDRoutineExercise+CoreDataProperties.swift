//
//  CDRoutineExercise+CoreDataProperties.swift
//  GymAppTest1
//
//  Created by Fer on 5/3/24.
//
//

import Foundation
import CoreData


extension CDRoutineExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRoutineExercise> {
        return NSFetchRequest<CDRoutineExercise>(entityName: "CDRoutineExercise")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var exercise: CDExercise?
    @NSManaged public var exerciseRows: NSSet?
    @NSManaged public var routine: CDRoutine?

}

// MARK: Generated accessors for exerciseRows
extension CDRoutineExercise {

    @objc(addExerciseRowsObject:)
    @NSManaged public func addToExerciseRows(_ value: CDExerciseRow)

    @objc(removeExerciseRowsObject:)
    @NSManaged public func removeFromExerciseRows(_ value: CDExerciseRow)

    @objc(addExerciseRows:)
    @NSManaged public func addToExerciseRows(_ values: NSSet)

    @objc(removeExerciseRows:)
    @NSManaged public func removeFromExerciseRows(_ values: NSSet)

    
    
}

extension CDRoutineExercise : Identifiable {

}
