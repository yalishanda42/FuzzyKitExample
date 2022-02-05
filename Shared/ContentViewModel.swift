//
//  ContentViewModel.swift
//  FuzzyExample
//
//  Created by Alexander Ignatov on 5.02.22.
//

import Foundation

struct ContentViewModel {
    
    private static let range = stride(from: 0.0, through: 100.0, by: 1.0)
    
    let model = ContentModel()
    let fact = (8.8, 42.0)
    
    var points: [Double] {
        ContentViewModel.range.map {
            model.flc.consequenceGrade(for: $0, usingSingletonFact: fact)
        }
    }
}
