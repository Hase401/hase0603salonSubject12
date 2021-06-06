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
        didSet {
            freeTaxYenTextField.keyboardType = .numberPad
        }
    }

    @IBOutlet private weak var taxRateTextField: UITextField! {
        didSet {
            taxRateTextField.keyboardType = .numberPad
        }
    }

    var freeTexYenText: String? {
        get {
            freeTaxYenTextField.text ?? ""
        }
    }

    var taxRateText: String? {
        get {
            taxRateTextField.text ?? ""
        }
        set {
            taxRateTextField.text = newValue
        }
    }

    private var taxRateTextFieldEditingChangedHandler: (String) -> Void = { _ in }

    func setup(taxRateTextFieldEditingChanged: @escaping (String) -> Void) {
        self.taxRateTextFieldEditingChangedHandler = taxRateTextFieldEditingChanged
    }

    public func render(taxYen: Int){
        taxLabel.text = String(taxYen)
    }

    @IBAction func taxRateTextFieldEditingChanged(_ sender: UITextField) {
        taxRateTextFieldEditingChangedHandler(sender.text ?? "")
    }
}
