//
//  TaxView.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/05.
//

import Foundation
import UIKit

class TaxView: UIView {

    @IBOutlet weak var taxLabel: UILabel!
    
    public func render(taxYen: Int){
        taxLabel.text = String(taxYen)
    }
}
