//
//  ContentView.swift
//  GymApp
//
//  Created by Fer on 23/2/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let persistenceController = PersistenceController.shared
    @StateObject var routineViewModel = RoutineViewModel(persistentContainer: PersistenceController.shared.container)
    @State private var isAddingRoutine = false

    var body: some View {
            NavigationStack {
                RoutineListView(routineViewModel: routineViewModel, isAddingRoutine: $isAddingRoutine)
                    .font(Font.custom("Onest-Regular", size: 20))
                    .navigationTitle("Routines").font(Font.custom("Onest-Regular", size: 20))
                    .toolbar {
                        Button(action: {
                            isAddingRoutine = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $isAddingRoutine) {
                            addRoutineView()
                        }
                    }
                    .scrollContentBackground(.hidden)

                    .background(
                        LinearGradient(gradient: Gradient(colors: [ .init(red: 162/255, green: 235/255, blue: 230/255), .cyan, .init(red: 90/255, green: 135/255, blue: 240/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
            }
    }

    @ViewBuilder
    private func addRoutineView() -> some View {
        AddRoutineView(routineViewModel: routineViewModel, persistentContainer: persistenceController.container) { newRoutine in
            routineViewModel.addRoutine(newRoutine)
            isAddingRoutine = false
            routineViewModel.fetchRoutines()
        }
    }
}


#Preview {
    ContentView()
}
