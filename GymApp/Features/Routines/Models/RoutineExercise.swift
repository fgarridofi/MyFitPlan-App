//
//  RoutineExercise.swift
//  GymAppTest1
//
//  Created by Fer on 27/2/24.
//

import Foundation
class MyRoutineExercise: Identifiable, ObservableObject {
    var id: UUID = UUID()
    var exercise: MyExercise
    @Published var exerciseRows: [MyExerciseRow]
    
    init(id: UUID, exercise: MyExercise, exerciseRows: [MyExerciseRow]) {
        self.id = id
        self.exercise = exercise
        self.exerciseRows = exerciseRows
    }
}
