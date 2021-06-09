//
//  ViewController.swift
//  subject_12
//
//  Created by 長谷川孝太 on 2021/06/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var taxView: TaxView!
    // 【疑問】なぜこっちは@objcがいるのか
    // 【回答】恐らくTaxCalculatorで"@objc dynamic という　ストアドプロバティでモデル定義しているから（インスタンスプロバティとストアドプロバティの違いは？→Qiita）
    @objc private let  taxCalculator = TaxCalculator()
    // 【疑問メモ】こっちはデータの保存でモデルの定義はいらないっていうか、objcのメソッドを使う必要がないんだと思う。
    private let taxRateRepository = TaxRateResitory()
    // 【疑問①】これは何をしているか？？
    // 【回答①】インスタンスを保持
    private var observations = Set<NSKeyValueObservation>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //UserDefaultsの使用
        // taxViewのsetupメソッドでself(taxView).taxRateTextFieldEditingChangedHandler = taxRateTextFieldEditingChanged を設定している
        taxView.setup(taxRateTextFieldEditingChanged: { [weak self] in
        //【ミス】guard let taxRate = UserDefaults.standard.string(forKey:Self.taxRateKey)
            //【疑問】なぜ、$0で配列となっているのか、引数として何を渡しているのか(恐らくtaxRateTexrFieldの中身、なぜか配列で渡している、入力時毎回出力だから？)
            // String型として渡されたtextをDouble型にして変換している？？だとするとキャストが必要なのではないか？→だからguard let 文
            print($0)
            guard let taxRate = Double($0) else { return }
            // saveメソッドでUserDefaultsに taxRateというDouble型をセットしている　→次のコードViewDidLoad内でloadでDoubleとして取り出したものをString型に直す
            self?.taxRateRepository.save(taxRate: taxRate)
        })
        
        taxView.taxRateText = String(self.taxRateRepository.load())
        
        
        // 【疑問②】何しているのかワケワカメ (objcのKVO）
        // 【回答②】プロバティの変更に対するオブザーバーを追加する　(プロバティの変更の監視)
        // 【メモ】changeHandlerは元々用意されている引数名
        observations.insert(
            // taxYenが変更されたら、changeHandlerにchange.newValueとして新しい値を取ってきて、定数として代入する
            observe(\.taxCalculator.taxYen, options: [.old, .new], changeHandler: { [weak self] _, change in
                guard let taxYen = change.newValue else { return }
                // viewに処理を依頼する
                self?.taxView.render(taxYen: taxYen)
            })
        )
        
    }

    @IBAction func calculateTaxYenButtonTapped(_ sender: UIButton) {
        // outletの方ではなくて、outlet(プロバティ)を用いて予めgetとして用意してきたものを使う
        // 【疑問】いつUserDefaultsに保存されるのか？
        // 【回答】ボタンを押さなくても、taxRateTextFieldの内容を変えて、freeTaxYenTextFieldに入力するとUserDefaultに保存されていた。(逆は保存されなかった。)
        // 【再疑問】freeTaxYenTextFieldをクリックするだけで保存できる　→　getやsetではなく、didSetが関係しているか、両方関係しているか
        let freeTaxYen = Int(taxView.freeTaxYenText ?? "") ?? 0
        let taxRate = Float(taxView.taxRateText ?? "") ?? 0
        taxCalculator.calculateTaxYen(freeTaxYen, taxRate)
    }

}

