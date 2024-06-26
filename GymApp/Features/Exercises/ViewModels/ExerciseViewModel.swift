//
//  ExerciseViewModel.swift
//  GymApp
//
//  Created by Fer on 23/2/24.
//

import Foundation

final class ExerciseViewModel : ObservableObject{
    
    
    @Published var exercises : [MyExercise] = []
    @Published var hasError = false
    @Published var error : ExerciseError?
    
    @Published var searchText: String = ""
    
    var filteredExercises: [MyExercise]{
        guard !searchText.isEmpty else {return exercises}
        
        return exercises.filter{exer in
            exer.name.lowercased().contains(searchText.lowercased())
            
        }
    }
    
    
    func fechExercises(){
        
        hasError = false
        
        let headers = [
            "X-RapidAPI-Key": "KEY",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        
        

        let request = NSMutableURLRequest(url: NSURL(string: "https://exercisedb.p.rapidapi.com/exercises?limit=1400")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

        
        URLSession.shared.dataTask(with: request as URLRequest) { [weak self]data, response, error in
            DispatchQueue.main.async{
                if let error = error{
                    self?.hasError = true
                    self?.error = ExerciseError.custom(error: error)
                }else {
                    let decoder = JSONDecoder()
                    if let data = data,
                       let exercises = try? decoder.decode([MyExercise].self, from: data){
                        
                        self?.exercises=exercises
                        
                    }else{
                        self?.hasError = true
                        self?.error = ExerciseError.failedToDecode
                    }
                }
            }
        }.resume()
    }
}

extension ExerciseViewModel {
    enum ExerciseError: LocalizedError{
        case custom(error:Error)
        case failedToDecode
        
        var errorDescription: String?{
            
            switch self {
            case.failedToDecode:
                return "Failed to decode"
            case.custom(let error):
                return error.localizedDescription
            }
        }
    }
    
}
 

