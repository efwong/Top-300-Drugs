//
//  ResultsViewController.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/15/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    // MARK: properties
    
    var questionManager: QuestionManager?
    var incorrectQuestions: [Question] = []
    var correctQuestions: [Question] = []
    var totalSeconds: Int?
    var streakCount: Int?
    
    
    @IBOutlet weak var totalNumberCorrectLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var streakCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view.
        if self.questionManager != nil {
            self.incorrectQuestions = getAllIncorrectQuestions()
            self.correctQuestions = getAllCorrectQuestions()
        }else{
            self.incorrectQuestions = []
        }
        
        // set question count
        let totalCount = self.questionManager?.allDrugs.count ?? 0
        //let incorrectCount = self.incorrectQuestions.count
        let correctCount = self.correctQuestions.count
        totalNumberCorrectLabel.text = "\(correctCount)"
        totalCountLabel.text = "\(totalCount)"
        
        // set streak count
        let streak = self.questionManager?.answerStreak ?? 0
        streakCountLabel.text = "\(streak)"
        
        // set time
        if self.totalSeconds != nil{
            let seconds = self.totalSeconds! % 60
            let minutes = (self.totalSeconds! / 60) % 60
            timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
        
        // set records view
        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem(
            title: "Hall of Fame",
            style: .Plain,
            target: self,
            action: #selector(ResultsViewController.showHighScores(_:))
        )
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        // set records view
        //.... Set Right/Left Bar Button item
        let leftBarButton = UIBarButtonItem(
            title: "Main Menu",
            style: .Plain,
            target: self,
            action: #selector(ResultsViewController.showMainMenu(_:))
        )
        //self.navigationItem.backBarButtonItem = leftBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showHighScores(sender: AnyObject?) {
        performSegueWithIdentifier("showRecordsScene", sender: sender)
    }
    
    func showMainMenu(sender: AnyObject?){
        performSegueWithIdentifier("showMainMenu", sender: sender)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRecordsScene"{
            if segue.destinationViewController is RecordsViewController{
            }
        }else if segue.identifier == "showMainMenu"{
        }
    }
 
    
    
    // MARK: Private methods
    
    // Get all questions that the user answered incorrectly
    private func getAllIncorrectQuestions() -> [Question]{
        let incorrectQuestions = self.questionManager?.getAllUserQuestions().filter(){
            if let localQuestion = ($0 as Question?){
                return localQuestion.wasAnsweredCorrectly == nil || localQuestion.wasAnsweredCorrectly == false
            }else{
                return false
            }
        }
        return incorrectQuestions ?? []
    }
    // Get all questions that the user answered correctly
    private func getAllCorrectQuestions() -> [Question]{
        
        let correctQuestions = self.questionManager?.getAllUserQuestions().filter(){
            if let localQuestion = ($0 as Question?){
                return localQuestion.wasAnsweredCorrectly == true
            }else{
                return false
            }
        }
        return correctQuestions ?? []
    }

}
