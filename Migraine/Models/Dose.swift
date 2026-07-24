//
//  Dose.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 03/04/26.
//

import Foundation
import SwiftData

enum Medicine: String, CaseIterable, Codable {
    case sumatriptana
    case nimesulina
    case novalgina
}

enum HeadSide: String, CaseIterable, Codable {
    case left
    case right
    case back
    case eyes
}

@Model
class Dose: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var medicine: Medicine
    var side: HeadSide?
    var note: String?
    
    init(id: UUID, date: Date, medicine: Medicine, side: HeadSide? = nil, note: String? = "") {
        self.id = id
        self.date = date
        self.medicine = medicine
        self.side = side
        self.note = note    
    }
}
