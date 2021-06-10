//
//  TaxModel.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/06.
//

import Foundation

class TaxCalculator: NSObject {
    
// 【MVC順番4】taxYenの変更を通知する
    @objc dynamic var taxYen: Int = 0
    
// 【MVC順番3】taxYenの計算処理する
    func calculateTaxYen(_ freeTaxYen: Int, _ taxRate: Float) {
        taxYen = freeTaxYen + Int(Float(freeTaxYen) * taxRate * 0.01)
    }
}
