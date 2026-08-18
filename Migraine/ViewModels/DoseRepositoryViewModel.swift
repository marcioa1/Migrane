//
//  DoseRepository.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 24/07/26.
//

import SwiftUI
import Foundation

@MainActor
@Observable
final class DoseRepositoryViewModel {
    
    private var repository: DoseRepository?
    private(set) var doses: [Dose] = []
    var displayedMonth: Date = .now

   
    
    init() {}
    

}

extension DoseRepositoryViewModel: MonthNavigating {
    
    var monthLabel: String {
        displayedMonth.formatted(.dateTime.month(.wide).year())
    }
    
    func goToPreviousMonth() {
        //
    }
    
    func goToNextMonth() {
        //
    }
    
    
}
