//
//  TaxView.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/05.
//

import Foundation
import UIKit

class TaxView: UIView {

    @IBOutlet private weak var taxLabel: UILabel!
    
    @IBOutlet private weak var freeTaxYenTextField: UITextField! {
        // 【疑問 didSetとViewDidLoadの使い方の場面わけができるように、メリデメわかるように
        didSet {
            freeTaxYenTextField.keyboardType = .numberPad
        }
    }
    
    @IBOutlet private weak var taxRateTextField: UITextField! {
        didSet {
            taxRateTextField.keyboardType = .numberPad
        }
    }
    
    var freeTaxYenText: String? {
        get {
            freeTaxYenTextField.text ?? ""
        }
    }
    
    var taxRateText: String? {
        get {
            taxRateTextField.text ?? ""
        }
        
        // 【疑問】setでnewValueとはどういうこと？
        set {
            taxRateTextField.text = newValue
        }
    }
    
    private var taxRateTextFieldEditingChangedHandler: (String) -> Void = { _ in }
    
    //このsetupをcontrollerのviewDidLoadで呼ぶ
    func setup(taxRateTextFieldEditingChanged: @escaping (String) -> Void) {
        self.taxRateTextFieldEditingChangedHandler = taxRateTextFieldEditingChanged
    }
    
    public func render(taxYen: Int){
        taxLabel.text = String(taxYen)
    }
    
    
    @IBAction func taxRateTextFieldEditingChanged(_ sender: UITextField) {
        //【疑問】この引数は何を表している？
        taxRateTextFieldEditingChangedHandler(sender.text ?? "")
    }
}
