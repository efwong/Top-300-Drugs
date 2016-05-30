//
//  GameResultsViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/29/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class GameResultsViewController: BaseResultsViewController {

    var questionManager: QuestionManager?
    
    @IBOutlet weak var currentHighScoreLabel: UILabel!
    @IBOutlet weak var topHighScore1: UILabel!
    @IBOutlet weak var topHighScore2: UILabel!
    @IBOutlet weak var topHighScore3: UILabel!
    
    var highScores: [Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.highScores = ScoringService.service.getHighScores() ?? [Double]()
        let highScore:Double = questionManager?.getHighScore() ?? 0.0
        self.currentHighScoreLabel.text = highScore.ToStringWithPrecision(0, max: 0)
        UpdateHighScoreList()
        ScoringService.service.saveNewHighScore(highScore)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    @IBAction func OnReplay(sender: AnyObject) {
        performSegueWithIdentifier("showQuestionScene", sender: sender)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "showQuestionScene"{
            if let view = sender!.view as UIView?{
                // show questions
                let questionType:QuestionType? = QuestionUtility.getQuestionType(view)
                let isGameModeEnabled:Bool = true
                
                // grab new drug set
                let selectedDrugs = drugService?.selectByUserSettings()
                
                if questionType != nil {
                    
                    // Get the new view controller using segue.destinationViewController.
                    if let destinationVC = segue.destinationViewController as? QuestionViewController{
                        destinationVC.allDrugs = selectedDrugs
                        destinationVC.questionType = questionType
                        destinationVC.gameModeEnabled = isGameModeEnabled
                    }
                }
                
            }
        }
    }
 
    // MARK: Helpers
    private func UpdateHighScoreList(){
        self.topHighScore1.hidden = true
        self.topHighScore2.hidden = true
        self.topHighScore3.hidden = true
        
        if self.highScores?.count > 0 {
            self.topHighScore1.text = self.highScores![0].ToStringWithPrecision(0,max:0)
            self.topHighScore1.hidden = false
        }
        if self.highScores?.count > 1{
            self.topHighScore2.text = self.highScores![1].ToStringWithPrecision(0,max:0)
            self.topHighScore1.hidden = false
        }
        if self.highScores?.count > 2 {
            self.topHighScore3.text = self.highScores![2].ToStringWithPrecision(0,max:0)
            self.topHighScore3.hidden = false
        }
    }

}
