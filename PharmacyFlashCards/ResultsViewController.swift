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
    
    
    @IBOutlet weak var totalNumberCorrectLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view.
        if self.questionManager != nil {
            self.incorrectQuestions = getAllIncorrectQuestions()
            self.correctQuestions = getAllCorrectQuestions()
        }else{
            self.incorrectQuestions = []
        }
        
        let totalCount = self.questionManager?.allDrugs.count ?? 0
        //let incorrectCount = self.incorrectQuestions.count
        let correctCount = self.correctQuestions.count
        totalNumberCorrectLabel.text = "\(correctCount)"
        totalCountLabel.text = "\(totalCount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
