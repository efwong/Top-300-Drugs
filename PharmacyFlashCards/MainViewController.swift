//
//  MainViewController.swift
//  Top300AppliedDrugs
//
//  Created by Edwin Wong on 6/19/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit
import iAd

class MainViewController: BaseUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
