//
//  QuestionManager.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 2/7/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

enum QuestionServiceError: ErrorType{
    case InsufficientNumberOfDrugs
}

class QuestionService {
    
    static func randomizeDrugs(drugs:[Drug]) -> [Drug]{
        return drugs.shuffle()
    }
    
    // MARK: In Progress
    
    /**
    Generate an array of Drugs when given a correct drug and a set of possible drugs.
    
    - Parameter drug:   The correct drug.
    - Parameter drugs: array of possible drugs.
    - Parameter answerCount: number of answers wanted
    
    - Throws: error when answerCount > drugs.length
    
    - Returns: An array of drugs with length of answerCount
    */
    static func createAnswerSetForDrug(correctDrug: Drug, drugs:[Drug], answerCount: Int) throws -> [Drug] {
        var result:[Drug] = []
        if(drugs.count < answerCount){
            throw QuestionServiceError.InsufficientNumberOfDrugs
        }else{
            // remove correct drug from list of drugs
            let drugsCopy:[Drug] = drugs.filter(){
                if let localDrug = ($0 as Drug?){
                    if localDrug == correctDrug{
                        return false
                    }
                    else{
                        return true
                    }
                } else {
                    return false
                }
            }
            if drugsCopy.count > 0 && answerCount > 0{
                var availableDrugs = Array(drugsCopy.shuffle().prefix(answerCount-1)) as [Drug]
                availableDrugs.append(correctDrug);
                result = Array(availableDrugs.shuffleInPlace()) as [Drug];
            }
            
        }
        return result;
        
    }

}