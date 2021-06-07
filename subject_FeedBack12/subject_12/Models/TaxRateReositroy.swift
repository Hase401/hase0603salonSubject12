//
//  TaxRateReositry.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/07.
//

import Foundation

struct TaxRateResitory {
    private static let taxRateKey = "taxRate"
    
    func save(taxRate: Double) {
        UserDefaults.standard.set(taxRate, forKey: Self.taxRateKey)
    }
    
    func load() -> Double {
        UserDefaults.standard.double(forKey: Self.taxRateKey)
    }
}
