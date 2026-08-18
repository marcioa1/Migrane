//
//  DoseRowView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 05/04/26.
//

import SwiftUI

struct DoseRowView: View {
    let dose: Dose

    var body: some View {
        VStack(alignment: .leading) {
            Text(dose.medicine.rawValue.capitalized)
                .font(.headline)
            if let side = dose.side {
                Text(side.rawValue.capitalized)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Text(dose.date, format: .dateTime.day().month().year().hour().minute())
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let note = dose.note, !note.isEmpty {
                Text(note)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
