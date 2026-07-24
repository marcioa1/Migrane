//
//  DoseRepository.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 24/07/26.
//

import SwiftUI

@MainActor
@Observable
final class DoseRepositoryViewModel {
    
    private let repository: DoseRepository
    private(set) var doses: [Dose] = []
    
    init(repository: DoseRepository) {
        self.repository = repository
    }
    
    func loadDoses() {
        doses = try! repository.fecthDoses()
    }
    
    func addDose(_ dose: Dose) {
        try? repository.addDose(dose)
        doses.append(dose)
    }
    
}
