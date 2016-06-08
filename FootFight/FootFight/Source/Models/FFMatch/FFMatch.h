//
//  FFMatch.h
//  FootFight
//
//  Created by Artem on 6/7/16.
//  Copyright © 2016 Genek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFMatch : NSManagedObject
@property (nonatomic, readonly)     NSString    *matchType;

@end

NS_ASSUME_NONNULL_END

#import "FFMatch+CoreDataProperties.h"
