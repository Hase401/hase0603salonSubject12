//
//  ViewController.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var taxView: TaxView!
    // なぜこっちは@objcがいるのか
    @objc private let  taxCalculator = TaxCalculator()
    private let taxRateRepository = TaxRateResitory()
    // これは何をしているか？？
    private var observations = Set<NSKeyValueObservation>()
    
//    @IBOutlet weak var freeTaxYenTextField: UITextField!
//    @IBOutlet weak var taxRateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ViewでdidSetする
//        freeTaxYenTextField.keyboardType = .numberPad
//        taxRateTextField.keyboardType = .numberPad
        
//        if let taxRate = UserDefaults.standard.string(forKey: Self.taxRateKey) {
//            taxRateTextField.text = taxRate
//        }
        
        // TaxModelの監視
//        taxModel.notificationCenter.addObserver(self,
//                                                selector: #selector(self.handleTaxChange(_:)),
//                                                name: .init(NSNotification.Name(rawValue: TaxCalculator.notificationName)),
//                                                object: nil)
        taxView.setup(taxRateTextFieldEditingChanged: { [weak self] in
       // repositoryのsaveメソッドを使う //ミス→guard let taxRate = UserDefaults.standard.string(forKey:Self.taxRateKey)
            //【疑問】なぜ、$0で配列となっているのか、引数として何を渡しているのか(恐らくtaxRateTexrFieldの中身、なぜか配列で渡している、入力時毎回出力だから？)
            guard let taxRate = Double($0) else { return }
            self?.taxRateRepository.save(taxRate: taxRate)
        })
        
        taxView.taxRateText = String(self.taxRateRepository.load())
        
        
        // 【疑問】何しているのかワケワカメ
        observations.insert(
            observe(\.taxCalculator.taxYen, options: [.old, .new], changeHandler: { [weak self] _, change in
                guard let taxYen = change.newValue else { return }
                // viewに処理を依頼する
                self?.taxView.render(taxYen: taxYen)
            })
        )
        
    }
    
    // modelが変更しているか検知し、もし変更されていたらViewに描写を依頼する
//    @objc func handleTaxChange(_ notification: NSNotification) {
//        if let taxYen = notification.object as? Int {   //元々Any?型
//            // Viewに描画処理を依頼する
//            taxView.render(taxYen: taxYen)
//        }
//    }

    @IBAction func calculateTaxYenButtonTapped(_ sender: UIButton) {
        // outletの方ではなくて、outletを用いて予めgetとして用意してきたものを使う
        let freeTaxYen = Int(taxView.freeTaxYenText ?? "") ?? 0
        let taxRate = Float(taxView.taxRateText ?? "") ?? 0
        taxCalculator.calculateTaxYen(freeTaxYen, taxRate)
    }
    
    //これはViewで処理する内容
//    @IBAction func setUserDefalutsEditingChanged(_ sender: UITextField) {
////        UserDefaults.standard.set(taxRateTextField.text, forKey: Self.taxRateKey)
//    }
}

