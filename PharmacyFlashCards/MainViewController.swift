//
//  MainViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {


    @IBOutlet weak var questionView: UIView!
    
    var pharmQuestionService: PharmQuestionService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // load services
        pharmQuestionService = PharmQuestionService(dataRepository: PharmQuestionRepository())
        
        
        self.questionView.layer.borderWidth = 1.0
        self.questionView.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func test(sender: UIButton) {
        DataPreloader.preloadData("test", withExtension: "csv")
    }
}

