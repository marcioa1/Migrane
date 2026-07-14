//
//  DoseFormViewModel.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 05/04/26.
//

import Foundation
import SwiftData
import Observation

@Observable
class DoseFormViewModel {
    var selectedMedicine: Medicine = .sumatriptana
    var selectedSide: HeadSide?
    var date: Date = .now
    var note: String? = nil

    private let doseToEdit: Dose?
    private let modelContext: ModelContext

    var isEditing: Bool { doseToEdit != nil }
    var navigationTitle: String { isEditing ? "Edit Dose" : "New Dose" }

    init(modelContext: ModelContext, doseToEdit: Dose? = nil) {
        self.modelContext = modelContext
        self.doseToEdit = doseToEdit

        if let dose = doseToEdit {
            self.selectedMedicine = dose.medicine
            self.selectedSide = dose.side
            self.date = dose.date
            self.note = dose.note
        }
    }

    func save() {
        if let dose = doseToEdit {
            dose.medicine = selectedMedicine
            dose.side = selectedSide
            dose.date = date
            dose.note = note
        } else {
            let dose = Dose(id: UUID(), date: date, medicine: selectedMedicine, side: selectedSide, note: note)
            modelContext.insert(dose)
        }
    }
}
