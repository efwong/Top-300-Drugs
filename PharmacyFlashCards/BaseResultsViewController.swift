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
            style: .plain,
            target: self,
            action: #selector(ResultsViewController.showMainMenu(_:))
        )
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMainMenu"{
        }
    }
    
    func showMainMenu(_ sender: AnyObject?){
        performSegue(withIdentifier: "showMainMenu", sender: sender)
    }
}
