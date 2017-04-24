//
//  GameResultsViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/29/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class GameResultsViewController: BaseResultsViewController {

    var questionManager: QuestionManager?
    
    @IBOutlet weak var currentHighScoreLabel: UILabel!
    @IBOutlet weak var topHighScore1: UILabel!
    @IBOutlet weak var topHighScore2: UILabel!
    @IBOutlet weak var topHighScore3: UILabel!
    
    var highScores: [Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let highScore:Double = questionManager?.getHighScore() ?? 0.0
        self.currentHighScoreLabel.text = highScore.ToStringWithPrecision(0, max: 0)
        ScoringService.service.saveNewHighScore(highScore)
        self.highScores = ScoringService.service.getHighScores()
        UpdateHighScoreList()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    @IBAction func OnReplay(_ sender: AnyObject) {
        performSegue(withIdentifier: "showQuestionScene", sender: sender)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showQuestionScene"{
            if let view = (sender! as AnyObject).view as UIView?{
                // show questions
                let questionType:QuestionType? = QuestionUtility.getQuestionType(view)
                let isGameModeEnabled:Bool = true
                
                // grab all drugs
                let selectedDrugs = drugService?.selectAll()
                
                if questionType != nil {
                    
                    // Get the new view controller using segue.destinationViewController.
                    if let destinationVC = segue.destination as? QuestionViewController{
                        destinationVC.allDrugs = selectedDrugs
                        destinationVC.questionType = questionType
                        destinationVC.gameModeEnabled = isGameModeEnabled
                    }
                }
                
            }
        }
    }
 
    // MARK: Helpers
    fileprivate func UpdateHighScoreList(){
        self.topHighScore1.text="1."
        self.topHighScore2.text="2."
        self.topHighScore3.text="3."
        
        if self.highScores?.count > 0 {
            self.topHighScore1.text = "1. \(self.highScores![0].ToStringWithPrecision(0,max:0))"
//            self.topHighScore1.hidden = false
        }
        if self.highScores?.count > 1{
            self.topHighScore2.text = "2. \(self.highScores![1].ToStringWithPrecision(0,max:0))"
//            self.topHighScore2.hidden = false
        }
        if self.highScores?.count > 2 {
            self.topHighScore3.text = "3. \(self.highScores![2].ToStringWithPrecision(0,max:0))"
//            self.topHighScore3.hidden = false
        }
    }

}
