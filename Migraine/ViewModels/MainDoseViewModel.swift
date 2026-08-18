//
//  MainDoseViewModel.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 18/08/26.
//
import SwiftUI
import Foundation

@Observable
class MainDoseViewModel {
    private var repository: DoseRepository?
    private(set) var doses: [Dose] = []
    private(set) var loadingState: LoadingState = .loading
    private let calendar = Calendar.current
    var displayedMonth: Date = .now
    var monthLabel: String {
        displayedMonth.formatted(.dateTime.month(.wide).year())
    }
    
    func configure(repository: DoseRepository) {
        self.repository = repository
    }
    
    func loadDoses() async {
        if let repository {
            loadingState = .loading
            do {
                try await Task.sleep(for: .seconds(1.2))
                doses = try await repository.fecthDoses()
                loadingState = .success
            } catch {
                loadingState = .error
            }
        }
    }
    
    func addDose(_ dose: Dose) {
        try? repository?.addDose(dose)
        doses.append(dose)
    }
}

extension MainDoseViewModel: MonthNavigating {
    func goToPreviousMonth() {
        displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
    }
    
    func goToNextMonth() {
        displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
    }
}

