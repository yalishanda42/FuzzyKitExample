//
//  ContentView.swift
//  Shared
//
//  Created by Alexander Ignatov on 4.01.22.
//

import SwiftUI
import FuzzyKit
import SwiftUICharts

// MARK: - Model

enum Funding { case adequate, marginal, inadequate }
enum Staffing { case small, large }
enum Risk { case low, normal, high }

let funding: SimpleLinguisticVariable<Funding, AnyFuzzySet> = [
    .inadequate: .init(membershipFunction: .leftOpen(slopeStart: 15, slopeEnd: 35)),
    .marginal: .init(membershipFunction: .triangular(minimum: 21, peak: 41, maximum: 61)),
    .adequate: .init(membershipFunction: .rightOpen(slopeStart: 55, slopeEnd: 75)),
]

let staffing: SimpleLinguisticVariable<Staffing, AnyFuzzySet> = [
    .small: .init(membershipFunction: .leftOpen(slopeStart: 29, slopeEnd: 69)),
    .large: .init(membershipFunction: .rightOpen(slopeStart: 37, slopeEnd: 77)),
]

let risk: SimpleLinguisticVariable<Risk, AnyFuzzySet> = [
    .low: .init(membershipFunction: .leftOpen(slopeStart: 20, slopeEnd: 40)),
    .normal: .init(membershipFunction: .triangular(minimum: 20, peak: 50, maximum: 80)),
    .high: .init(membershipFunction: .rightOpen(slopeStart: 60, slopeEnd: 80)),
]

let Ø = AnyFuzzySet<Double>.empty

let ruleBase = FuzzyRuleBase {
    funding.is(.adequate) || staffing.is(.small) --> risk.is(.low)
    funding.is(.marginal) && staffing.is(.large) --> risk.is(.normal)
    funding.is(.inadequate) || Ø --> risk.is(.high)
}

let flc = FuzzyLogicController(rules: ruleBase)

// MARK: - ViewModel

struct ContentViewModel {
    private static let range = stride(from: 0.0, through: 100.0, by: 1.0)
    
    var points: [Double] {
        ContentViewModel.range.map { flc.consequenceGrade(for: $0, usingSingletonFact: (8.8, 42)) }
    }
}

// MARK: - View

struct ContentView: View {
    
    let viewModel = ContentViewModel()
    
    var body: some View {
        MultiLineChartView(data: [
            (viewModel.points, .init(start: .purple, end: .blue)),
        ], title: "Example")
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
