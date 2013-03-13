//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/4/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic)int score;
@property (nonatomic, strong)NSMutableArray *cards; //of Card

@end

@implementation CardMatchingGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void) flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];

    if (card && !card.isUnplayable)
    {
        if (!card.isFaceUp)
        {
            self.lastMoveResults = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            
            for (Card *secondCard in self.cards)
            {
                if (secondCard.isFaceUp && !secondCard.isUnplayable)
                {
                    if (self.cardMatchType == twoCardMatching)
                    {
                        int matchScore = [card match:@[secondCard]];
                        
                        if (matchScore)
                        {
                            card.unplayable = YES;
                            secondCard.unplayable = YES;
                            
                            self.score += matchScore * MATCH_BONUS;
                            
                            self.lastMoveResults = [NSString stringWithFormat:@"Matched %@ and %@ for %d points", card.contents, secondCard.contents, matchScore * MATCH_BONUS];
                        }
                        else
                        {
                            card.faceUp = YES;
                            secondCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.lastMoveResults = [NSString stringWithFormat:@"%@ and %@ do not match.  %d point penalty", card.contents, secondCard.contents, MISMATCH_PENALTY];
                        }
                        break;
                    }
                    else if (self.cardMatchType == threeCardMatching)
                    {
                        for (Card *thirdCard in self.cards)
                        {
                            if (![card.contents isEqualToString:secondCard.contents] &&
                                ![secondCard.contents isEqualToString:thirdCard.contents] &&
                                ![thirdCard.contents isEqualToString:card.contents])
                            {
                                
                            
                                if (thirdCard.isFaceUp && !thirdCard.isUnplayable)
                                {
                                    int matchScore = [card match:@[secondCard, thirdCard]];
                                    
                                    //If matchScore is greater than 15 that means all 3 cards matched
                                    if (matchScore > 15)
                                    {
                                        card.unplayable = YES;
                                        secondCard.unplayable = YES;
                                        thirdCard.unplayable = YES;
                                        
                                        self.score += matchScore * MATCH_BONUS;
                                        self.lastMoveResults = [NSString stringWithFormat:@"Matched 3 cards %@, %@, and %@ for %d points", card.contents, secondCard.contents, thirdCard.contents, matchScore * MATCH_BONUS];
                                        
                                    }
                                    else if (matchScore)
                                    {
                                        self.score += matchScore * MATCH_BONUS;
                                        
                                        if ([card match:@[secondCard]])
                                        {
                                            card.unplayable = YES;
                                            secondCard.unplayable = YES;
                                            thirdCard.faceUp = NO;
                                            
                                            self.lastMoveResults = [NSString stringWithFormat:@"Matched 2 cards %@ and %@ for %d points", card.contents, secondCard.contents, matchScore * MATCH_BONUS];
                                        }
                                        else if ([card match:@[thirdCard]])
                                        {
                                            card.unplayable = YES;
                                            secondCard.faceUp = NO;
                                            thirdCard.unplayable = YES;
                                            
                                            self.lastMoveResults = [NSString stringWithFormat:@"Matched 2 cards %@ and %@ for %d points", card.contents, thirdCard.contents, matchScore * MATCH_BONUS];
                                        }
                                        else
                                        {
                                            card.faceUp = NO;
                                            secondCard.unplayable = YES;
                                            thirdCard.unplayable = YES;
                                            
                                            self.lastMoveResults = [NSString stringWithFormat:@"Matched 2 cards %@ and %@ for %d points", secondCard.contents, thirdCard.contents, matchScore * MATCH_BONUS];
                                            
                                        }
                                    }
                                    else
                                    {
                                        card.faceUp = YES;
                                        secondCard.faceUp = NO;
                                        thirdCard.faceUp = NO;
                                        
                                        self.lastMoveResults = [NSString stringWithFormat:@"No cards match. %d penalty points.", MISMATCH_PENALTY];
                                    }
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


- (id) initWithCardCount:(NSUInteger)count usindDeck:(Deck *)deck
{
    self = [super initWithCardCount:count usindDeck:deck];
    
    if (self)
    {
        //default card match type to 2 cards
        self.cardMatchType = 0;
    }
    return self;
}
@end
