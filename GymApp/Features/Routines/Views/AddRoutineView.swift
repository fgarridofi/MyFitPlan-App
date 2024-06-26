//
//  AddRoutineView.swift
//  GymApp
//
//  Created by Fer on 25/2/24.
//

import SDWebImageSwiftUI
import SwiftUI
import CoreData

struct AddRoutineView: View {
    @State private var routineName = ""
    @ObservedObject var routineViewModel: RoutineViewModel
    @State private var selectedExercises: [MyExercise] = []
    @State private var isButtonEnabled = false
    
    
    var persistentContainer: NSPersistentContainer
    var onAddRoutine: (CDRoutine) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Routine Details").font(Font.custom("Onest-Regular", size: 15))) {
                    TextField("Routine Name", text: $routineName).font(Font.custom("Onest-Regular", size: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Routine Exercises").font(Font.custom("Onest-Regular", size: 15))) {
                    
                    NavigationLink(destination: AddExerciseView(selectedExercises: $selectedExercises)) {
                        Text("Select exercises").font(Font.custom("Onest-Regular", size: 20))
                    }
                    
                    if !selectedExercises.isEmpty {
                        Section {
                            ForEach(selectedExercises, id: \.self) { exercise in
                                HStack {
                                    AnimatedImage(url: URL(string: exercise.gifUrl ))
                                        .resizable()
                                        .placeholder(UIImage(systemName: "photo"))
                                        .placeholder { Circle().foregroundColor(.gray) }
                                        .indicator(SDWebImageActivityIndicator.medium)
                                        .transition(.fade)
                                        .scaledToFit()
                                        .frame(maxWidth: 50, maxHeight: 50)
                                    Text(exercise.name )
                                }
                            }
                        }
                    }else {
                        // Aquí se muestra un texto y un icono cuando no hay ejercicios seleccionados
                        Section {
                            HStack(alignment: .center, spacing: 10) {
                                Image(systemName: "exclamationmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.gray)
                                Text("No Exercises Added")
                                    .font(Font.custom("Onest-Regular", size: 20))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                
                
                
                HStack{
                    Spacer()
                    Button("Add Routine") {
                        let newRoutine = CDRoutine(context: persistentContainer.viewContext)
                        newRoutine.id = UUID()
                        newRoutine.name = routineName
                        
                        for myExercise in selectedExercises {
                            let cdExercise = routineViewModel.findOrCreateAndUpdateExercise(from: myExercise, in: persistentContainer.viewContext)
                            let newRoutineExercise = CDRoutineExercise(context: persistentContainer.viewContext)
                            newRoutineExercise.id = UUID()
                            newRoutineExercise.exercise = cdExercise
                            newRoutine.addToRoutineExercise(newRoutineExercise)
                            print("myExercise:")
                            print(myExercise.id)
                            print("cdExercise:")
                            print(cdExercise)
                            print("newRoutineExercise:")
                            print(newRoutineExercise)
                            print("newRoutine:")
                            print(newRoutine)
                        }
                        
                        do {
                            try persistentContainer.viewContext.save()
                            onAddRoutine(newRoutine)
                            
                            print("New routine added successfully.")
                        } catch {
                            print("Failed to save routine: \(error)")
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.black)
                    .font(Font.custom("Onest-Regular", size: 20))
                    .padding()
                    .background(isButtonEnabled ? Color.cyan : Color.gray.opacity(0.7))                      .clipShape(Capsule())
                    .disabled(!isButtonEnabled)
                    
                    Spacer()
                }
            }
            .onAppear {
                self.isButtonEnabled = !self.routineName.isEmpty && !self.selectedExercises.isEmpty
            }
            .onChange(of: routineName) {
                self.isButtonEnabled = !self.routineName.isEmpty && !self.selectedExercises.isEmpty
            }
            .onChange(of: selectedExercises) {
                self.isButtonEnabled = !self.routineName.isEmpty && !self.selectedExercises.isEmpty
            }
            
            
            
            .navigationTitle("Add Routine").font(Font.custom("Onest-Regular", size: 20))
            .toolbar {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }.font(Font.custom("Onest-Regular", size: 20))
            }
        }
    }
}


