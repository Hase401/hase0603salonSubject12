//
//  ViewController.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var taxView: TaxView!

    @objc private let taxCalculator = TaxCalculator()
    private let taxRateRepository = TaxRateRepository()

    private var observations = Set<NSKeyValueObservation>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taxView.setup(taxRateTextFieldEditingChanged: { [weak self] in
            guard let taxRate = Double($0) else { return }
            self?.taxRateRepository.save(taxRate: taxRate)
        })

        taxView.taxRateText = String(taxRateRepository.load())
        
        observations.insert(
            observe(\.taxCalculator.taxYen, options: [.old, .new], changeHandler: { [weak self] _, change in
                guard let taxYen = change.newValue else { return }
                // Viewに描画処理を依頼する
                self?.taxView.render(taxYen: taxYen)
            })
        )
    }
    
    @IBAction func calculateTaxYenButtonTapped(_ sender: UIButton) {
        let freeTaxYen = Int(taxView.freeTexYenText ?? "") ?? 0
        let taxRate = Float(taxView.taxRateText ?? "") ?? 0
        taxCalculator.calculateTaxYen(freeTaxYen: freeTaxYen, taxRate: taxRate)
    }
}
