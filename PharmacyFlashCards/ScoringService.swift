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
    
    func saveNewHighScore(currentHighScore:Double)->Bool{
        var highScores = self.getHighScores()
        var updatedStatus:Bool = false
        let currentNumberOfHighScores:Int = highScores.count
        if currentNumberOfHighScores < maxStoredHighScores{
            // less than max allowed number of stored high scores
            updatedStatus = true
            highScores.append(currentHighScore)
        }else{
            // is at max number of allowed high scores
            
            // change first instance where currentHighScore > a high score in the saved array
            for (index,value) in highScores.enumerate(){
                if currentHighScore > value{
                    highScores[index] = currentHighScore
                    updatedStatus = true
                    break
                }
            }
        }
        
        // save list of high scores
        if updatedStatus{
            saveHighScoreList(highScores)
        }
        
        return updatedStatus
    }
    
    // Save list of high scores
    func saveHighScoreList(highScores: [Double]){
        let defaults = NSUserDefaults.standardUserDefaults()
        let sortedHighScores = highScores.sort{
            return $0 < $1
        }
        defaults.setObject(sortedHighScores, forKey: highScoresArrayKey)
    }
}