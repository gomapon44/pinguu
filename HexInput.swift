//
//  HexInputViewController.swift
//  pinguu
//
//  Created by 五十嵐麻奈美 on 2019/06/27.
//  Copyright © 2019 mana. All rights reserved.
//

import UIKit

class HexInput: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = "#"
    }
    
    override func loadView() {
        if let view = UINib(nibName: "HexInput", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    var hexcode: String = ""
    
    func tappedButton(key: String) {
        if hexcode.count < 6 {
            hexcode += key
            textLabel.text = "#" + hexcode
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
    @IBAction func buttonA(_ sender: Any) {
        tappedButton(key: "A")
    }
    @IBAction func buttonB(_ sender: Any) {
        tappedButton(key: "B")
    }
    @IBAction func buttonC(_ sender: Any) {
        tappedButton(key: "C")
    }
    @IBAction func buttonD(_ sender: Any) {
        tappedButton(key: "D")
    }
    @IBAction func buttonE(_ sender: Any) {
        tappedButton(key: "E")
    }
    @IBAction func buttonF(_ sender: Any) {
        tappedButton(key: "F")
    }
    @IBAction func buttonDelete(_ sender: Any) {
        hexcode = ""
        textLabel.text = "#"
    }
    
    @IBAction func buttonOK(_ sender: Any) {
        if hexcode.count == 6 {
            let mainVC = self.parent as? MainViewController
            mainVC?.okActionForHex(hexcode: hexcode, tag: mainVC!.editingTag!)
            hexcode = ""
            textLabel.text = "#"
        }
    }
    
    @IBAction func buttonBackSpace(_ sender: Any) {
        var num = hexcode.count
        if num != 0 {
            num -= 1
            hexcode = String(hexcode.prefix(num))
            textLabel.text = "#" + hexcode
        }
    }
    

}
