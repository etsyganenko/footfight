//
//  FFMatchesContext.swift
//  FootFight
//
//  Created by Genek on 2/25/16.
//  Copyright © 2016 IDAP. All rights reserved.
//

import UIKit
import Alamofire

class FFMatchesContext: FFContext {
    
    // MARK: - Accessors

    // MARK: - Initialization
    
    override init() {
        super.init()
        
        self.path = kFFMatchesPath
        self.url = kFFHost.stringByAppendingString(self.path!)
    }
    
    // MARK: - Public
    
    override func fillModelWithResponse(response: AnyObject) {
        guard let dictionary = response as? NSDictionary else {
            return
        }
        
        guard let matches = dictionary[kFFFixturesKey] as? NSArray else {
            return
        }
        
        for match in matches {
            guard let homeTeamName = match[kFFHomeTeamNameKey] as? String else {
                return
            }
            
            guard let awayTeamName = match[kFFAwayTeamNameKey] as? String else {
                return
            }
            
            guard let dateString = match[kFFDateKey] as? String else {
                return
            }
            
            let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = dateFormat
            
            let date = dateFormatter.dateFromString(dateString)! as NSDate
            
            guard let matchDay = match[kFFMatchdayKey] as? Int else {
                return
            }
            
            let matchID = String(matchDay).stringByAppendingString(homeTeamName).stringByAppendingString(awayTeamName)
            
            NSManagedObjectContext.MR_defaultContext().MR_saveWithBlockAndWait({ (localContext : NSManagedObjectContext!) in
                let match = FFMatch.MR_findFirstOrCreateByAttribute(kFFMatchIDKey, withValue: matchID, inContext: localContext)
                
                match.homeTeamName = homeTeamName
                match.awayTeamName = awayTeamName
                match.matchDay = matchDay
                match.date = date
            })
        }
    }
    
}
