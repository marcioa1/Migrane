//
//  MonthlyChartViewModel.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 27/06/26.
//

import Foundation
import Observation

struct DayCount: Identifiable {
    let id = UUID()
    let day: Int
    let count: Int
}

@Observable
class MonthlyChartViewModel {
    var displayedMonth: Date = .now

    private let calendar = Calendar.current

    var monthLabel: String {
        displayedMonth.formatted(.dateTime.month(.wide).year())
    }

    var daysInMonth: Int {
        calendar.range(of: .day, in: .month, for: displayedMonth)?.count ?? 30
    }

    /// The day values used for the x-axis labels (every 5 days).
    var xAxisValues: [Int] {
        Array(stride(from: 1, through: daysInMonth, by: 5))
    }

    func goToPreviousMonth() {
        displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
    }

    func goToNextMonth() {
        displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
    }

    /// Counts the doses for each day of the displayed month.
    func dayCounts(from doses: [Dose]) -> [DayCount] {
        let components = calendar.dateComponents([.year, .month], from: displayedMonth)
        guard let startOfMonth = calendar.date(from: components),
              let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else {
            return []
        }

        let monthDoses = doses.filter { dose in
            dose.date >= startOfMonth && dose.date <= calendar.date(byAdding: .day, value: 1, to: endOfMonth)!
        }

        var counts: [Int: Int] = [:]
        for day in 1...daysInMonth {
            counts[day] = 0
        }
        for dose in monthDoses {
            let day = calendar.component(.day, from: dose.date)
            counts[day, default: 0] += 1
        }

        return (1...daysInMonth).map { DayCount(day: $0, count: counts[$0] ?? 0) }
    }

    func maxCount(for dayCounts: [DayCount]) -> Int {
        max(dayCounts.map(\.count).max() ?? 1, 1)
    }

    func totalDoses(for dayCounts: [DayCount]) -> Int {
        dayCounts.reduce(0) { $0 + $1.count }
    }

    /// The number of days in the displayed month that have no dose recorded.
    func daysWithoutDose(for dayCounts: [DayCount]) -> Int {
        dayCounts.filter { $0.count == 0 }.count
    }

    /// The day of the month to mark, only when the displayed month is the
    /// current month and there is at least one dose recorded today.
    func todayMarker(for dayCounts: [DayCount]) -> Int? {
        guard calendar.isDate(displayedMonth, equalTo: .now, toGranularity: .month) else {
            return nil
        }
        let today = calendar.component(.day, from: .now)

        if dayCounts.filter({ $0.day == today }).isEmpty {
            return nil
        } else {
            return today
        }
            
    }
}
