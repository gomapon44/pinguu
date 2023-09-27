//
//  MainViewController.swift
//  pinguu
//
//  Created by 五十嵐麻奈美 on 2019/07/15.
//  Copyright © 2019 mana. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainViewController: UIViewController, UITextFieldDelegate, GADInterstitialDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if deviceIsSE == true {
            labelsToSpacing2Constraint.constant = 0
            spacing3ToHexConstraint.isActive = false
            hexToSpacing2Constraint.isActive = false
            spacingView3.topAnchor.constraint(equalTo: labels.bottomAnchor).isActive = true
            hexInputView.centerYAnchor.constraint(equalTo: previewView.centerYAnchor).isActive = true
        }
        
        interstitialView = createAndLoadInterstitial()
        GADMobileAds.sharedInstance().applicationMuted = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureObserver()
        
        hexInputView.isHidden = true
        rgbInputView.isHidden = true
        
        for label in codeLabels {
            label.isHidden = true
        }
        
        let childVC = children[0] as? Labels
        if inputMode == .HEX {
            childVC!.inputModeButton.setTitle("HEX", for: UIControl.State.normal)
        } else if inputMode == .RGB {
            childVC!.inputModeButton.setTitle("RGB", for: UIControl.State.normal)
        }
        
        if outputMode == .PNG {
            childVC!.outputModeButton.setTitle("PNG", for: UIControl.State.normal)
            childVC!.outputModeLabel.text = ".png"
        } else if outputMode == .JPEG {
            childVC!.outputModeButton.setTitle("JPEG", for: UIControl.State.normal)
            childVC!.outputModeLabel.text = ".jpg"
        }
        
        if codeLabel == true {
            childVC!.codeLabelButton.setTitle("ON", for: UIControl.State.normal)
        } else if codeLabel == false {
            childVC!.codeLabelButton.setTitle("OFF", for: UIControl.State.normal)
        }
        
        if imageSize == .S {
            childVC!.imageSizeButton.setTitle("S", for: UIControl.State.normal)
        } else if imageSize == .M {
            childVC!.imageSizeButton.setTitle("M", for: UIControl.State.normal)
        } else if imageSize == .L {
            childVC!.imageSizeButton.setTitle("L", for: UIControl.State.normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        appWidth = view.bounds.width
        if appWidth < deviceWidth {
            isMultiTasking = true
        } else {
            isMultiTasking = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        if AdMobTest {
            interstitialView = GADInterstitial(adUnitID: testInterstitialMovieID)
        } else {
            interstitialView = GADInterstitial(adUnitID: mainInterstitialID)
        }
        let interstitialRequest = GADRequest()
        //interstitialRequest.testDevices = testDevicesID
        interstitialView.delegate = self
        interstitialView.load(interstitialRequest)
        return interstitialView
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitialView = createAndLoadInterstitial()
        performSegue(withIdentifier: "returnTop", sender: nil)
    }
    
    func playInterstitial() {
        if interstitialView.isReady {
            interstitialView.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
            performSegue(withIdentifier: "returnTop", sender: nil)
        }
    }
    
    var interstitialView: GADInterstitial!
    let mainInterstitialID = "ca-app-pub-4242095333448986/5023384986"
    let testInterstitialID = "ca-app-pub-3940256099942544/4411468910"
    let testInterstitialMovieID = "ca-app-pub-3940256099942544/5135589807"
    let AdMobTest: Bool = false
    
    var editingTag: Int? = nil
    var keyboardIsShown: Bool = false
    
    @IBOutlet var codeLabels: [UILabel]!
    
    @IBOutlet var previews: [UIButton]!
    
    @IBAction func previews(_ sender: UIButton) {
        let childVC = children[0] as? Labels
        editingTag = sender.tag
        for prev in previews {
            if prev.tag == editingTag {
                prev.borderColor = myRed
                prev.borderWidth = 2
            } else {
                prev.isEnabled = false
            }
        }
        if inputMode == .HEX {
            hexInputView.isHidden = false
        } else if inputMode == .RGB {
            rgbInputView.isHidden = false
        }
        childVC!.inputModeButton.isEnabled = false
        childVC!.outputModeButton.isEnabled = false
        childVC!.codeLabelButton.isEnabled = false
        childVC!.imageSizeButton.isEnabled = false
        childVC!.titleTextField.isEnabled = false
        childVC!.selectPatternButton.isEnabled = false
        childVC!.saveButton.isEnabled = false
        editing = true
    }
    
    @IBOutlet weak var hexInputView: DesignableView!
    @IBOutlet weak var rgbInputView: UIView!
    @IBOutlet weak var previewView: DesignableView!
    @IBOutlet weak var labels: UIView!
    @IBOutlet weak var spacingView3: UIView!
    @IBOutlet weak var labelsToSpacing2Constraint: NSLayoutConstraint!
    @IBOutlet weak var spacing3ToHexConstraint: NSLayoutConstraint!
    @IBOutlet weak var hexToSpacing2Constraint: NSLayoutConstraint!
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        let childVC = children[0] as? Labels
        view.endEditing(true)
        if editing {
            if inputMode == .HEX {
                cancelActionForHex()
            } else {
                cancelActionForRGB()
            }
            childVC!.inputModeButton.isEnabled = true
            childVC!.outputModeButton.isEnabled = true
            childVC!.codeLabelButton.isEnabled = true
            childVC!.imageSizeButton.isEnabled = true
            childVC!.titleTextField.isEnabled = true
            childVC!.selectPatternButton.isEnabled = true
            childVC!.saveButton.isEnabled = true
        }
    }
    
    func saveButtonAction() {
        let childVC = children[0] as? Labels
        let viewImage = previewView.getImage(previewView)
        if outputMode == .PNG {
            let fileName = childVC!.titleTextField.text
            if fileName != "" {
                savePNGImage(image: viewImage, fileName: fileName!)
            } else if fileName == "" {
                savePNGImage(image: viewImage, fileName: "NoTitle")
            }
        } else if outputMode == .JPEG {
            let fileName = childVC!.titleTextField.text
            if fileName != "" {
                saveJPGImage(image: viewImage, fileName: fileName!)
            } else if fileName == "" {
                saveJPGImage(image: viewImage, fileName: "NoTitle")
            }
        }
    }
    
    func savePNGImage (image: UIImage, fileName: String) {
        let pngImageData = image.pngData()
        let fm = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let filePath = documentsPath + "/" + fileName + ".png"
        print(filePath)
        if !fm.fileExists(atPath: filePath) {
            fm.createFile(atPath: filePath, contents: pngImageData, attributes: [:])
            saveAlert()
        } else {
            let alert = UIAlertController(title: nil, message: "ファイル名が重複しています", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "上書きする",
                    style: .destructive,
                    handler: {(action) -> Void in
                        self.overwritePNG(filePath: filePath, pngImageData: pngImageData!)
                        self.saveAlert()
                })
            )
            alert.addAction(
                UIAlertAction(
                    title: "キャンセル",
                    style: .cancel,
                    handler: nil)
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func saveJPGImage (image: UIImage, fileName: String) {
        let jpgImageData = image.jpegData(compressionQuality: 1)
        let fm = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let filePath = documentsPath + "/" + fileName + ".jpg"
        if !fm.fileExists(atPath: filePath) {
            fm.createFile(atPath: filePath, contents: jpgImageData, attributes: [:])
            saveAlert()
        } else {
            let alert = UIAlertController(title: nil, message: "ファイル名が重複しています", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "上書きする",
                    style: .destructive,
                    handler: {(action) -> Void in
                        self.overwriteJPG(filePath: filePath, jpgImageData: jpgImageData!)
                        self.saveAlert()
                })
            )
            alert.addAction(
                UIAlertAction(
                    title: "キャンセル",
                    style: .cancel,
                    handler: nil)
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func saveAlert() {
        let alert = UIAlertController(title: nil, message: "保存しました。", preferredStyle: .alert)
        self.present(alert, animated: true, completion:{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    func overwritePNG (filePath: String, pngImageData: Data) {
        let fm = FileManager.default
        do {
            try fm.removeItem(atPath: filePath)
        } catch {
            print("削除失敗")
        }
        fm.createFile(atPath: filePath, contents: pngImageData, attributes: [:])
    }
    
    func overwriteJPG (filePath: String, jpgImageData: Data) {
        let fm = FileManager.default
        do {
            try fm.removeItem(atPath: filePath)
        } catch {
            print("削除失敗")
        }
        fm.createFile(atPath: filePath, contents: jpgImageData, attributes: [:])
    }
    
    func cancelActionForHex() {
        let childVC = children[1] as! HexInput
        childVC.hexcode = ""
        childVC.textLabel.text = "#"
        hexInputView.isHidden = true
        for prev in previews {
            if prev.tag == editingTag {
                prev.borderColor = myGlay
                prev.borderWidth = 0.5
            } else {
                prev.isEnabled = true
            }
        }
        editingTag = nil
        editing = false
    }
    
    func cancelActionForRGB() {
        let childVC = children[2] as! RgbInput
        childVC.rgbcode = ""
        childVC.textLabel.text = ""
        rgbInputView.isHidden = true
        for prev in previews {
            if prev.tag == editingTag {
                prev.borderColor = myGlay
                prev.borderWidth = 0.5
            } else {
                prev.isEnabled = true
            }
        }
        editingTag = nil
        editing = false
    }
    
    func okActionForHex(hexcode: String, tag: Int) {
        let childVC = children[0] as? Labels
        for prev in previews {
            if prev.tag == tag {
                if prev.imageView?.image != nil {
                    prev.imageView?.removeFromSuperview()
                }
                prev.backgroundColor = UIColor(hex: hexcode)
                prev.borderColor = myGlay
                prev.borderWidth = 0.5
                if (codeLabel == true) && (imageSize == .M) {
                    for label in codeLabels {
                        if label.tag == editingTag {
                            label.text = "#" + hexcode
                            label.isHidden = false
                        }
                    }
                } else if (codeLabel == true) && (imageSize == .L) {
                    for label in codeLabels {
                        if label.tag == editingTag {
                            label.text = "#" + hexcode
                            label.isHidden = false
                        }
                    }
                }
            } else {
                prev.isEnabled = true
            }
        }
        if tag == 1 {
            childVC!.titleTextField.text = "#" + hexcode
        }
        editingTag = nil
        hexInputView.isHidden = true
        childVC!.inputModeButton.isEnabled = true
        childVC!.outputModeButton.isEnabled = true
        childVC!.codeLabelButton.isEnabled = true
        childVC!.imageSizeButton.isEnabled = true
        childVC!.titleTextField.isEnabled = true
        childVC!.selectPatternButton.isEnabled = true
        childVC!.saveButton.isEnabled = true
        editing = false
    }
    
    func okActionForRGB(rgbcode: String, r: String, g: String, b: String, tag: Int) {
        let childVC = children[0] as? Labels
        for prev in previews {
            if prev.tag == tag {
                if prev.imageView?.image != nil {
                    prev.imageView?.removeFromSuperview()
                }
                prev.backgroundColor = UIColor(rgbcode: rgbcode)
                prev.borderColor = myGlay
                prev.borderWidth = 0.5
                if (codeLabel == true) && (imageSize == .M) {
                    for label in codeLabels {
                        if label.tag == editingTag {
                            label.text = "#" + r + g + b
                            label.isHidden = false
                        }
                    }
                } else if (codeLabel == true) && (imageSize == .L) {
                    for label in codeLabels {
                        if label.tag == editingTag {
                            label.text = "#" + r + g + b
                            label.isHidden = false
                        }
                    }
                }
            } else {
                prev.isEnabled = true
            }
        }
        if tag == 1 {
            childVC!.titleTextField.text = "#" + r + g + b
        }
        editingTag = nil
        rgbInputView.isHidden = true
        childVC!.inputModeButton.isEnabled = true
        childVC!.outputModeButton.isEnabled = true
        childVC!.codeLabelButton.isEnabled = true
        childVC!.imageSizeButton.isEnabled = true
        childVC!.titleTextField.isEnabled = true
        childVC!.selectPatternButton.isEnabled = true
        childVC!.saveButton.isEnabled = true
        editing = false
    }
    
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        let childVC = children[0] as? Labels
        childVC!.inputModeButton.isEnabled = false
        childVC!.outputModeButton.isEnabled = false
        childVC!.codeLabelButton.isEnabled = false
        childVC!.imageSizeButton.isEnabled = false
        childVC!.saveButton.isEnabled = false
        childVC!.selectPatternButton.isEnabled = false
        if keyboardIsShown == false {
            keyboardIsShown = true
            let userInfo = notification?.userInfo
            let keyboardSize = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let idealHeight = view.frame.size.height - keyboardSize.height - 100
            let presentHeight = labels.frame.origin.y + 100
            if presentHeight > idealHeight {
                let moveValue = presentHeight - idealHeight
                UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - moveValue, width: self.view.bounds.width, height: self.view.bounds.height)}, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        let childVC = children[0] as? Labels
        keyboardIsShown = false
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)}, completion: nil)
        childVC!.inputModeButton.isEnabled = true
        childVC!.outputModeButton.isEnabled = true
        childVC!.codeLabelButton.isEnabled = true
        childVC!.imageSizeButton.isEnabled = true
        childVC!.saveButton.isEnabled = true
        childVC!.selectPatternButton.isEnabled = true
    }
}
