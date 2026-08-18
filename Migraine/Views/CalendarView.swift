//
//  CalendarView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 18/08/26.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Query(sort: \Dose.date, order: .reverse) private var doses: [Dose]
    @State private var viewModel = CalendarViewModel()

    private let weekdaySymbols = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
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

                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(weekdaySymbols, id: \.self) { symbol in
                        Text(symbol)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white.opacity(0.6))
                    }

                    ForEach(Array(viewModel.calendarDays.enumerated()), id: \.offset) { offset, date in
                        if let date {
                            CalendarDayCell(date: date, dosesCount: viewModel.dosesCount(for: date, in: doses))
                        } else {
                            Color.clear.frame(height: 44)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
            .background(Color("BackgroundColor"))
            .navigationTitle("Calendar")
        }
    }
}

struct CalendarDayCell: View {
    let date: Date
    let dosesCount: Int

    private var day: Int { Calendar.current.component(.day, from: date) }
    private var isToday: Bool { Calendar.current.isDateInToday(date) }

    var body: some View {
        ZStack {
            if dosesCount > 0 {
                Circle()
                    .fill(Color.red.opacity(0.75))
                    .frame(width: 38, height: 38)
            } else if isToday {
                Circle()
                    .strokeBorder(Color.white.opacity(0.6), lineWidth: 1.5)
                    .frame(width: 38, height: 38)
            }

            VStack(spacing: 1) {
                Text("\(day)")
                    .font(.system(size: 15, weight: isToday ? .semibold : .regular))
                    .foregroundStyle(.white)
                if dosesCount > 1 {
                    Text("×\(dosesCount)")
                        .font(.system(size: 9))
                        .foregroundStyle(.white.opacity(0.85))
                }
            }
        }
        .frame(height: 44)
    }
}

#Preview {
    CalendarView()
        .modelContainer(for: Dose.self, inMemory: true)
}
