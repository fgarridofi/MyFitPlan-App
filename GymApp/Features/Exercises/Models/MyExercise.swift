//
//  Ejercicio.swift
//  GymApp
//
//  Created by Fer on 23/2/24.
//

import Foundation


struct MyExercise : Codable , Identifiable, Equatable, Hashable{
    
    var bodyPart: String
    var equipment: String
    var gifUrl: String
    var id: String
    var name: String
    var target: String
    
    static func == (lhs: MyExercise, rhs: MyExercise) -> Bool {
            // Implementa una lógica de comparación adecuada para tus propiedades
            return lhs.id == rhs.id && lhs.name == rhs.name
        }
   
}
