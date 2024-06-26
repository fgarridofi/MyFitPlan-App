//
//  RoutineListView.swift
//  GymApp
//
//  Created by Fer on 27/2/24.
//
import SwiftUI
import CoreData

struct RoutineListView: View {
    @ObservedObject var routineViewModel: RoutineViewModel
    @Binding var isAddingRoutine: Bool

    var body: some View {
        VStack {
            if routineViewModel.routines.isEmpty {
                ContentUnavailableView {
                    Label("No Routines yet", systemImage: "figure.strengthtraining.traditional").font(Font.custom("Onest-Regular", size: 25))
                } description: {
                    Text("Create a new routine to get started.").font(Font.custom("Onest-Regular", size: 15))
                } actions: {
                    Button("Add Routine") {
                        isAddingRoutine = true
                    }
                    .foregroundColor(.black) 
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    
                }
            } else {
                List {
                    ForEach(routineViewModel.routines, id: \.self) { routine in
                        NavigationLink(destination: RoutineView(routine: routine, routineViewModel: routineViewModel)) {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(routine.name ?? "Unnamed Routine")
                                            .font(.headline)
                                        Text("\(routine.routineExercise?.count ?? 0) exercises")
                                            .foregroundColor(.orange)
                                    }
                                    Spacer()
                                }
                                .cornerRadius(10)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteRoutine)
                    .padding(.vertical, 4)
                }
            }
        }
        .onAppear {
            routineViewModel.fetchRoutines()
        }
    }
    
    private func deleteRoutine(at offsets: IndexSet) {
        offsets.forEach { index in
            if let routineID = routineViewModel.routines[index].id {
                routineViewModel.deleteRoutine(with: routineID)
            }
        }
        routineViewModel.fetchRoutines()
    }
}



