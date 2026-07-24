//
//  MainView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 03/04/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Dose.date, order: .reverse) private var doses: [Dose]
    
    @State private var showingDoseForm = false
    @State private var doseToEdit: Dose?
    
    
    init() {
        // For Large Titles
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // For Inline (Standard) Titles
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack {
            List {
                if let firstDose = doses.first {
                    let interval = Date.now.timeIntervalSince(firstDose.date)
                    TimeSinceLastCrises(interval: interval)
                }
                ForEach(Array(doses.enumerated()), id: \.element.id) { index, dose in
                    Button {
                        doseToEdit = dose
                    } label: {
                        DoseRowView(dose: dose)
                    }
                    .tint(.primary)
                    .listRowBackground(Color.orange)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            modelContext.delete(dose)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    
                    if index < doses.count - 1 {
                        let next = doses[index + 1]
                        let interval = dose.date.timeIntervalSince(next.date)
                        TimeSinceLastCrises(interval: interval)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("BackgroundColor"))
            .navigationTitle("Doses")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingDoseForm = true
                    } label: {
                        Label("Add Dose", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingDoseForm) {
                DoseFormView()
            }
            .sheet(item: $doseToEdit) { dose in
                DoseFormView(doseToEdit: dose)
            }
        }
    }
}

struct TimeSinceLastCrises: View {
    let interval: TimeInterval
    
    init(interval: TimeInterval) {
        self.interval = interval
    }
    
    var body: some View {
        let totalHours = Int(interval) / 3600
        let days = totalHours / 24
        let hours = totalHours % 24
        
        HStack {
            Image(systemName: "clock")
                .font(.subheadline)
            Text(days > 0 ? "\(days)d \(hours)h ago" : "\(hours)h ago")
                .font(.subheadline)
        }
        .foregroundStyle(.white)
        .listRowBackground(Color.clear)
    }
}

#Preview {
    MainView()
        .modelContainer(for: Dose.self, inMemory: true)
}
