//
//  FFMatch.swift
//  FootFight
//
//  Created by Artem on 6/10/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import Foundation
import CoreData

enum FFPredictionResult: UInt {
    case FFPredictionResultNone = 0
    case FFPredictionScoreCorrect
    case FFPredictionResultCorrect
    case FFPredictionWrong
}

enum FFMatchStatus: UInt {
    case FFMatchNotStarted = 0
    case FFMatchStarted
}

enum FFMatchResult: UInt {
    case FFHomeTeamWin = 0
    case FFAwayTeamWin
    case FFDraw
}

@objc(FFMatch)
class FFMatch: NSManagedObject {

    // MARK: - Accessors
    
    var matchType: String {
        return self.matchTypes[self.matchday!.intValue - 1] as! String;
    }
    
    var matchStatus: FFMatchStatus {
        let matchDate = self.matchDate! as NSDate
        
        if matchDate == matchDate.laterDate(NSDate()) {
            return FFMatchStatus.FFMatchNotStarted
        }

        return FFMatchStatus.FFMatchStarted
    }
    
    var matchScore: NSString {
        if FFMatchStatus.FFMatchNotStarted == self.matchStatus {
            return "- : -"
        }
        
        return NSString(format: "%@ : %@", self.homeTeamGoals!, self.awayTeamGoals!)
    }
    
    var userScore: UInt {
        let predictionResult = self.predictionResult as FFPredictionResult
        if FFPredictionResult.FFPredictionScoreCorrect == predictionResult {
            return 3
        } else if FFPredictionResult.FFPredictionResultCorrect == predictionResult {
            return 1
        }
        
        return 0
    }
    
    var userScoreString: NSString {
        if FFMatchStatus.FFMatchNotStarted == self.matchStatus {
            return "-"
        }
        
        return NSString(format: "%lu", self.userScore)
    }
    
    var matchTypes: NSArray {
        return [NSString(format:"%@ - %@ %d", NSLocalizedString(kFFGroupStage, comment: String()), NSLocalizedString(kFFMatchday, comment: String()), self.matchday!.intValue),
                NSString(format:"%@ - %@ %d", NSLocalizedString(kFFGroupStage, comment: String()), NSLocalizedString(kFFMatchday, comment: String()), self.matchday!.intValue),
                NSString(format:"%@ - %@ %d", NSLocalizedString(kFFGroupStage, comment: String()), NSLocalizedString(kFFMatchday, comment: String()), self.matchday!.intValue),
                NSLocalizedString(kFF18Final, comment: String()),
                NSLocalizedString(kFF14Final, comment: String()),
                NSLocalizedString(kFF12Final, comment: String()),
                NSLocalizedString(kFFFinal, comment: String())]
    }
    
    var matchResult: FFMatchResult {
        let homeTeamGoals = self.homeTeamGoals!.unsignedIntegerValue as UInt
        let awayTeamGoals = self.awayTeamGoals!.unsignedIntegerValue as UInt
        
        return self.matchResultWithHomeTeamGoals(homeTeamGoals, awayTeamGoals: awayTeamGoals)
    }
    
    var matchResultPrediction: FFMatchResult {
        let homeTeamGoalsPrediction = self.homeTeamGoalsPrediction!.unsignedIntegerValue as UInt
        let awayTeamGoalsPrediction = self.awayTeamGoalsPrediction!.unsignedIntegerValue as UInt
        
        return self.matchResultWithHomeTeamGoals(homeTeamGoalsPrediction, awayTeamGoals: awayTeamGoalsPrediction)
    }
    
    var predictionResult: FFPredictionResult {
        if FFMatchStatus.FFMatchNotStarted == self.matchStatus {
            return FFPredictionResult.FFPredictionResultNone
        } else if (self.homeTeamGoalsPrediction == self.homeTeamGoals && self.awayTeamGoalsPrediction == self.awayTeamGoals) {
            return FFPredictionResult.FFPredictionScoreCorrect
        } else if (self.matchResultPrediction == self.matchResult) {
            return FFPredictionResult.FFPredictionResultCorrect
        }
        
        return FFPredictionResult.FFPredictionWrong
    }
    
    // MARK: - Private
    
    private func matchResultWithHomeTeamGoals(homeTeamGoals: UInt, awayTeamGoals: UInt) -> FFMatchResult {
        if homeTeamGoals > awayTeamGoals {
            return FFMatchResult.FFHomeTeamWin
        } else if homeTeamGoals < awayTeamGoals {
            return FFMatchResult.FFAwayTeamWin
        }
        
        return FFMatchResult.FFDraw
    }
}
