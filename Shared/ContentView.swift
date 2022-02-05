//
//  ContentView.swift
//  Shared
//
//  Created by Alexander Ignatov on 4.01.22.
//

import SwiftUI
import FuzzyKit
import SwiftUICharts

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
