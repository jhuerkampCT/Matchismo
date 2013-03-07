//
//  PlayingCard.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/4/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;


- (int)match:(NSArray *)otherCards
{
    int score = 0;

    //match against 1 other card
    if ([otherCards count] == 1)
    {
        PlayingCard *otherCard = [otherCards lastObject];
        
        if ([otherCard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
        else if (otherCard.rank == self.rank)
        {
            score = 4;
        }
    }
    else
    {
        for (PlayingCard* secondCard in otherCards)
        {
            for (PlayingCard* thirdCard in otherCards)
            {
                if (![secondCard.contents isEqualToString:thirdCard.contents])
                {
                    if ([secondCard.suit isEqualToString:self.suit] || [thirdCard.suit isEqualToString:self.suit])
                    {
                        if ([secondCard.suit isEqualToString:thirdCard.suit])
                            score = 16;
                        else
                            score = 4;
                    }
                    else if (secondCard.rank == self.rank || thirdCard.rank == self.rank)
                    {
                        if (secondCard.rank == thirdCard.rank)
                            score = 64;
                        else
                            score = 10;
                    }
                }
                
                
            }
        }
    }
    return score;
}
- (NSString*) contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}


+ (NSArray*)validSuites
{
    NSArray *validSuites = @[@"♦",@"♠",@"♣",@"♥"];
    return validSuites;
}

- (void)setSuit:(NSString*)suit
{
    if([[PlayingCard validSuites] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString*)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray*)rankStrings
{
    NSArray* rankStrings = @[@"?",@"A",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return rankStrings;
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
