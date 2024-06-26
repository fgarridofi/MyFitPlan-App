//
//  CDExercise+CoreDataProperties.swift
//  GymAppTest1
//
//  Created by Fer on 5/3/24.
//
//

import Foundation
import CoreData


extension CDExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExercise> {
        return NSFetchRequest<CDExercise>(entityName: "CDExercise")
    }

    @NSManaged public var bodypart: String?
    @NSManaged public var equipment: String?
    @NSManaged public var gifUrl: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var target: String?
    @NSManaged public var routineExercise: CDRoutineExercise?

}

extension CDExercise : Identifiable {

}
