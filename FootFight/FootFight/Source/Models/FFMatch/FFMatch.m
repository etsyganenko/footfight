//
//  FFMatch.m
//  FootFight
//
//  Created by Genek on 6/7/16.
//  Copyright © 2016 Genek. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>

#import "FFMatch.h"

#import "FootFight-Swift.h"

typedef NS_ENUM(NSUInteger, FFMatchResult) {
    FFHomeTeamWin,
    FFAwayTeamWin,
    FFDraw
};

typedef NS_ENUM(NSUInteger, FFMatchStatus) {
    FFMatchNotStarted,
    FFMatchStarted
};

static NSString * const kFFGroupStage               = @"GroupStage";
static NSString * const kFF18Final                  = @"18Final";
static NSString * const kFF14Final                  = @"14Final";
static NSString * const kFF12Final                  = @"12Final";
static NSString * const kFFFinal                    = @"Final";
static NSString * const kFFMatchday                 = @"Matchday";

@interface FFMatch ()
@property (nonatomic, readonly)     NSArray             *matchTypes;

@property (nonatomic, readonly)     FFMatchResult       matchResult;
@property (nonatomic, readonly)     FFMatchResult       matchResultPrediction;

@property (nonatomic, readonly)     FFMatchStatus       matchStatus;

@property (nonatomic, readonly)     FFPredictionResult  predictionResult;

- (FFMatchResult)matchResultWithHomeTeamGoals:(NSUInteger)homeTeamGoals
                                awayTeamGoals:(NSUInteger)awayTeamGoals;

@end

@implementation FFMatch

@dynamic matchType;
@dynamic matchScore;
@dynamic userScore;
@dynamic userScoreString;
@dynamic matchResult;
@dynamic matchResultPrediction;
@dynamic matchStatus;
@dynamic predictionResult;

#pragma mark -
#pragma mark Accessors

- (NSString *)matchType {
    return self.matchTypes[self.matchday.intValue - 1];
}

- (NSString *)matchScore {
    if (FFMatchNotStarted == self.matchStatus) {
        return @"- : -";
    }
    
    return [NSString stringWithFormat:@"%@ : %@", self.homeTeamGoals, self.awayTeamGoals];
}

- (NSUInteger)userScore {
    FFPredictionResult predictionResult = self.predictionResult;
    if (FFPredictionScoreCorrect == predictionResult) {
        return 3;
    } else if (FFPredictionResultCorrect == predictionResult) {
        return 1;
    }
    
    return 0;
}

- (NSString *)userScoreString {
    if (FFMatchNotStarted == self.matchStatus) {
        return @"-";
    }
    
    return [NSString stringWithFormat:@"%lu", self.userScore];
}

- (NSArray *)matchTypes {
    return @[[NSString stringWithFormat:@"%@ - %@ %d", NSLocalizedString(kFFGroupStage, nil), NSLocalizedString(kFFMatchday, nil), self.matchday.intValue],
             [NSString stringWithFormat:@"%@ - %@ %d", NSLocalizedString(kFFGroupStage, nil), NSLocalizedString(kFFMatchday, nil), self.matchday.intValue],
             [NSString stringWithFormat:@"%@ - %@ %d", NSLocalizedString(kFFGroupStage, nil), NSLocalizedString(kFFMatchday, nil), self.matchday.intValue],
             NSLocalizedString(kFF18Final, nil),
             NSLocalizedString(kFF14Final, nil),
             NSLocalizedString(kFF12Final, nil),
             NSLocalizedString(kFFFinal, nil)];
}

- (FFMatchResult)matchResult {
    NSUInteger homeTeamGoals = self.homeTeamGoals.unsignedIntegerValue;
    NSUInteger awayTeamGoals = self.awayTeamGoals.unsignedIntegerValue;
    
    return [self matchResultWithHomeTeamGoals:homeTeamGoals awayTeamGoals:awayTeamGoals];
}

- (FFMatchResult)matchResultPrediction {
    NSUInteger homeTeamGoalsPrediction = self.homeTeamGoalsPrediction.unsignedIntegerValue;
    NSUInteger awayTeamGoalsPrediction = self.awayTeamGoalsPrediction.unsignedIntegerValue;
    
    return [self matchResultWithHomeTeamGoals:homeTeamGoalsPrediction awayTeamGoals:awayTeamGoalsPrediction];
}

- (FFMatchStatus)matchStatus {
    NSDate *matchDate = self.matchDate;
    
    if ([matchDate laterDate:[NSDate date]]) {
        return FFMatchNotStarted;
    }
    
    return FFMatchStarted;
}

- (FFPredictionResult)predictionResult {
    if (FFMatchNotStarted == self.matchStatus) {
        return FFPredictionResultNone;
    } else if (self.homeTeamGoalsPrediction == self.homeTeamGoals && self.awayTeamGoalsPrediction == self.awayTeamGoals) {
        return FFPredictionScoreCorrect;
    } else if (self.matchResultPrediction == self.matchResult) {
        return FFPredictionResultCorrect;
    }
    
    return FFPredictionWrong;
}

#pragma mark -
#pragma mark Private

- (FFMatchResult)matchResultWithHomeTeamGoals:(NSUInteger)homeTeamGoals
                                awayTeamGoals:(NSUInteger)awayTeamGoals
{
    if (homeTeamGoals > awayTeamGoals) {
        return FFHomeTeamWin;
    } else if (homeTeamGoals < awayTeamGoals) {
        return FFAwayTeamWin;
    }
    
    return FFDraw;
}

@end
