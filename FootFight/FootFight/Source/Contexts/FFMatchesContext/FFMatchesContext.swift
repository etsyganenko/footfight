//
//  FFMatchesContext.swift
//  FootFight
//
//  Created by Genek on 2/25/16.
//  Copyright © 2016 IDAP. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class FFMatchesContext: FFContext {
    
    // MARK: - Accessors
    
    var championshipID: String?

    // MARK: - Initialization
    
    init(championshipID: String?) {
        super.init()
        
        self.path = kFFMatchesPath
        self.url = kFFHost.stringByAppendingString(self.path!)
        self.championshipID = championshipID
    }
    
    // MARK: - Public
    
    override func fillModelWithResponse(response: AnyObject) {
        if let dictionary = response as? NSDictionary {
            if let matches = dictionary[kFFFixturesKey] as? NSArray {
                for matchDictionary in matches {
                    guard let homeTeamName = matchDictionary[kFFHomeTeamNameKey] as? String else {
                        return
                    }
                    
                    guard let awayTeamName = matchDictionary[kFFAwayTeamNameKey] as? String else {
                        return
                    }
                    
                    guard let matchDateString = matchDictionary[kFFDateKey] as? String else {
                        return
                    }
                    
                    let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = dateFormat
                    
                    let matchDate = dateFormatter.dateFromString(matchDateString)! as NSDate
                    
                    guard let stageIndex = matchDictionary[kFFMatchdayKey] as? NSNumber else {
                        return
                    }
                    
                    let matchID = String(stageIndex).stringByAppendingString(homeTeamName).stringByAppendingString(awayTeamName)
                    
                    NSManagedObjectContext.MR_defaultContext().MR_saveWithBlockAndWait({ (localContext : NSManagedObjectContext!) in
                        let championship = FFChampionship.MR_findFirstOrCreateByAttribute(kFFChampionshipIDKey, withValue: self.championshipID!, inContext: localContext)
                        let stage = FFStage.MR_findFirstOrCreateByAttribute(kFFStageIDKey, withValue: stageIndex.stringValue, inContext: localContext)
                        let match = FFMatch.MR_findFirstOrCreateByAttribute(kFFMatchIDKey, withValue: matchID, inContext: localContext)
                        
                        stage.stageIndex = stageIndex
                        stage.championship = championship

                        match.homeTeamName = homeTeamName
                        match.awayTeamName = awayTeamName
                        match.matchDate = matchDate
                        match.stage = stage
                        
                        if let resultDictionary = matchDictionary[kFFMatchResultKey] as? NSDictionary {
                            if let homeTeamGoals = resultDictionary[kFFGoalsHomeTeamKey] as? NSNumber {
                                match.homeTeamGoals = homeTeamGoals
                            }
                            
                            if let awayTeamGoals = resultDictionary[kFFGoalsAwayTeamKey] as? NSNumber {
                                match.awayTeamGoals = awayTeamGoals
                            }
                        }
                        

                    })
                }
            }
        }
    }
    
}
