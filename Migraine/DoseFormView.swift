//
//  DoseFormView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 03/04/26.
//

import SwiftUI
import SwiftData

struct DoseFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var doseToEdit: Dose?

    @State private var selectedMedicine: Medicine = .sumatriptana
    @State private var selectedSide: HeadSide?
    @State private var date: Date = .now
    @State private var note: String = ""

    private var isEditing: Bool { doseToEdit != nil }

    var body: some View {
        NavigationStack {
            Form {
                Picker("Medicine", selection: $selectedMedicine) {
                    ForEach(Medicine.allCases, id: \.self) { medicine in
                        Text(medicine.rawValue.capitalized)
                            .tag(medicine)
                    }
                }
                .listRowBackground(Color(.orange))

                Picker("Head Side", selection: $selectedSide) {
                    Text("None")
                        .tag(HeadSide?.none)
                    ForEach(HeadSide.allCases, id: \.self) { side in
                        Text(side.rawValue.capitalized)
                            .tag(HeadSide?.some(side))
                    }
                }
                .listRowBackground(Color(.orange))

                DatePicker("Date & Time", selection: $date)
                    .listRowBackground(Color(.orange))
                
                TextField("Obs.: ", text: $note)
                    .listRowBackground(Color(.orange))
            }
            .scrollContentBackground(.hidden)
            .background(Color("BackgroundColor"))
            .navigationTitle(isEditing ? "Edit Dose" : "New Dose")
            .onAppear {
                if let dose = doseToEdit {
                    selectedMedicine = dose.medicine
                    selectedSide = dose.side
                    date = dose.date
                    note = dose.note ?? ""
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let dose = doseToEdit {
                            dose.medicine = selectedMedicine
                            dose.side = selectedSide
                            dose.date = date
                            dose.note = note
                        } else {
                            let dose = Dose(id: UUID(), date: date, medicine: selectedMedicine, side: selectedSide, note: note)
                            modelContext.insert(dose)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    DoseFormView()
        .modelContainer(for: Dose.self, inMemory: true)
}
