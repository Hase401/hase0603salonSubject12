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
        // 【疑問】 didSetとViewDidLoadの使い方の場面わけができるように、メリデメわかるように
        // 【回答】Viewにはライフサイクルがないから、textFieldが選択された後に次の処理を実行する
        didSet {
            // 【メモ】プロバティ変更後に実行する　→　選択するだけでも変更されたことになる！？
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
        // 【疑問】なぜ、freeTaxYenTextには変更に対応するsetを設定していないのか？
        // 【推測】freeTaxYenTextFieldの変更に対応するメソッドがないのでsetする必要がない？
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
    
    // 【メモ】このsetupをcontrollerのviewDidLoadで呼ぶ
    func setup(taxRateTextFieldEditingChanged: @escaping (String) -> Void) {
        self.taxRateTextFieldEditingChangedHandler = taxRateTextFieldEditingChanged
    }
    
    // controllerからViewを変更しろという通知が来たら、実行するメソッド
    public func render(taxYen: Int){
        taxLabel.text = String(taxYen)
    }
    
    @IBAction func taxRateTextFieldEditingChanged(_ sender: UITextField) {
        // taxRateTextFieldREditingChangedHandlerのクロージャとしての処理としてString型を渡してあげている (nilの可能性がある)
        // 引数をString型として渡し。UserDefaultsとして使用する (クロージャの中身の処理内容)
        taxRateTextFieldEditingChangedHandler(sender.text ?? "")
        print(sender.text)
    }
}
