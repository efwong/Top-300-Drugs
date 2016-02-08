//
//  QuestionManager.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 2/7/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation


class QuestionService {
    
    static func randomizeDrugs(drugs:[Drug]) -> [Drug]{
        return drugs.shuffle()
    }
    
    //static func getAnswerSetForDrug(drug: Drug) -> [Drug] {
        // not finished yet
    //}

}