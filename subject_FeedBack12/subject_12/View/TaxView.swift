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
        // 【疑問】didSetとViewDidLoadの使い方の場面わけができるように、メリデメわかるように
        // 【推測】Viewにはライフサイクルがないから、textFieldが選択された後に次の処理を実行する
        // 【メモ】didSetはプロバティ変更後に実行する　→　選択するだけでも変更されたことになる
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
        // 値の返却
        get {
            freeTaxYenTextField.text ?? ""
        }
    }
    
    var taxRateText: String? {
        get {
            taxRateTextField.text ?? ""
        }
        
        // 値の更新
        set {
            taxRateTextField.text = newValue
        }
    }
    
    private var taxRateTextFieldEditingChangedHandler: (String) -> Void = { _ in }
    
    // setupをcontrollerのviewDidLoadで呼ぶ
    func setup(taxRateTextFieldEditingChanged: @escaping (String) -> Void) {
        self.taxRateTextFieldEditingChangedHandler = taxRateTextFieldEditingChanged
    }
    
// 【MVC順番７】controllerからViewを変更しろという通知が来たら、描写処理する
    public func render(taxYen: Int){
        taxLabel.text = String(taxYen)
    }
    
//【UserDefaults順番①】ViewControllerではなく、Viewとして入力を受ける
    @IBAction func taxRateTextFieldEditingChanged(_ sender: UITextField) {
        // taxRateTextFieldREditingChangedHandlerのクロージャとしての処理としてString型を渡してあげている (nilの可能性がある)
        // 引数をString型として渡し。UserDefaultsとして使用する (クロージャの中身の処理内容)
// 【UserDefaults順番②】ControllerにTaxRateRepositroyにUserDefaultsとして保存する処理を依頼している？それともすでにデータ処理している？
        print("クロージャ実行前　sender.text: " + sender.text!)
        taxRateTextFieldEditingChangedHandler(sender.text ?? "")
        print("クロージャ実行後")
    }
    
}
