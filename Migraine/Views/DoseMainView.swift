//
//  DoseMainView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 03/04/26.
//

import SwiftUI
import SwiftData

struct DoseMainView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingDoseForm = false
    @State private var doseToEdit: Dose?
//    @State private var repositoryViewModel: DoseRepositoryViewModel = DoseRepositoryViewModel()
    @State private var viewModel = MainDoseViewModel()
    @State private var loading: LoadingState = .loading
    
    init() {
        // For Large Titles
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // For Inline (Standard) Titles
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .success:
                NavigationStack {
                    MonthSelectionView(viewModel: viewModel)
                    List {
                        if let firstDose = viewModel.doses.first {
                            let interval = Date.now.timeIntervalSince(firstDose.date)
                            TimeSinceLastCrises(interval: interval)
                        }
                        ForEach(Array((viewModel.doses).enumerated()), id: \.element.id) { index, dose in
                            DoseListRowView(dose: dose) {
                                doseToEdit = dose
                            } onDelete: {
                                modelContext.delete(dose)
                            }
                            
                            if index < viewModel.doses.count - 1 {
                                let next = viewModel.doses[index + 1]
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
                }
                
                .sheet(isPresented: $showingDoseForm, onDismiss: {
                    Task { await viewModel.loadDoses() }
                }) {
                    DoseFormView()
                }
                .sheet(item: $doseToEdit, onDismiss: {
                    Task { await viewModel.loadDoses() }
                }) { dose in
                    DoseFormView(doseToEdit: dose)
                }
            case .loading:
                ProgressView()
            case .error:
                // TODO missing implementation
                let _ = print("Error")
            }
        }
        .task {
            viewModel.configure(repository: DoseRepositoryImplementation(modelContext: modelContext))
            await viewModel.loadDoses()
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
    DoseMainView()
        .modelContainer(for: Dose.self, inMemory: true)
}
