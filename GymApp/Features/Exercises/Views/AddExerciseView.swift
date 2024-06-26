//
//  AddExerciseView.swift
//  GymApp
//
//  Created by Fer on 25/2/24.
//

import SwiftUI
import CoreData
import ActivityIndicatorView
import SimpleToast
import SDWebImageSwiftUI

struct AddExerciseView: View {
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @Binding var selectedExercises: [MyExercise]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showLoadingIndicator: Bool = true
    @State private var showToast: Bool = false
    
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 1.5,
        animation: .easeInOut
    )
    
    func addExercise(_ exercise: MyExercise) {
        if !selectedExercises.contains(where: { $0.id == exercise.id }) {
            selectedExercises.append(exercise)
            withAnimation {
                showToast = true
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(exerciseViewModel.filteredExercises, id: \.id) { exercise in
                        HStack {
                            AnimatedImage(url: URL(string:"\(exercise.gifUrl)"))
                                .resizable()
                                .placeholder(UIImage(systemName: "photo"))
                                .placeholder { Circle().foregroundColor(.gray) }
                                .indicator(SDWebImageActivityIndicator.medium)
                                .transition(.fade)
                                .scaledToFit()
                                .frame(maxWidth: 50, maxHeight: 50)
                            Text(exercise.name).font(Font.custom("Onest-Regular", size: 18))
                            
                            Spacer()
                            
                            Button(action: {
                                addExercise(exercise)
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .animation(.easeInOut, value: 1)
                            .onTapGesture {
                                addExercise(exercise)
                            }
                        }.padding(.horizontal)
                        
                        Divider()
                        
                    }
                    
                }
            }
            
            .searchable(text: $exerciseViewModel.searchText, placement: .automatic, prompt: "Search exercise or muscle")
            .onAppear {
                exerciseViewModel.fechExercises()
            }
            .onChange(of: exerciseViewModel.filteredExercises) {
                withAnimation {
                    showLoadingIndicator = false
                }
            }
            .overlay(
                ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
            )
            .overlay {
                if exerciseViewModel.filteredExercises.isEmpty && !exerciseViewModel.searchText.isEmpty {
                    ContentUnavailableView.search
                }
            }
            .simpleToast(isPresented: $showToast, options: toastOptions) {
                Label("Exercise added to routine.", systemImage: "checkmark.seal")
                    .padding()
                    .background(Color.orange.opacity(0.8))
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
                    .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}


