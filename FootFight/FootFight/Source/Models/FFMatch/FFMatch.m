//
//  FFMatch.m
//  FootFight
//
//  Created by Artem on 6/7/16.
//  Copyright © 2016 Genek. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>

#import "FFMatch.h"

@implementation FFMatch

@dynamic matchType;

- (NSString *)matchType {
    return nil;
}

- (NSArray *)matchTypes {
    return @[@"Group stage"];
}

@end
