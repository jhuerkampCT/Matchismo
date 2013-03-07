//
//  Card.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/4/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize contents = _contents;
@synthesize faceUp = _faceUp;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if([card.contents isEqualToString:self.contents])
            score =1;
    }
    return score;
    
}
@end
