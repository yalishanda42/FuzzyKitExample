//
//  Model.swift
//  FuzzyExample
//
//  Created by Alexander Ignatov on 5.02.22.
//

import FuzzyKit

struct ContentModel {
    enum Funding { case adequate, marginal, inadequate }
    enum Staffing { case small, large }
    enum Risk { case low, normal, high }
    
    let funding: SimpleLinguisticVariable<Funding, AnyFuzzySet<Double>>
    let staffing: SimpleLinguisticVariable<Staffing, AnyFuzzySet<Double>>
    let risk: SimpleLinguisticVariable<Risk, AnyFuzzySet<Double>>
    
    let flc: FuzzyLogicController<(Double, Double), Double>
    
    init() {
        let Ø = AnyFuzzySet<Double>.empty
        
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
        
        let ruleBase = FuzzyRuleBase {
            funding.is(.adequate)   || staffing.is(.small) --> risk.is(.low)
            funding.is(.marginal)   && staffing.is(.large) --> risk.is(.normal)
            funding.is(.inadequate) || Ø                   --> risk.is(.high)
        }
        
        self.funding = funding
        self.staffing = staffing
        self.risk = risk
        self.flc = FuzzyLogicController(rules: ruleBase)
    }
}

