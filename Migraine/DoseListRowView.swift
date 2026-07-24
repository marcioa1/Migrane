//
//  DoseListRowView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 03/04/26.
//

import SwiftUI

struct DoseListRowView: View {
    let dose: Dose
    let onTap: () -> Void
    let onDelete: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            DoseRowView(dose: dose)
        }
        .tint(.primary)
        .listRowBackground(Color.orange)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
