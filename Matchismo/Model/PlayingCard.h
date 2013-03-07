//
//  PlayingCard.h
//  Matchismo
//
//  Created by Josh Huerkamp on 3/4/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray*)validSuites;
+(NSUInteger)maxRank;
+(NSArray*)rankStrings;

@end
