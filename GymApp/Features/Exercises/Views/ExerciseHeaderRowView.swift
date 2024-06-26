//
//  ExerciseHeaderRowView.swift
//  GymApp
//
//  Created by Fer on 28/2/24.
//

import SwiftUI

struct ExerciseHeaderRowView: View {
    let Serie: String
    let Reps: String
    let Weight: String
   

    var body: some View {
        HStack {
            Spacer()
            Text(Serie)
                .font(Font.custom("Onest-Regular", size: 15))
                .fontWeight(.bold)

            Spacer()

            Text(Reps)
                .font(Font.custom("Onest-Regular", size: 15))
                .fontWeight(.bold)

            Spacer()

            Text(Weight)
                .font(Font.custom("Onest-Regular", size: 15))
                .fontWeight(.bold)
            Spacer()
        }
    }
}
#Preview {
    ExerciseHeaderRowView(Serie: "serie", Reps: "reps", Weight: "34 kg")
}
