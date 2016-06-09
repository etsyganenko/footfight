//
//  FFMatch.h
//  FootFight
//
//  Created by Genek on 6/7/16.
//  Copyright © 2016 Genek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FFPredictionResult) {
    FFPredictionResultNone,
    FFPredictionScoreCorrect,
    FFPredictionResultCorrect,
    FFPredictionWrong
};

@interface FFMatch : NSManagedObject
@property (nonatomic, readonly)     NSString        *matchType;
@property (nonatomic, readonly)     NSString        *matchScore;

@property (nonatomic, readonly)     NSUInteger      userScore;
@property (nonatomic, readonly)     NSString        *userScoreString;

@end

NS_ASSUME_NONNULL_END

#import "FFMatch+CoreDataProperties.h"
