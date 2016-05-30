//
//  BaseResultsViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/29/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class BaseResultsViewController: BaseUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set records view
        //.... Set Right/Left Bar Button item
        let leftBarButton = UIBarButtonItem(
            title: "Main Menu",
            style: .Plain,
            target: self,
            action: #selector(ResultsViewController.showMainMenu(_:))
        )
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMainMenu"{
        }
    }
    
    func showMainMenu(sender: AnyObject?){
        performSegueWithIdentifier("showMainMenu", sender: sender)
    }
}
