//
//  TaxModel.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/06.
//

import Foundation

class TaxCalculator: NSObject {
    
    @objc dynamic var taxYen: Int = 0
    
    // modelとなっているtaxYenの計算処理
    func calculateTaxYen(_ freeTaxYen: Int, _ taxRate: Float) {
        taxYen = freeTaxYen + Int(Float(freeTaxYen) * taxRate * 0.01)
    }
}
