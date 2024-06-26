//
//  ExerciseCardView.swift
//  GymApp
//
//  Created by Fer on 27/2/24.
//
import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct ExerciseCardView: View {
    @ObservedObject var routineViewModel: RoutineViewModel
    var routine: CDRoutine
    var routineExercise: CDRoutineExercise
    @State private var showingAlert = false
    
    private var currentSeries: Int {
            return routineExercise.exerciseRowsArray.count + 1
        }

    var body: some View {
        HStack {
            // Parte izquierda: Imagen con título
            VStack(alignment: .leading) {
                AnimatedImage(url: URL(string: routineExercise.exercise?.gifUrl ?? ""))
                    .resizable()
                    .placeholder(UIImage(systemName: "photo"))
                    .indicator(SDWebImageActivityIndicator.medium)
                    .transition(.fade)
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(7.0)
            }
            .frame(maxHeight: .infinity)
            .background(Color.white)
            
            Spacer()
            // Parte derecha: Tabla 
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(routineExercise.exercise?.name?.capitalizingFirstLetter() ?? "")
                        //.font(.headline)
                        .font(Font.custom("Onest-Regular", size: 20))
                        .foregroundColor(.orange)
                        .padding(.top, 4)
                    
                    Spacer()
                    
                    Button(action: {
                        showingAlert.toggle()
                    }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Confirm Delete"),
                            message: Text("Are you sure you want to delete this exercise?"),
                            primaryButton: .destructive(Text("Delete")) {
                                deleteExercise()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                
                Divider()
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    ExerciseHeaderRowView(Serie: "Serie", Reps: "Reps", Weight: "Weight")
                    ForEach(routineExercise.exerciseRowsArray, id: \.self) { exerciseRow in
                        ExerciseDetailRowView(row: exerciseRow)
                    }
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    Button(action: {
                        addNewRow()
                    }) {
                        Text("Add Row")
                            .foregroundColor(.blue)
                            .font(Font.custom("Onest-Regular", size: 15))
                            .fontWeight(.bold)
                            .padding(.top, 4)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        deleteLastRow()
                    }) {
                        Text("Delete Row")
                            .foregroundColor(!routineExercise.exerciseRowsArray.isEmpty ? .red : .gray)
                            .font(Font.custom("Onest-Regular", size: 15))
                            .fontWeight(.bold)
                            .padding(.top, 4)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .disabled(routineExercise.exerciseRowsArray.isEmpty)
                    Spacer()
                }
            }
            .padding(.trailing, 8)
        }
                .frame(maxWidth: .infinity)
        .background(
            ZStack {
                VStack {
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white.opacity(0.75), in: RoundedRectangle(cornerRadius: 20))
            }
        )
        

    }
    
    private func addNewRow() {
        let context = routineViewModel.persistentContainer.viewContext
        let newRow = CDExerciseRow(context: context)
        newRow.id = UUID()
        newRow.serie = Int16(currentSeries)
        newRow.reps = ""
        newRow.weight = ""
        routineExercise.addToExerciseRows(newRow)
        do {
            try context.save()
            routineViewModel.updateExercises()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    private func deleteLastRow() {
        guard let lastRow = routineExercise.exerciseRowsArray.last else { return }
        let context = routineViewModel.persistentContainer.viewContext
        context.delete(lastRow)
        do {
            try context.save()
            routineViewModel.updateExercises()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    private func deleteExercise() {
        if let routineID = routine.id {
            routineViewModel.deleteExercise(from: routineID, exercise: routineExercise)
        } else {
            print("Error: Routine ID is missing.")
        }
        
        withAnimation {
            routineViewModel.objectWillChange.send()
            print("ViewModel will change.")
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}


