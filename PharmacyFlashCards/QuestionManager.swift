//
//  Question.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 2/7/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation


class QuestionManager {
    
    // MARK: Properties
    // number of answers to be shown (eg. 4)
    let answerCount: Int
    var questionType: QuestionType
    var gameModeEnabled: Bool
    let allDrugs : [Drug]
    var currentDrugIndex : Int
    var currentDrug : Drug{
        get{
            return self.allDrugs[self.currentDrugIndex]
        }
    }
    
    // list of question the user has seen
    var questionList: [Question]
    
    var currentQuestion: Question?
    
    // answer streak of user (how many correct the user got in a row)
    var answerStreak: Int
    // highest streak for the current question set
    var highestAnswerStreak: Int
    
    // high score
    var highScore: Double
    
    
    // MARK: INIT
    // Inputs:
    //      questionType -> type of question (Brand, Generic, etc)ß
    //      allDrugs -> array of drugs
    init(questionType: QuestionType, allDrugs: [Drug], answerCount: Int=4, gameModeEnabled: Bool = false){
        self.questionType = questionType
        self.allDrugs = allDrugs.shuffle()
        self.currentDrugIndex = 0
        self.answerCount = answerCount
        self.questionList = []
        self.answerStreak = 0
        self.highestAnswerStreak = 0
        self.highScore = 0
        self.gameModeEnabled = gameModeEnabled
        self.currentQuestion = createQuestion()
    }
    
    // MARK: Methods
    func isAtLastQuestion() -> Bool{
        return self.currentDrugIndex == (self.allDrugs.count - 1)
    }
    
    func getNextQuestion() -> Question{
        if self.currentDrugIndex < self.allDrugs.count {
            self.currentDrugIndex += 1
            
            // get random question type if gameModeEnabled == true
            UpdateQuestionTypeByGameMode()
            
            self.currentQuestion = createQuestion()
        }
        return self.currentQuestion!
    }
    
    func getCurrentQuestion() -> Question{
        return self.currentQuestion!
    }
    
    func getQuestionType() -> QuestionType?{
        return self.questionType
    }
    
    // MARK: PRIVATE METHODS
    func createQuestion() -> Question {
        var availableDrugs:[Drug] = []
        var correctDrugIndex:Int = 0
        
        do{
            let tempAnswerSet = try createAnswerSetForDrug(self.answerCount)
            availableDrugs = tempAnswerSet.1
            correctDrugIndex = (tempAnswerSet.0 ?? 0)
        }
        catch{
            availableDrugs = []
        }
        var returnQuestion: Question
        
        switch self.questionType {
        case .BrandName:
            returnQuestion = BrandQuestion(questionType: self.questionType, correctDrugIndex: correctDrugIndex, drugAnswers: availableDrugs)
        case .GenericName:
            returnQuestion = GenericQuestion(questionType: self.questionType, correctDrugIndex: correctDrugIndex, drugAnswers: availableDrugs)
        case .Classification:
            returnQuestion = ClassificationQuestion(questionType: self.questionType, correctDrugIndex: correctDrugIndex, drugAnswers: availableDrugs)
        case .Dosage:
            returnQuestion = DosageQuestion(questionType: self.questionType, correctDrugIndex: correctDrugIndex, drugAnswers: availableDrugs)
        case .Indication:
            returnQuestion = IndicationQuestion(questionType: self.questionType, correctDrugIndex: correctDrugIndex, drugAnswers: availableDrugs)
        default:
            returnQuestion = Question(questionType: self.questionType, correctDrugIndex: correctDrugIndex, drugAnswers: availableDrugs)
        }
        
        self.questionList.append(returnQuestion)
        return returnQuestion
    }
    
    // create answer set for current drug while removing duplicates
    // returns tuple (Int?, [Drug])
    //              first element -> position of correct drug if it exists
    //              second element -> array of drugs as the answer set
    func createAnswerSetForDrug(answerCount: Int) throws -> (Int?, [Drug]){
        var result:[Drug] = []
        var index:Int?
        if self.allDrugs.count < answerCount {
            throw QuestionServiceError.InsufficientNumberOfDrugs
        }else{
            var duplicateMap = [String: Int]()
            // remove correct drug from list of drugs
            let drugsCopy:[Drug] = self.allDrugs.filter() {
                if let localDrug = ($0 as Drug?){
                    if localDrug == self.currentDrug {
                        return false
                    }
                    else {
                        // remove duplicates
                        return StoreAndCheckDuplicateQuestions(&duplicateMap, drug: localDrug)
                    }
                } else {
                    return false
                }
            }
            if drugsCopy.count > 0 && answerCount > 0 {
                var availableDrugs = Array(drugsCopy.shuffle().prefix(answerCount-1)) as [Drug]
                availableDrugs.append(self.currentDrug);
                result = Array(availableDrugs.shuffle()) as [Drug];
                
                index = result.indexOf(self.currentDrug)!
            }
        }
        return (index, result)
    }
    
    // get list of questions that user has seen already
    func getAllUserQuestions() -> [Question]{
        return self.questionList
    }
    
    // MARK: Answer streak methods
    func resetAnswerStreak() {
        self.answerStreak = 0
    }
    
    private func incrementAnswerStreak() {
        self.answerStreak += 1
        if(self.answerStreak > self.highestAnswerStreak){
            self.highestAnswerStreak = self.answerStreak
        }
    }
    
    // get answer streak
    func getAnswerStreak() -> Int{
        return self.answerStreak
    }
    
    // get highest answer streak from current question set
    func getHighestAnswerStreak() -> Int{
        return self.highestAnswerStreak
    }
    
    // MARK: High Score methods
    func getHighScore() -> Double{
        return self.highScore
    }
    
    // update high score if game mode is on
    private func updateHighScore(answerStreak: Int){
        if self.gameModeEnabled{
            // calculate high score
            self.highScore = self.highScore + pow(2, Double(answerStreak))
        }
    }
    
    
    // update all scoring values
    func updateScores(){
        self.incrementAnswerStreak()
        updateHighScore(self.answerStreak)
    }
    
    // MARK: HELPER
    
    // Check for duplicates while creating answer set
    private func StoreAndCheckDuplicateQuestions(inout duplicatesMap: [String:Int], drug: Drug) -> Bool{
        var status = false
        var value:String = ""
        switch self.questionType{
        case .GenericName:
            value = drug.generic ?? ""
        case .BrandName:
            value = drug.brand ?? ""
        case .Classification:
            value = drug.classification ?? ""
        case .Dosage:
            value = drug.dosage ?? ""
        case .Indication:
            value = drug.indication ?? ""
        }
        
        // check for duplicates
        if duplicatesMap[value] != nil{
            duplicatesMap[value]! += 1
        }else{
            // not a duplicate
            status = true
            duplicatesMap[value] = 1
        }
        return status
    }
    
    // If gameModeEnabled = true -> get a random question type and update current question type
    // else get current question type
    private func UpdateQuestionTypeByGameMode(){
        if self.gameModeEnabled {
            self.questionType = QuestionUtility.GetRandomQuestionType()!
        }
    }
}
