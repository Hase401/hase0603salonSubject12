//
//  ViewController.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var taxView: TaxView!
    // 【メモ】恐らくTaxCalculatorでモデル定義してデータの変更を通知するために"@objc dynamic"を使っている
    @objc private let  taxCalculator = TaxCalculator()
    // 【メモ】こっちはデータの保存でモデルの定義はいらないっていうか、データの変更を通知する必要がない
    private let taxRateRepository = TaxRateResitory()
    // インスタンスを保持
    private var observations = Set<NSKeyValueObservation>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultsの使用
        // taxViewのsetupメソッドでself(taxView).taxRateTextFieldEditingChangedHandler = taxRateTextFieldEditingChanged を設定している
        taxView.setup(taxRateTextFieldEditingChanged: { [weak self]  in
        //【ミス】guard let taxRate = UserDefaults.standard.string(forKey:Self.taxRateKey)
            //【疑問】なぜ、$0で配列となっているのか、引数として何を渡しているのか(恐らくtaxRateTexrFieldの中身、なぜか配列で渡している、入力時毎回出力だから？)
            //【メモ】String型として渡されたtextをDouble型にして変換している？？だとするとキャストが必要なのではないか？→だからguard let 文
            print($0)
            guard let taxRate = Double($0) else { return }
            // saveメソッドでUserDefaultsに taxRateというDouble型をセットしている　→次のコードViewDidLoad内でloadでDoubleとして取り出したものをString型に直す
//【UserDefaults順番③】TaxRateRepositroyにUserDefaultsとして保存するデータ処理を実行
            self?.taxRateRepository.save(taxRate: taxRate)
            print("UserDefaultsに　\(taxRate) がsaveされました")
        })
        
        // taxRateTextの値をsetで更新している
        taxView.taxRateText = String(self.taxRateRepository.load())
        
//【MVC順番5】modelのtaxYenの変更を検知する
        // 【疑問】何しているのかワケワカメ (objcのKVO）
        // 【回答】プロバティの変更に対するオブザーバーを追加する　(プロバティの変更の監視)
        observations.insert(
            // taxYenが変更されたら、changeHandlerにchange.newValueとして新しい値を取ってきて、定数として代入する
            observe(\.taxCalculator.taxYen, options: [.old, .new], changeHandler: { [weak self] _, change in
                guard let taxYen = change.newValue else { return }
// 【MVC順番6】viewに処理を依頼する
                self?.taxView.render(taxYen: taxYen)
            })
        )
        
    }

//【MVC順番１】ボタンのタップ入力を受け付ける
    @IBAction func calculateTaxYenButtonTapped(_ sender: UIButton) {
        // @IBOutletのプロバティ方ではなくて、コンピューテッドプロバティを用いて、getから値を取ってくる
        // 【疑問】なぜ、taxRate→freeTaxYenの順番に入力しないとUserDefaultsに保存できないのか？
        let freeTaxYen = Int(taxView.freeTaxYenText ?? "") ?? 0
//        let freeTaxYen = Int(taxView.freeTaxYenText!) ?? 0
        let taxRate = Float(taxView.taxRateText ?? "") ?? 0
//        let taxRate = Float(taxView.taxRateText!) ?? 0
//【MVC順番２】taxCalculatorに処理を依頼する
        taxCalculator.calculateTaxYen(freeTaxYen, taxRate)
    }

}

