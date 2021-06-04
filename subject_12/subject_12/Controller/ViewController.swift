//
//  ViewController.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    // modelにするべきところ？userDefalutsの使い方とロードの仕方
//    var taxRateDate: Int?
    
    @IBOutlet weak var freeTaxYenTextField: UITextField!
    @IBOutlet weak var taxRateTextField: UITextField!
    @IBOutlet weak var taxYenLabelCalculated: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        freeTaxYenTextField.keyboardType = .numberPad
        taxRateTextField.keyboardType = .numberPad
        
        if let taxRate = UserDefaults.standard.string(forKey: "taxRate") {
            taxRateTextField.text = taxRate
        }
    }

    @IBAction func calculateTaxYenButtonTapped(_ sender: UIButton) {
        let freeTaxYen = Float(freeTaxYenTextField.text!) ?? 0
        let taxRate = Float(taxRateTextField.text!) ?? 0
        let taxYen: Float = freeTaxYen * ( taxRate * 0.01 + 1 )
        let resultNumber = Int(taxYen)
        
        taxYenLabelCalculated.text = "\(resultNumber)"
        
        
        //　【解決】オプショナル型IntからString型に変換しようとしていなのでこれだとイニシャライザがないと表示されてしまう。"\()"ならオプショナル型で表示される
//        taxYenLabelCalculated.text = String(resultNumber)
    }
    
    @IBAction func setUserDefalutsEditingChanged(_ sender: UITextField) {
//        【メモ】 古いやり方
//        NSUserDefaults.resetStandardUserDefaults().setOject(taxYenLabelCalculated.text, forkey: "taxYen1")
        UserDefaults.standard.set(taxRateTextField.text, forKey: "taxRate")
    }
}

