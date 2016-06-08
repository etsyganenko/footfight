//
//  FFMatch+CoreDataProperties.h
//  FootFight
//
//  Created by Genek on 6/7/16.
//  Copyright © 2016 Genek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FFMatch.h"

NS_ASSUME_NONNULL_BEGIN

@interface FFMatch (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *matchID;
@property (nullable, nonatomic, retain) NSString *awayTeamName;
@property (nullable, nonatomic, retain) NSString *homeTeamName;
@property (nullable, nonatomic, retain) NSNumber *homeTeamGoals;
@property (nullable, nonatomic, retain) NSNumber *awayTeamGoals;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *matchDay;

@end

NS_ASSUME_NONNULL_END
