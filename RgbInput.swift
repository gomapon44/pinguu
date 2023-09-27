//
//  RgbInput.swift
//  pinguu
//
//  Created by 五十嵐麻奈美 on 2019/07/03.
//  Copyright © 2019 mana. All rights reserved.
//

import UIKit

class RgbInput: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = ""
    }
    
    override func loadView() {
        if let view = UINib(nibName: "RgbInput", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    var rgbcode: String = ""
    var rCode: String = ""
    var gCode: String = ""
    var bCode: String = ""
    var L: Int = 0
    
    func tappedButton(key: String) {
        if rgbcode.count < 11 {
            if rgbcode.count == 3 {
                rgbcode += ","
            } else if rgbcode.count == 7 {
                rgbcode += ","
            }
            rgbcode += key
            textLabel.text = rgbcode
        }
    }

    @IBOutlet weak var textLabel: UILabel!
    @IBAction func button1(_ sender: Any) {
        tappedButton(key: "1")
    }
    @IBAction func button2(_ sender: Any) {
        tappedButton(key: "2")
    }
    @IBAction func button3(_ sender: Any) {
        tappedButton(key: "3")
    }
    @IBAction func button4(_ sender: Any) {
        tappedButton(key: "4")
    }
    @IBAction func button5(_ sender: Any) {
        tappedButton(key: "5")
    }
    @IBAction func button6(_ sender: Any) {
        tappedButton(key: "6")
    }
    @IBAction func button7(_ sender: Any) {
        tappedButton(key: "7")
    }
    @IBAction func button8(_ sender: Any) {
        tappedButton(key: "8")
    }
    @IBAction func button9(_ sender: Any) {
        tappedButton(key: "9")
    }
    @IBAction func button0(_ sender: Any) {
        tappedButton(key: "0")
    }
    @IBAction func buttonClear(_ sender: Any) {
        rgbcode = ""
        textLabel.text = ""
    }
    @IBAction func buttonOK(_ sender: Any) {
        if rgbcode.count == 11 {
            let rgbCodes = rgbcode.components(separatedBy: ",")
            let r = Int(rgbCodes[0])!
            let g = Int(rgbCodes[1])!
            let b = Int(rgbCodes[2])!
            rCode = String(r, radix: 16) //
            if rCode.count == 1 {
                rCode = "0" + rCode
            }
            rCode = rCode.uppercased()
            gCode = String(g, radix: 16)
            if gCode.count == 1 {
                gCode = "0" + gCode
            }
            gCode = gCode.uppercased()
            bCode = String(b, radix: 16)
            if bCode.count == 1 {
                bCode = "0" + bCode
            }
            bCode = bCode.uppercased()
            
            switch (r,g,b) {
            case (0...255, 0...255, 0...255):
                ok()
            default:
                rgbcode = ""
                textLabel.text = ""
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.message = "０〜２５５の範囲で入力してください。"
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                let mainVC = self.parent as? MainViewController
                mainVC?.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func buttonBackSpace(_ sender: Any) {
        var num = rgbcode.count
        switch num {
        case 0:
            break
        case 4, 8:
            num -= 2
            rgbcode = String(rgbcode.prefix(num))
            textLabel.text = rgbcode
        default:
            num -= 1
            rgbcode = String(rgbcode.prefix(num))
            textLabel.text = rgbcode
        }
    }
    func ok() {
        let mainVC = self.parent as? MainViewController
        mainVC?.okActionForRGB(rgbcode: rgbcode, r: rCode, g: gCode, b: bCode, tag: mainVC!.editingTag!)
        rgbcode = ""
        textLabel.text = "#"
    }
}
