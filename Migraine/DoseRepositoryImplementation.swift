//
//  DoseRepositoryImplementation.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 24/07/26.
//

import SwiftData
import Foundation

class DoseRepositoryImplementation: DoseRepository {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fecthDoses() throws -> [Dose] {
        let descriptor = FetchDescriptor<Dose>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    func addDose(_ dose: Dose) throws {
        modelContext.insert(dose)
        try? modelContext.save()
    }
    
    
}
