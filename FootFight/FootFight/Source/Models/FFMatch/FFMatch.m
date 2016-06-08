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

static NSString * const kFFGroupStage               = @"GroupStage";
static NSString * const kFF18Final                  = @"18Final";
static NSString * const kFF14Final                  = @"14Final";
static NSString * const kFF12Final                  = @"12Final";
static NSString * const kFFFinal                    = @"Final";
static NSString * const kFFMatchday                 = @"Matchday";

@interface FFMatch ()
@property (nonatomic, readonly)     NSArray     *matchTypes;

@end

@implementation FFMatch

@dynamic matchType;

- (NSString *)matchType {
    return self.matchTypes[self.matchDay.intValue - 1];
}

- (NSArray *)matchTypes {
    return @[[NSString stringWithFormat:@"%@ - %@ %d", NSLocalizedString(kFFGroupStage, nil), NSLocalizedString(kFFMatchday, nil), self.matchDay.intValue],
             [NSString stringWithFormat:@"%@ - %@ %d", NSLocalizedString(kFFGroupStage, nil), NSLocalizedString(kFFMatchday, nil), self.matchDay.intValue],
             [NSString stringWithFormat:@"%@ - %@ %d", NSLocalizedString(kFFGroupStage, nil), NSLocalizedString(kFFMatchday, nil), self.matchDay.intValue],
             NSLocalizedString(kFF18Final, nil),
             NSLocalizedString(kFF14Final, nil),
             NSLocalizedString(kFF12Final, nil),
             NSLocalizedString(kFFFinal, nil)];
}

@end
