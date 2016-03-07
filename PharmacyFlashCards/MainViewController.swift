//
//  MainViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class MainViewController: BaseUIViewController {

//
//    @IBOutlet weak var questionView: UIView!
//    
//    @IBOutlet weak var question: UIView!
//    
//    @IBOutlet weak var generic: UILabel!
//    
//    @IBOutlet weak var brand: UILabel!
//    
//    @IBOutlet weak var indication: UILabel!
//    
//    @IBOutlet weak var dosage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        self.questionView.layer.borderWidth = 1.0
//        self.questionView.layer.borderColor = UIColor.whiteColor().CGColor

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //@IBAction func test(sender: UIButton) {
        //DataPreloader.preloadData("test", withExtension: "csv", managedObjectContext: CoreDataStackManager.sharedManager)
        //DataPreloader.preloadData("test", withExtension: "csv", managedObjectContext: CoreDataStackManager.sharedManager.managedObject)
        
        //drugService?.preloadData();
   // }
    
    
//    @IBAction func GetAll(sender: UIButton) {
//        if let results = drugService?.selectAll(){
//            let test = results[0]
//            generic.text = test.generic
//            brand.text = test.brand
//            indication.text = test.indication
//            dosage.text = test.dosage
//        }
//    }
//    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
//        if segue.identifier == "OpenQuestionViewSegue"
//        {
//            if let destinationVC = segue.destinationViewController as? QuestionViewController{
//                destinationVC.allDrugs = drugService?.selectAll()
//                destinationVC.questionType = QuestionType.BrandName
//            }
//        }
    }
    
    
    // Private methods
//    func GetAll() -> [Drug]{
//        if let results = drugService?.selectAll(){
//            let test = results[0]
//            generic.text = test.generic
//            brand.text = test.brand
//            indication.text = test.indication
//            dosage.text = test.dosage
//        }
//        return results
//    }
    
}

