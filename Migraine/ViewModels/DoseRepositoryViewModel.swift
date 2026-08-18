//
//  DoseRepository.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 24/07/26.
//

import SwiftUI
import Foundation

@MainActor
@Observable
final class DoseRepositoryViewModel {
    
    private var repository: DoseRepository?
    private(set) var doses: [Dose] = []
    private(set) var loadingState: LoadingState = .loading
    
    init() {}
    
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

extension DoseRepositoryViewModel: MonthNavigating {
    func goToPreviousMonth() {
        //
    }
    
    func goToNextMonth() {
        //
    }
    
    
}
