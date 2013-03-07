//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/4/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

- (id)init
{
    self = [super init];
    if (self)
    {
        for (NSString* suit in [PlayingCard validSuites])
        {
            for (NSUInteger rank=1; rank <= [PlayingCard maxRank]; rank++)
            {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    return self;
}
@end
