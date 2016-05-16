//
//  QuestionViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 1/23/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: BaseUIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton1: UIButton!
    
    @IBOutlet weak var answerButton2: UIButton!
    
    @IBOutlet weak var answerButton3: UIButton!
    
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBOutlet weak var fireView: UIView!
    
    @IBOutlet weak var fireIcon: UIImageView!
    
    @IBOutlet weak var streakCount: UILabel!
    
    var allDrugs:[Drug]?
    
    var questionType: QuestionType?
    
    var questionManager: QuestionManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionManager = QuestionManager(questionType: questionType!, allDrugs: allDrugs!, answerCount: 4)
        self.title = getTitleFromQuestionType(self.questionType!)
        setLabels()
        
        var localFont = UIFont(name: "Arial-BoldMT", size: 20)
        if(questionType == QuestionType.Indication){
            localFont = UIFont(name: "Arial-BoldMT", size: 17)
        }
        setButtonFont(localFont!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button click events
    
    @IBAction func answerOneButtonPress(sender: UIButton) {
        performCheck(0, sender: sender)
    }
    
    @IBAction func answerTwoButtonPress(sender: UIButton) {
        performCheck(1, sender: sender)
    }

    @IBAction func answerThreeButtonPress(sender: UIButton) {
        performCheck(2, sender: sender)
    }
    
    @IBAction func answerFourButtonPress(sender: UIButton) {
        performCheck(3, sender: sender)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showResultsScene"{
            if let resultsView = segue.destinationViewController as? ResultsViewController{
                resultsView.questionManager = self.questionManager
            }
        }
    }
    
    
    // Set labels for question and answers in the view
    private func setLabels(){
        let currentQuestion = self.questionManager?.getCurrentQuestion()
        
        questionLabel.text = currentQuestion?.getCorrectDrugLabel()
        
        let drugAnswerLabels: [String] = (currentQuestion?.getDrugAnswerLabels())!
        
        if(drugAnswerLabels.count >= 4){
            answerButton1.setTitle(drugAnswerLabels[0], forState: UIControlState.Normal)
            answerButton2.setTitle(drugAnswerLabels[1], forState: UIControlState.Normal)
            answerButton3.setTitle(drugAnswerLabels[2], forState: UIControlState.Normal)
            answerButton4.setTitle(drugAnswerLabels[3], forState: UIControlState.Normal)
        }
    }
    
    private func getTitleFromQuestionType(questionType: QuestionType) -> String{
        var title = ""
        switch (questionType){
        case .GenericName:
            title = "Quiz on Generics"
        case .BrandName:
            title = "Quiz on Brand"
        case .Classification:
            title = "Quiz on Classification"
        case .Dosage:
            title = "Quiz on Dosage"
        case .Indication:
            title = "Quiz on Indication"
        default:
            title = "Quiz"
        }
        return title
    }
    
    // check if user answer is correct
    // Yes -> move on to next question
    // No -> prompt user for correct answer
    private func performCheck(drugIndex: Int, sender: AnyObject) -> Bool{
        if self.questionManager == nil {
            return false;
        }
        
        var status = false
        let currentQuestion = self.questionManager?.getCurrentQuestion()
        
        if !self.questionManager!.isAtLastQuestion() {
            if currentQuestion != nil && currentQuestion!.isCorrectDrug(drugIndex) {
                self.questionManager?.getNextQuestion()
                self.questionManager?.incrementAnswerStreak()
                setLabels()
                status = true
                updateStreakView(true, streakNumber: self.questionManager?.answerStreak ?? 0)
            }else{
                status = false
                self.questionManager?.resetAnswerStreak()
                updateStreakView(false)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }else{
            // is at last question
            performSegueWithIdentifier("showResultsScene", sender: sender)
        }
        return status
    }
    
    // update streak by status
    // if status == true -> streak is displayed
    // else if status == false -> streak is hidden
    private func updateStreakView(status: Bool, streakNumber: Int=0){
        if status {
            // update number shown and show streak #
            streakCount.text = "\(streakNumber)"
            if fireView.hidden == true{
                fireView.hidden = false
            }
        }else{
            fireView.hidden = true
            streakCount.text = "0"
        }
    }
    
    private func setButtonFont(font: UIFont){
        answerButton1.titleLabel!.font = font
        answerButton2.titleLabel!.font = font
        answerButton3.titleLabel!.font = font
        answerButton4.titleLabel!.font = font
    }

}
