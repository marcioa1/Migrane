//
//  CalendarViewModel.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 18/08/26.
//

import Foundation
import Observation

@Observable
class CalendarViewModel {
    var displayedMonth: Date = .now

    private let calendar = Calendar.current

    var monthLabel: String {
        displayedMonth.formatted(.dateTime.month(.wide).year())
    }

    var calendarDays: [Date?] {
        let components = calendar.dateComponents([.year, .month], from: displayedMonth)
        guard let firstDay = calendar.date(from: components),
              let daysRange = calendar.range(of: .day, in: .month, for: firstDay) else {
            return []
        }
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        for day in daysRange {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }
        return days
    }

    func dosesCount(for date: Date, in doses: [Dose]) -> Int {
        doses.filter { calendar.isDate($0.date, inSameDayAs: date) }.count
    }
}

extension CalendarViewModel: MonthNavigating {
    func goToPreviousMonth() {
        displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
    }
    
    func goToNextMonth() {
        displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
    }
}
