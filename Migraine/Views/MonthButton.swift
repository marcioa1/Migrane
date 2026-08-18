//
//  MonthButton.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 28/06/26.
//

import SwiftUI

protocol MonthNavigating: AnyObject {
    var monthLabel: String { get }
    func goToPreviousMonth()
    func goToNextMonth()
}

extension MonthlyChartViewModel: MonthNavigating {}

enum MonthNavigation {
    case previous
    case next
}

struct MonthButton: View {
    let direction: MonthNavigation
    let viewModel: any MonthNavigating

    var body: some View {
        switch self.direction {
        case .previous:
            Button {
                withAnimation {
                    viewModel.goToPreviousMonth()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
            }
        case .next:
            Button {
                withAnimation {
                    viewModel.goToNextMonth()
                }
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
            }
        }
    }
}
