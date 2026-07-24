//
//  DoseRepository.swift
//  Migraine
//
//  Created by Marcio Aun Migueis on 24/07/26.
//

@MainActor
protocol DoseRepository {
    func fecthDoses() throws -> [Dose]
    func addDose(_ dose: Dose) throws
}
