//
//  DoseChartView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 28/06/26.
//

import SwiftUI
import Charts

struct DoseChartView: View {
    let dayCounts: [DayCount]
    let viewModel: MonthlyChartViewModel

    var body: some View {
        Chart {
            ForEach(dayCounts) { item in
                BarMark(
                    x: .value("Day", item.day),
                    y: .value("Doses", item.count)
                )
                .foregroundStyle(Color.orange)
                .cornerRadius(2)
            }

            if let todayMarker = viewModel.todayMarker(for: dayCounts) {
                RuleMark(x: .value("Today", todayMarker))
                    .foregroundStyle(.white)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                    .annotation(position: .top, alignment: .center) {
                        Text("\(todayMarker)")
                            .font(.caption2)
                            .foregroundStyle(.white)
                    }
            }
        }
        .chartXAxis {
            AxisMarks(values: viewModel.xAxisValues) { value in
                AxisValueLabel {
                    if let day = value.as(Int.self) {
                        Text("\(day)")
                            .foregroundStyle(.white)
                    }
                }
                AxisGridLine()
            }
        }
        .chartYAxis {
            AxisMarks { value in
                AxisValueLabel {
                    if let count = value.as(Int.self) {
                        Text("\(count)")
                            .foregroundStyle(.white)
                    }
                }
                AxisGridLine()
            }
        }
        .chartYScale(domain: 0...viewModel.maxCount(for: dayCounts))
    }
}
