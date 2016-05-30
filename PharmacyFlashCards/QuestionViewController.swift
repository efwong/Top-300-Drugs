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
    var timer: NSTimer = NSTimer()
    var startTime: NSTimeInterval?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionManager = QuestionManager(questionType: questionType!, allDrugs: allDrugs!, answerCount: 4, gameModeEnabled: (self.gameModeEnabled != nil) ? self.gameModeEnabled! : false)
        
        updateQuestionTypeDependentVariables()
        
        // start timer
        self.startTime = NSDate.timeIntervalSinceReferenceDate()
        
        // sets timer depending on gameMode
        setUpTimer()
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
            let totalSeconds :Int = Int(NSDate.timeIntervalSinceReferenceDate() - self.startTime!)
            if let resultsView = segue.destinationViewController as? ResultsViewController{
                resultsView.questionManager = self.questionManager
                resultsView.totalSeconds = totalSeconds
            }
        }else if (segue.identifier == "showGameResultsScene"){
            if let gameResultsView = segue.destinationViewController as? GameResultsViewController{
                gameResultsView.questionManager = self.questionManager
            }
        }
    }
    
    // check if user answer is correct
    // Yes -> move on to next question
    // No -> prompt user for correct answer
    private func performCheck(drugIndex: Int, sender: AnyObject) -> Bool{
        if self.questionManager == nil {
            return false;
        }
        
        var status = false // answered correctly status
        let currentQuestion = self.questionManager?.getCurrentQuestion()
        self.questionType = self.questionManager?.questionType
        if !self.questionManager!.isAtLastQuestion() {
            if currentQuestion != nil && currentQuestion!.isCorrectDrug(drugIndex) {
                self.questionManager?.updateScores()
                self.questionManager?.getNextQuestion()
                updateQuestionTypeDependentVariables()
                status = true
                updateStreakView(true, streakNumber: self.questionManager?.getAnswerStreak() ?? 0)
                updateScoringView(true, highScore: self.questionManager?.getHighScore() ?? 0)
            }else{
                status = false
                self.questionManager?.resetAnswerStreak()
                updateStreakView(false)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }else{
            // is at last question
            if(self.gameModeEnabled != nil && self.gameModeEnabled!){
                performSegueWithIdentifier("showGameResultsScene", sender: sender)
            }else{
                performSegueWithIdentifier("showResultsScene", sender: sender)
            }
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
    
    private func updateScoringView(status: Bool, highScore: Double){
        if status{
            currentScoreLabel.text = highScore.ToStringWithPrecision(0, max: 0)
        }
    }
    
    // MARK: Methods to run when updating quesitonType
    
    private func updateQuestionTypeDependentVariables(){
        updateQuestionType()
        setTitleFromQuestionType()
        setLabels()
        updateFonts()
    }
    
    // Updates question type if game mode is enabled
    private func updateQuestionType(){
        if (self.gameModeEnabled != nil && self.gameModeEnabled == true) {
            self.questionType = questionManager?.getQuestionType()
            self.currentScoreView.hidden = false
        }else{
            self.currentScoreView.hidden = true
        }
    }
    
    // update title
    private func setTitleFromQuestionType() {
        var title = ""
        switch (self.questionType!){
        case .GenericName:
            title = "Generics Question"
        case .BrandName:
            title = "Brand Question"
        case .Classification:
            title = "Classification Question"
        case .Dosage:
            title = "Dosage Question"
        case .Indication:
            title = "Indication Question"
        default:
            title = "Quiz"
        }
        self.title = title
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
    
    // update fonts
    private func updateFonts(){
        var localFont = UIFont(name: "Arial-BoldMT", size: 20)
        if(self.questionType == QuestionType.Indication){
            localFont = UIFont(name: "Arial-BoldMT", size: 17)
        }
        
        answerButton1.titleLabel!.font = localFont
        answerButton2.titleLabel!.font = localFont
        answerButton3.titleLabel!.font = localFont
        answerButton4.titleLabel!.font = localFont
    }
    
    
    // MARK: Timer methods
    
    private func setUpTimer(){
        if (self.gameModeEnabled != nil && self.gameModeEnabled!) {
            guard let timeLimit = CommonUtility.service.AppConfig?["GameTimeLimit"]?.integerValue else{
                timer.invalidate()
                return
            }
            let seconds = timeLimit % 60
            let minutes = (timeLimit / 60) % 60
            currentTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            // count down from 60
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                                                                target: self,
                                                                selector: #selector(QuestionViewController.countDown),
                                                                userInfo: nil,
                                                                repeats: true)
        }
        else{
            currentTimeLabel.text = String(format: "%02d:%02d", 0, 0)
            // count up
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                                                                target: self,
                                                                selector: #selector(QuestionViewController.countUp),
                                                                userInfo: nil,
                                                                repeats: true)
        }
    }
    
    // CountUp: increment timer
    @objc func countUp(timer: NSTimer) {
        if self.startTime != nil{
            let currentDuration = Int(NSDate.timeIntervalSinceReferenceDate() - self.startTime!)
            let seconds = currentDuration % 60
            let minutes = (currentDuration / 60) % 60
            currentTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            
            guard let timeLimit = CommonUtility.service.AppConfig?["GameTimeLimit"]?.integerValue else{
                timer.invalidate()
                return
            }
            
            // time out after 45 secs
            if(currentDuration >= timeLimit) {
                timer.invalidate()
                performSegueWithIdentifier("showResultsScene", sender: self)
            }
        }
    }
    
    // For game mode, count down from 45
    @objc func countDown(timer: NSTimer){
        if self.startTime != nil{
            
            guard let timeLimit = CommonUtility.service.AppConfig?["GameTimeLimit"]?.integerValue else{
                timer.invalidate()
                return
            }
            
            let currentDuration = timeLimit - Int(NSDate.timeIntervalSinceReferenceDate() - self.startTime!)
            let seconds = (currentDuration % 60)
            let minutes = (currentDuration / 60) % 60
            currentTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            
            // time out after 45 secs
            if(currentDuration <= 0) {
                timer.invalidate()
                performSegueWithIdentifier("showResultsScene", sender: self)
            }
        }
    }

}
