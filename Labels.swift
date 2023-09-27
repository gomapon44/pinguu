//
//  Labels.swift
//  pinguu
//
//  Created by 五十嵐麻奈美 on 2019/07/14.
//  Copyright © 2019 mana. All rights reserved.
//

import UIKit

class Labels: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
    }
    
    override func loadView() {
        if let view = UINib(nibName: "Labels", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    @IBOutlet weak var inputModeButton: DesignableButton!
    @IBOutlet weak var outputModeButton: DesignableButton!
    @IBOutlet weak var codeLabelButton: DesignableButton!
    @IBOutlet weak var imageSizeButton: DesignableButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var outputModeLabel: UILabel!
    @IBOutlet weak var selectPatternButton: DesignableButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func inputModeButton(_ sender: Any) {
        if inputMode == .HEX {
            inputMode = .RGB
            inputModeButton.setTitle("RGB", for: UIControl.State.normal)
        } else if inputMode == .RGB {
            inputMode = .HEX
            inputModeButton.setTitle("HEX", for: UIControl.State.normal)
        }
        UserDefaults.standard.set(inputMode.rawValue, forKey: "input")
    }
    @IBAction func outputModeButton(_ sender: Any) {
        if outputMode == .PNG {
            outputMode = .JPEG
            outputModeButton.setTitle("JPEG", for: UIControl.State.normal)
            outputModeLabel.text = ".jpg"
        } else if outputMode == .JPEG {
            outputMode = .PNG
            outputModeButton.setTitle("PNG", for: UIControl.State.normal)
            outputModeLabel.text = ".png"
        }
        UserDefaults.standard.set(outputMode.rawValue, forKey: "output")
    }
    @IBAction func codeLabelButton(_ sender: Any) {
        let parentVC = parent as? MainViewController
        if codeLabel == true {
            codeLabel = false
            codeLabelButton.setTitle("OFF", for: UIControl.State.normal)
            for label in parentVC!.codeLabels {
                label.isHidden = true
            }
        } else if codeLabel == false {
            codeLabel = true
            codeLabelButton.setTitle("ON", for: UIControl.State.normal)
            if (imageSize == .M) || (imageSize == .L) {
                for label in parentVC!.codeLabels {
                    if label.text != nil {
                        label.isHidden = false
                    }
                }
            }
        }
        UserDefaults.standard.set(codeLabel, forKey: "label")
    }
    @IBAction func imageSizeButton(_ sender: Any) {
        let parentVC = parent as? MainViewController
        if imageSize == .M {
            imageSize = .L
            imageSizeButton.setTitle("L", for: UIControl.State.normal)
        } else if imageSize == .L {
            imageSize = .S
            imageSizeButton.setTitle("S", for: UIControl.State.normal)
            for label in parentVC!.codeLabels {
                label.isHidden = true
            }
        } else if imageSize == .S {
            imageSize = .M
            imageSizeButton.setTitle("M", for: UIControl.State.normal)
            if codeLabel == true {
                for label in parentVC!.codeLabels {
                    if label.text != nil {
                        label.isHidden = false
                    }
                }
            }
        }
        UserDefaults.standard.set(imageSize.rawValue, forKey: "size")
    }
    @IBAction func selectPatternButton(_ sender: Any) {
        let parentVC = parent as? MainViewController
        if isMultiTasking == false {
            parentVC?.playInterstitial()
        } else {
            parentVC?.performSegue(withIdentifier: "returnTop", sender: nil)
        }
    }
    @IBAction func saveButton(_ sender: Any) {
        let parentVC = parent as? MainViewController
        parentVC!.saveButtonAction()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
