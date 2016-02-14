//
//  QuestionViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class QuestionViewController: BaseUIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton1: UIButton!
    
    @IBOutlet weak var answerButton2: UIButton!
    
    @IBOutlet weak var answerButton3: UIButton!
    
    @IBOutlet weak var answerButton4: UIButton!
    
    
    var allDrugs:[Drug]?
    
    var questionType: QuestionType?
    
    var questionManager: QuestionManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionManager = QuestionManager(questionType: questionType!, allDrugs: allDrugs!, answerCount: 4)
        
 
        setQuestionLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button click events
    
    @IBAction func answerOneButtonPress(sender: UIButton) {
        performCheck(0)
    }
    
    @IBAction func answerTwoButtonPress(sender: UIButton) {
        performCheck(1)
    }

    @IBAction func answerThreeButtonPress(sender: UIButton) {
        performCheck(2)
    }
    
    @IBAction func answerFourButtonPress(sender: UIButton) {
        performCheck(3)
    }
    
    func setQuestionLabels(){
        let currentQuestion = self.questionManager?.getCurrentQuestion()
        
        questionLabel.text = currentQuestion?.correctDrug.brand
        
        let drugAnswerLabels: [String] = (currentQuestion?.getDrugAnswerLabels())!
        
        if(drugAnswerLabels.count >= 4){
            answerButton1.setTitle(drugAnswerLabels[0], forState: UIControlState.Normal)
            answerButton2.setTitle(drugAnswerLabels[1], forState: UIControlState.Normal)
            answerButton3.setTitle(drugAnswerLabels[2], forState: UIControlState.Normal)
            answerButton4.setTitle(drugAnswerLabels[3], forState: UIControlState.Normal)
        }
    }
    
    func performCheck(drugIndex: Int) -> Bool{
        var status = false
        let currentQuestion = self.questionManager?.getCurrentQuestion()
        let selectedDrug = currentQuestion?.getDrugByIndex(drugIndex)
        if self.questionManager != nil && !self.questionManager!.isAtLastQuestion() {
            if currentQuestion != nil && currentQuestion!.isCorrectDrug(selectedDrug!) {
                self.questionManager?.getNextQuestion()
                setQuestionLabels()
                status = true
            }else{
                status = false
                let alert = UIAlertController(title: "Wrong", message: "Wrong Drug. Try again.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Done", message: "Last Question Reached. Please go back to the menu", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        return status
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
