//
//  TotalDosesView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 28/06/26.
//

import SwiftUI

struct TotalDosesView: View {
    let dayCounts: [DayCount]
    let viewModel: MonthlyChartViewModel

    var body: some View {
        VStack {
            Text("Total: \(viewModel.totalDoses(for: dayCounts)) doses")
            Text("Days without dose: \(viewModel.daysWithoutDose(for: dayCounts))")
        }
        .font(.subheadline)
        .foregroundStyle(.white)
        .padding(.bottom)
    }
}
