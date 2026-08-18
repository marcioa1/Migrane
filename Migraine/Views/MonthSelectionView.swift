//
//  MonthSelectionView.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 18/08/26.
//
import SwiftUI

struct MonthSelectionView: View {
    let viewModel: any MonthNavigating

    var body: some View {
        HStack {
            MonthButton(direction: .previous, viewModel: viewModel)
            Spacer()
            Text(viewModel.monthLabel)
                .font(.headline)
                .foregroundStyle(.white)
            Spacer()
            MonthButton(direction: .next, viewModel: viewModel)
        }
        .padding(.horizontal)
    }
}
