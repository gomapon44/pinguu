//
//  selectPattern.swift
//  pinguu
//
//  Created by 五十嵐麻奈美 on 2019/07/04.
//  Copyright © 2019 mana. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SelectPattern: UIViewController {
    
    var bannerView = GADBannerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        if screenSize.height <= 568 {
            deviceIsSE = true
        }
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.frame = CGRect(x: 0, y: view.frame.height - bannerView.frame.height - UIApplication.shared.keyWindow!.safeAreaInsets.bottom, width: view.frame.width, height: bannerView.frame.height)
        if AdMobTest {
            bannerView.adUnitID = testBannerID
        } else {
            bannerView.adUnitID = mainBannerID
        }
        bannerView.rootViewController = self
        let bannerRequest = GADRequest()
        //bannerRequest.testDevices = testDevicesID
        bannerView.load(bannerRequest)
        self.view.addSubview(bannerView)
        
        UserDefaults.standard.register(defaults: ["input" : 1, "output" : 1, "label" : true, "size" : 2])
        inputMode = InputMode(rawValue: UserDefaults.standard.integer(forKey: "input"))!
        outputMode = OutputMode(rawValue: UserDefaults.standard.integer(forKey: "output"))!
        codeLabel = UserDefaults.standard.bool(forKey: "label")
        imageSize = ImageSize(rawValue: UserDefaults.standard.integer(forKey: "size"))!
    }
    
    override func viewDidLayoutSubviews() {
        bannerView.frame = adView.frame
    }
    
    let mainBannerID = "ca-app-pub-4242095333448986/4258379488"
    let testBannerID = "ca-app-pub-3940256099942544/2934735716"
    let AdMobTest: Bool = false
    
    @IBOutlet weak var adView: UIView!
    
    @IBAction func button1(_ sender: Any) {
        performSegue(withIdentifier: "toPattern1", sender: nil)
    }
    @IBAction func button2(_ sender: Any) {
        performSegue(withIdentifier: "toPattern2", sender: nil)
    }
    @IBAction func button3(_ sender: Any) {
        performSegue(withIdentifier: "toPattern3", sender: nil)
    }
    @IBAction func button4(_ sender: Any) {
        performSegue(withIdentifier: "toPattern4", sender: nil)
    }
    @IBAction func button5(_ sender: Any) {
        performSegue(withIdentifier: "toPattern5", sender: nil)
    }
    @IBAction func button6(_ sender: Any) {
        performSegue(withIdentifier: "toPattern6", sender: nil)
    }
    @IBAction func button7(_ sender: Any) {
        performSegue(withIdentifier: "toPattern7", sender: nil)
    }
    @IBAction func button8(_ sender: Any) {
        performSegue(withIdentifier: "toPattern8", sender: nil)
    }
    @IBAction func button9(_ sender: Any) {
        performSegue(withIdentifier: "toPattern9", sender: nil)
    }
    @IBAction func button12(_ sender: Any) {
        performSegue(withIdentifier: "toPattern12", sender: nil)
    }
    @IBAction func button16(_ sender: Any) {
        performSegue(withIdentifier: "toPattern16", sender: nil)
    }
    @IBAction func howTo(_ sender: Any) {
        performSegue(withIdentifier: "toHowTo", sender: nil)
    }
    
    @IBAction func returnTop(segue: UIStoryboardSegue) {}
}
