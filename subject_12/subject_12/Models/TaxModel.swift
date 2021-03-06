//
//  TaxModel.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/06.
//

import Foundation

class TaxModel {

    static let notificationName = "TaxModelChanged"
    
    let notificationCenter = NotificationCenter()

    // 数値データが今いくつか保持しておく
    internal var taxYen: Int = 0 {
        didSet {
            // modelを監視しているcontrollerに変更した通知する
            // 通知の名前と　実際に変更されたobjectをpostで伝える
            notificationCenter.post(name: .init(rawValue: TaxModel.notificationName),
                                    object: taxYen)
        }
    }
    
    func calculateTaxYen(_ freeTaxYen: Int, _ taxRate: Float) {
        taxYen = freeTaxYen + Int(Float(freeTaxYen) * taxRate * 0.01)
    }
}
