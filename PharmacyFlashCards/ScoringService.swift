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
    
    private init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        // set defaults if they dont exist
        if defaults.objectForKey(highScoresArrayKey) == nil{
            defaults.setObject([Double](), forKey: highScoresArrayKey)
        }
    }
    
    // get current high scores
    // returns empty list if there are high scores
    func getHighScores()->[Double]{
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.objectForKey(highScoresArrayKey) as? [Double] ?? [Double]()
    }
    
    // Save highest maxStoredHighScores number of scores
    func saveNewHighScore(currentHighScore:Double) {
        var highScores = self.getHighScores()
        let currentNumberOfHighScores:Int = highScores.count
        highScores.append(currentHighScore)
        
        // sort from high to low
        highScores = highScores.sort{
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
    func saveHighScoreList(highScores: [Double]){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(highScores, forKey: highScoresArrayKey)
    }
}