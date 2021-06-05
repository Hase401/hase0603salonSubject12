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
    private static let taxRateKey = "taxRate"
    
    @IBOutlet weak var freeTaxYenTextField: UITextField!
    @IBOutlet weak var taxRateTextField: UITextField!
    @IBOutlet weak var taxYenLabelCalculated: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        freeTaxYenTextField.keyboardType = .numberPad
        taxRateTextField.keyboardType = .numberPad
        
        if let taxRate = UserDefaults.standard.string(forKey: Self.taxRateKey) {
            taxRateTextField.text = taxRate
        }
    }

    @IBAction func calculateTaxYenButtonTapped(_ sender: UIButton) {
        let freeTaxYen = Int(freeTaxYenTextField.text!) ?? 0
        let taxRate = Float(taxRateTextField.text!) ?? 0
        let resultYen = freeTaxYen + Int(Float(freeTaxYen) * taxRate * 0.01)
        taxYenLabelCalculated.text = String(resultYen)
    }
    
    @IBAction func setUserDefalutsEditingChanged(_ sender: UITextField) {
        UserDefaults.standard.set(taxRateTextField.text, forKey: Self.taxRateKey)
    }
}

