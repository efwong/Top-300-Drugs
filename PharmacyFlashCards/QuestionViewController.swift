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
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    @IBOutlet weak var currentScoreView: UIView!
    
    var allDrugs:[Drug]?
    
    var questionType: QuestionType?
    
    var questionManager: QuestionManager?
    var gameModeEnabled: Bool?
    var timer: Timer = Timer()
    var startTime: TimeInterval?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionManager = QuestionManager(questionType: questionType!, allDrugs: allDrugs!, answerCount: 4, gameModeEnabled: (self.gameModeEnabled != nil) ? self.gameModeEnabled! : false)
        
        self.updateQuestionTypeDependentVariables()
        
        
        // show Game mode Instructions
        self.setUpTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button click events
    
    @IBAction func answerOneButtonPress(_ sender: UIButton) {
        performCheck(0, sender: sender)
    }
    
    @IBAction func answerTwoButtonPress(_ sender: UIButton) {
        performCheck(1, sender: sender)
    }

    @IBAction func answerThreeButtonPress(_ sender: UIButton) {
        performCheck(2, sender: sender)
    }
    
    @IBAction func answerFourButtonPress(_ sender: UIButton) {
        performCheck(3, sender: sender)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showResultsScene"{
            let totalSeconds :Int = Int(Date.timeIntervalSinceReferenceDate - self.startTime!)
            if let resultsView = segue.destination as? ResultsViewController{
                resultsView.questionManager = self.questionManager
                resultsView.totalSeconds = totalSeconds
            }
        }else if (segue.identifier == "showGameResultsScene"){
            if let gameResultsView = segue.destination as? GameResultsViewController{
                gameResultsView.questionManager = self.questionManager
            }
        }
    }
    
    // check if user answer is correct
    // Yes -> move on to next question
    // No -> prompt user for correct answer
    fileprivate func performCheck(_ drugIndex: Int, sender: AnyObject) -> Void{ // Bool
        if self.questionManager == nil {
            return // false;
        }
        
        // var status = false // answered correctly status
        let currentQuestion = self.questionManager?.getCurrentQuestion()
        self.questionType = self.questionManager?.questionType
        if !self.questionManager!.isAtLastQuestion() {
            if currentQuestion != nil && currentQuestion!.isCorrectDrug(drugIndex) {
                self.questionManager?.updateScores()
                self.questionManager?.getNextQuestion()
                updateQuestionTypeDependentVariables()
                // status = true
                updateStreakView(true, streakNumber: self.questionManager?.getAnswerStreak() ?? 0)
                updateScoringView(true, highScore: self.questionManager?.getHighScore() ?? 0)
            }else{
                // status = false
                self.questionManager?.resetAnswerStreak()
                updateStreakView(false)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }else{
            // is at last question
            if(self.gameModeEnabled != nil && self.gameModeEnabled!){
                performSegue(withIdentifier: "showGameResultsScene", sender: sender)
            }else{
                performSegue(withIdentifier: "showResultsScene", sender: sender)
            }
        }
        return // status
    }
    
    // update streak by status
    // if status == true -> streak is displayed
    // else if status == false -> streak is hidden
    fileprivate func updateStreakView(_ status: Bool, streakNumber: Int=0){
        if status {
            // update number shown and show streak #
            streakCount.text = "\(streakNumber)"
            if fireView.isHidden == true{
                fireView.isHidden = false
            }
        }else{
            fireView.isHidden = true
            streakCount.text = "0"
        }
    }
    
    fileprivate func updateScoringView(_ status: Bool, highScore: Double){
        if status{
            currentScoreLabel.text = highScore.ToStringWithPrecision(0, max: 0)
        }
    }
    
    // MARK: Methods to run when updating quesitonType
    
    fileprivate func updateQuestionTypeDependentVariables(){
        updateQuestionType()
        setTitleFromQuestionType()
        setLabels()
        updateFonts()
    }
    
    // Updates question type if game mode is enabled
    fileprivate func updateQuestionType(){
        if (self.gameModeEnabled != nil && self.gameModeEnabled == true) {
            self.questionType = questionManager?.getQuestionType()
            self.currentScoreView.isHidden = false
        }else{
            self.currentScoreView.isHidden = true
        }
    }
    
    // update title
    fileprivate func setTitleFromQuestionType() {
        var title = ""
        switch (self.questionType!){
        case .genericName:
            title = "Generics Question"
        case .brandName:
            title = "Brand Question"
        case .classification:
            title = "Classification Question"
        case .dosage:
            title = "Dosage Question"
        case .indication:
            title = "Indication Question"
//        default:
//            title = "Quiz"
        }
        self.title = title
    }
    
    // Set labels for question and answers in the view
    fileprivate func setLabels(){
        let currentQuestion = self.questionManager?.getCurrentQuestion()
        
        questionLabel.text = currentQuestion?.getCorrectDrugLabel()
        
        let drugAnswerLabels: [String] = (currentQuestion?.getDrugAnswerLabels())!
        
        if(drugAnswerLabels.count >= 4){
            answerButton1.setTitle(drugAnswerLabels[0], for: UIControlState())
            answerButton2.setTitle(drugAnswerLabels[1], for: UIControlState())
            answerButton3.setTitle(drugAnswerLabels[2], for: UIControlState())
            answerButton4.setTitle(drugAnswerLabels[3], for: UIControlState())
        }
    }
    
    // update fonts
    fileprivate func updateFonts(){
        //if UIScreen.mainScreen().nativeBounds.height <= 960.0 {
        switch UIScreen.main.nativeBounds.height {
        case 960:
                // iphone 4s height
                questionLabel.font = questionLabel.font.withSize(20)
                answerButton1.titleLabel!.font  = answerButton1.titleLabel!.font.withSize(14)
                answerButton2.titleLabel!.font  = answerButton2.titleLabel!.font.withSize(14)
                answerButton3.titleLabel!.font  = answerButton3.titleLabel!.font.withSize(14)
                answerButton4.titleLabel!.font  = answerButton4.titleLabel!.font.withSize(14)
        
        case 1136:
            // iphone 5
            questionLabel.font = questionLabel.font.withSize(25)
            answerButton1.titleLabel!.font  = answerButton1.titleLabel!.font.withSize(16)
            answerButton2.titleLabel!.font  = answerButton2.titleLabel!.font.withSize(16)
            answerButton3.titleLabel!.font  = answerButton3.titleLabel!.font.withSize(16)
            answerButton4.titleLabel!.font  = answerButton4.titleLabel!.font.withSize(16)
            
        default:
            var localFont = UIFont(name: "Helvetica", size: 20)
            if(self.questionType == QuestionType.indication){
                localFont = UIFont(name: "Helvetica", size: 17)
            }
            
            answerButton1.titleLabel!.font = localFont
            answerButton2.titleLabel!.font = localFont
            answerButton3.titleLabel!.font = localFont
            answerButton4.titleLabel!.font = localFont
        }
    }
    
    // MARK: Timer methods
    
    fileprivate func setUpTimer(){
        if (self.gameModeEnabled != nil && self.gameModeEnabled!) {
            guard let timeLimit = (CommonUtility.service.AppConfig?["GameTimeLimit"] as AnyObject).int32Value else{
                timer.invalidate()
                return
            }
            let seconds = timeLimit % 60
            let minutes = (timeLimit / 60) % 60
            currentTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            // show instructions once
            if UserSettingsService.service.isGameInstructionsHidden() == false {
                let alert = UIAlertController(title: "Instructions", message: "Please tap the best answer.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
                    (action: UIAlertAction!) in
                    // start timer
                    self.startTime = Date.timeIntervalSinceReferenceDate
                    
                    // begin count down from 60
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                        target: self,
                        selector: #selector(QuestionViewController.countDown),
                        userInfo: nil,
                        repeats: true)
                    
                    UserSettingsService.service.hideGameInstructions()
                    
                    })
                self.present(alert, animated: true, completion: nil)
            }else{
                // start timer immediately
                self.startTime = Date.timeIntervalSinceReferenceDate
                
                // begin count down from 60
                self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                                                    target: self,
                                                                    selector: #selector(QuestionViewController.countDown),
                                                                    userInfo: nil,
                                                                    repeats: true)
            }
        }
        else{
            // start timer
            self.startTime = Date.timeIntervalSinceReferenceDate
            currentTimeLabel.text = String(format: "%02d:%02d", 0, 0)
            // count up
            self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                                                target: self,
                                                                selector: #selector(QuestionViewController.countUp),
                                                                userInfo: nil,
                                                                repeats: true)
        }
    }
    
    // CountUp: increment timer
    @objc func countUp(_ timer: Timer) {
        if self.startTime != nil{
            let currentDuration = Int(Date.timeIntervalSinceReferenceDate - self.startTime!)
            let seconds = currentDuration % 60
            let minutes = (currentDuration / 60) % 60
            currentTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    // For game mode, count down from 45
    @objc func countDown(_ timer: Timer){
        if self.startTime != nil{
            
            guard let timeLimit = (CommonUtility.service.AppConfig?["GameTimeLimit"] as AnyObject).int32Value else{
                timer.invalidate()
                return
            }
            
            let currentDuration = timeLimit - Int32(Date.timeIntervalSinceReferenceDate - self.startTime!)
            let seconds = (currentDuration % 60)
            let minutes = (currentDuration / 60) % 60
            currentTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            
            // time out after 45 secs
            if(currentDuration <= 0) {
                timer.invalidate()
                performSegue(withIdentifier: "showGameResultsScene", sender: self)
            }
        }
    }

}
