//
//  TaxCalculator.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/06.
//

import Foundation

final class TaxCalculator: NSObject {
    // 数値データが今いくつか保持しておく
    @objc dynamic var taxYen: Int = 0

    func calculateTaxYen(freeTaxYen: Int, taxRate: Float) {
        taxYen = freeTaxYen + Int(Float(freeTaxYen) * taxRate * 0.01)
    }
}
