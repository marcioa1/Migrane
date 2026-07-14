//
//  MigraineApp.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 03/04/26.
//

import SwiftUI
import SwiftData

@main
struct MigraineApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Dose.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabView {
                MainView()
                    .tabItem {
                        Label("Doses", systemImage: "pills")
                    }
                MonthlyChartView()
                    .tabItem {
                        Label("Monthly", systemImage: "chart.bar")
                    }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
