//
//  RoutineView.swift
//  GymApp
//
//  Created by Fer on 25/2/24.
//

import SwiftUI
import CoreData

struct RoutineView: View {
    var routine: CDRoutine
    @ObservedObject var routineViewModel: RoutineViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                LazyVStack(spacing: 10) {
                    ForEach(routine.exercisesArray, id: \.self) { exercise in
                        ExerciseCardView(
                            routineViewModel: routineViewModel,
                            routine: routine,
                            routineExercise: exercise
                        )
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    }
                }
                .navigationTitle(routine.name ?? "Routine")
                Spacer()
            }
            .padding(7)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [ .init(red: 162/255, green: 235/255, blue: 230/255), .cyan, .init(red: 90/255, green: 135/255, blue: 240/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}




