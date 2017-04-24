//
//  ScoringService.swift
//  PharmacyFlashCards
//
//  Created by Edwin Wong on 5/29/16.
//  Copyright © 2016 Edwin Wong. All rights reserved.
//

import Foundation

class ScoringService{
    
    static let service = ScoringService()
    
    let highScoresArrayKey = "HighScoreArray"
    
    // max number of high scores stored
    let maxStoredHighScores:Int = 3
    
    fileprivate init(){
        let defaults = UserDefaults.standard
        // set defaults if they dont exist
        if defaults.object(forKey: highScoresArrayKey) == nil{
            defaults.set([Double](), forKey: highScoresArrayKey)
        }
    }
    
    // get current high scores
    // returns empty list if there are high scores
    func getHighScores()->[Double]{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: highScoresArrayKey) as? [Double] ?? [Double]()
    }
    
    // Save highest maxStoredHighScores number of scores
    func saveNewHighScore(_ currentHighScore:Double) {
        var highScores = self.getHighScores()
        let currentNumberOfHighScores:Int = highScores.count
        highScores.append(currentHighScore)
        
        // sort from high to low
        highScores = highScores.sorted{
            return $0 > $1
        }
        if currentNumberOfHighScores < maxStoredHighScores{
        }else{
            // remove last element
            highScores.removeLast()
        }
        
        // save list of high scores
        saveHighScoreList(highScores)
    }
    
    // Save list of high scores
    func saveHighScoreList(_ highScores: [Double]){
        let defaults = UserDefaults.standard
        defaults.set(highScores, forKey: highScoresArrayKey)
    }
}
