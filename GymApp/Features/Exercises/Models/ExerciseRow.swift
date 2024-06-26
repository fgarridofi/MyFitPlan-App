//
//  ExerciseRow.swift
//  GymAppTest1
//
//  Created by Fer on 27/2/24.
//

import Foundation

struct MyExerciseRow: Identifiable , Equatable{
    var id: UUID = UUID()
    var serie: String
    var reps: String
    var weight: String
}
