//
//  TaxYenModel.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/05.
//

//import Foundation
//
//class TaxYenModel {
//
//    static let notificationName = "CounterModelChanged"
//
//    let notificationCenter = NotificationCenter()
//
//    // 数値データが今いくつか保持しておく
//    internal var taxYen: Int = 0 {
//        didSet {
//            // modelを監視しているcontrollerに変更した通知する
//            // 通知の名前と　実際に変更されたobjectをpostで伝える
//            notificationCenter.post(name: .init(rawValue: TaxYenModel.notificationName),
//                                    object: taxYen)
//        }
//    }
//
//    func calculateTaxYenButtonTapped(_ sender: UIButton) {
//        let freeTaxYen = Int(freeTaxYenTextField.text!) ?? 0
//        let taxRate = Float(taxRateTextField.text!) ?? 0
//        let resultYen = freeTaxYen + Int(Float(freeTaxYen) * taxRate * 0.01)
//        taxYenLabelCalculated.text = String(resultYen)
//    }
//}
