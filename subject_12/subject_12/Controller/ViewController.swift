//
//  ViewController.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var taxView: TaxView!
    private(set) lazy var taxModel = TaxModel()
    // modelにするべきところ？userDefalutsの使い方とロードの仕方
//    var taxRateDate: Int?
    private static let taxRateKey = "taxRate"
    
    @IBOutlet weak var freeTaxYenTextField: UITextField!
    @IBOutlet weak var taxRateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        freeTaxYenTextField.keyboardType = .numberPad
        taxRateTextField.keyboardType = .numberPad
        
        if let taxRate = UserDefaults.standard.string(forKey: Self.taxRateKey) {
            taxRateTextField.text = taxRate
        }
        
        // TaxModelの監視
        taxModel.notificationCenter.addObserver(self,
                                                selector: #selector(self.handleTaxChange(_:)),
                                                name: .init(NSNotification.Name(rawValue: TaxModel.notificationName)),
                                                object: nil)
    }
    
    // modelが変更しているか検知し、もし変更されていたらViewに描写を依頼する
    @objc func handleTaxChange(_ notification: NSNotification) {
        if let taxYen = notification.object as? Int {   //元々Any?型
            // Viewに描画処理を依頼する
            taxView.render(taxYen: taxYen)
        }
    }

    @IBAction func calculateTaxYenButtonTapped(_ sender: UIButton) {
        let freeTaxYen = Int(freeTaxYenTextField.text!) ?? 0
        let taxRate = Float(taxRateTextField.text!) ?? 0
        taxModel.calculateTaxYen(freeTaxYen, taxRate)
    }
    
    @IBAction func setUserDefalutsEditingChanged(_ sender: UITextField) {
        UserDefaults.standard.set(taxRateTextField.text, forKey: Self.taxRateKey)
    }
}

