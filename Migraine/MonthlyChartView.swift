//
//  MonthlyChartView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 18/04/26.
//

import SwiftUI
import SwiftData

struct MonthlyChartView: View {
    @Query(sort: \Dose.date, order: .reverse) private var doses: [Dose]

    @State private var viewModel = MonthlyChartViewModel()

    var body: some View {
        let dayCounts = viewModel.dayCounts(from: doses)

        NavigationStack {
            VStack {
                HStack {
                    MonthButton(direction: .previous, viewModel: viewModel)
                    Spacer()
                    Text(viewModel.monthLabel)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Spacer()
                    MonthButton(direction: .next, viewModel: viewModel)
                }
                .padding(.horizontal)

                DoseChartView(dayCounts: dayCounts, viewModel: viewModel)
                    .padding()

                TotalDosesView(dayCounts: dayCounts, viewModel: viewModel)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Monthly")
        }
    }
}

#Preview {
    MonthlyChartView()
        .modelContainer(for: Dose.self, inMemory: true)
}
