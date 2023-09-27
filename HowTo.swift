//
//  HowTo.swift
//  pinguu
//
//  Created by 五十嵐麻奈美 on 2019/07/24.
//  Copyright © 2019 mana. All rights reserved.
//

import UIKit

class HowTo: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNo = Int(scrollView.contentOffset.x/scrollView.frame.width)
        pageControll.currentPage = pageNo
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "returnTop", sender: nil)
    }
}

