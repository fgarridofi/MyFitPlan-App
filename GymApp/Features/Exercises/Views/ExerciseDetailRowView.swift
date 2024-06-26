//
//  ExerciseDetailRowView.swift
//  GymApp
//
//  Created by Fer on 28/2/24.
//
import SwiftUI
import CoreData

struct ExerciseDetailRowView: View {
    var row: CDExerciseRow
    @Environment(\.managedObjectContext) private var viewContext
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case serie, reps, weight
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: 20)
            
            Text("\(row.serie)")
                .font(Font.custom("Onest-Regular", size: 15))
                .frame(width: 40)
                .fixedSize(horizontal: true, vertical: false)
            
            
            Spacer(minLength: 40)
            
            TextField("Reps", text: Binding(
                get: { row.reps ?? "" },
                set: { newValue in
                    viewContext.performAndWait {
                        row.reps = newValue
                        try? viewContext.save()
                    }
                }
            ))
            .keyboardType(.decimalPad)
            .font(Font.custom("Onest-Regular", size: 15))
            .frame(width: 40)
            .fixedSize(horizontal: true, vertical: false)
            .focused($focusedField, equals: .reps)
            
            Spacer(minLength: 40)
            
            TextField("Weight", text: Binding(
                get: { row.weight ?? "" },
                set: { newValue in
                    viewContext.performAndWait {
                        row.weight = newValue
                        try? viewContext.save()
                    }
                }
            ))
            .font(Font.custom("Onest-Regular", size: 15))
            .keyboardType(.decimalPad)
            .frame(width: 40)
            .fixedSize(horizontal: true, vertical: false)
            .focused($focusedField, equals: .weight)
            
            Spacer(minLength: 40)
            
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        focusedField = nil
    }
}




