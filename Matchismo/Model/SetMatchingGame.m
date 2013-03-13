//
//  SetMatchingGame.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/7/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "SetMatchingGame.h"

@interface SetMatchingGame()
@property (readwrite, nonatomic)int score;
@property (nonatomic, strong)NSMutableArray *cards; //of Card

@end

@implementation SetMatchingGame
@synthesize lastMoveAttrString = _lastMoveAttrString;

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void) flipCardAtIndex:(NSUInteger)index
{
    SetCard *card = (SetCard*)[self cardAtIndex:index];
    
    if (card && !card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            self.lastMoveResults = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            for (SetCard *secondCard in self.cards)
            {
                if (secondCard.isFaceUp && !secondCard.isUnplayable)
                {
                    for (SetCard *thirdCard in self.cards)
                    {
                        if (![card.contents isEqualToString:secondCard.contents] &&
                            ![secondCard.contents isEqualToString:thirdCard.contents] &&
                            ![thirdCard.contents isEqualToString:card.contents])
                        {
                            if (thirdCard.isFaceUp && !thirdCard.isUnplayable)
                            {
                                int matchScore = [card match:@[secondCard, thirdCard]];
                                
                                if (matchScore)
                                {
                                    card.unplayable = YES;
                                    secondCard.unplayable = YES;
                                    thirdCard.unplayable = YES;
                                    
                                    self.score += matchScore * MATCH_BONUS;
                                    
                                    self.lastMoveResults = [NSString stringWithFormat:@"Matched %@, %@, and %@ for %d points", card.contents, secondCard.contents, thirdCard.contents, matchScore * MATCH_BONUS];
                                    
                                    self.lastMoveAttrString = [NSString stringWithFormat:@"Matched %@, %@, and %@ for %d points", card.cardAttrString, secondCard.cardAttrString, thirdCard.cardAttrString, matchScore * MATCH_BONUS];
                                }
                                else
                                {
                                    card.faceUp = YES;
                                    secondCard.faceUp = NO;
                                    thirdCard.faceUp = NO;
                                    self.score -= MISMATCH_PENALTY;
                                    
                                    self.lastMoveResults = [NSString stringWithFormat:@"No cards match. %d penalty points.", MISMATCH_PENALTY];
                                    
                                    [self.lastMoveAttrString setAttributedString:secondCard.cardAttrString];
                                }
                            }
                            
                        }
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        //Card is up and being flipped back over
        else
        {
            self.lastMoveResults = [NSString stringWithFormat:@"Flipped down %@", card.contents];
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (NSMutableArray*)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (void)setLastMoveAttrString:(NSMutableAttributedString *)lastMoveAttrString
{
    if (!_lastMoveAttrString) _lastMoveAttrString = [[NSMutableAttributedString alloc]init];
}

@end
