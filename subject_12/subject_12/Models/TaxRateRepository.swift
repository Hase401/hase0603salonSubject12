//
//  TaxRateRepository.swift
//  subject_12
//
//  Created by akio0911 on 2021/06/07.
//

import Foundation

struct TaxRateRepository {
    private static let taxRateKey = "taxRate"

    func save(taxRate: Double) {
        UserDefaults.standard.set(taxRate, forKey: Self.taxRateKey)
    }

    func load() -> Double {
        UserDefaults.standard.double(forKey: Self.taxRateKey)
    }
}
