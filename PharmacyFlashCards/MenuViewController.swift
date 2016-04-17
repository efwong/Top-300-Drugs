//
//  MenuViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 4/2/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class MenuViewController: BaseUIViewController {

    //var menuItemArray: [UIView] = []
    
    @IBOutlet weak var menuItemGeneric: UIView!
    
    @IBOutlet weak var menuItemBrand: UIView!
    
    @IBOutlet weak var menuItemClassification: UIView!
    
    @IBOutlet weak var menuItemDosage: UIView!
    
    @IBOutlet weak var menuItemIndication: UIView!
    
    @IBOutlet weak var menuItemSettings: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // menuItemArray += [menuItemGeneric, menuItemBrand, menuItemClassification, menuItemDosage, menuItemIndication, menuItemSettings]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let view = sender!.view as UIView!
        
        if segue.identifier == "showSettingsScene"{
            
        }else{
            let questionType:QuestionType? = getQuestionType(view)
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            let selectedDrugs = drugService?.selectByUserSettings()
            
            if questionType != nil {
                if let destinationVC = segue.destinationViewController as? QuestionViewController{
                    destinationVC.allDrugs = selectedDrugs
                    destinationVC.questionType = questionType
                }
            }
        }
    }
    
    
    @IBAction func showQuestionScene(sender: AnyObject) {
        performSegueWithIdentifier("showQuestionScene", sender: sender)
    }
    
    @IBAction func showSettingsScene(sender: AnyObject) {
        performSegueWithIdentifier("showSettingsScene", sender: sender)
    }
    
    private func getQuestionType(view: UIView) -> QuestionType?{
        var questionType: QuestionType? = nil
        if view == menuItemGeneric {
            questionType = QuestionType.GenericName
        }
        else if view == menuItemBrand {
            questionType = QuestionType.BrandName
        }
        else if view == menuItemClassification {
            questionType = QuestionType.Classification
        }
        else if view == menuItemDosage {
            questionType = QuestionType.Dosage
        }
        else if view == menuItemIndication{
            questionType = QuestionType.Indication
        }else{
            // is settings
        }
        return questionType
    }
//    private func getQuestionType(segueIdentifier: String) -> QuestionType?{
//        var questionType: QuestionType? = nil
//        switch(segueIdentifier){
//        case "GenericQuestionSegue":
//            questionType = QuestionType.GenericName
//        case "BrandQuestionSegue":
//            questionType = QuestionType.BrandName
//        case "ClassificationQuestionSegue":
//            questionType = QuestionType.Classification
//        case "DosageQuestionSegue":
//            questionType = QuestionType.Dosage
//        case "IndicationQuestionSegue":
//            questionType = QuestionType.Indication
//        default:
//            questionType = nil
//        }
//        return questionType
//    }
}
