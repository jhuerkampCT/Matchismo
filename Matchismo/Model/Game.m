//
//  Game.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/7/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "Game.h"

@interface Game()
@property (readwrite, nonatomic)int score;
@property (nonatomic, strong)NSMutableArray *cards; //of Card

@end

@implementation Game
@synthesize score = _score;
@synthesize lastMoveResults = _lastMoveResults;

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (NSMutableArray*)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (Card*) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id) initWithCardCount:(NSUInteger)count usindDeck:(Deck *)deck
{
    self = [super init];
    
    if (self)
    {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card)
                self.cards[i] = card;
            else
            {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (NSString*)lastMoveResults
{
    if (!_lastMoveResults)_lastMoveResults = [[NSString alloc]init];
    return _lastMoveResults;
}

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
                            self.score -= MISMATCH_PENALTY;
                            self.lastMoveResults = [NSString stringWithFormat:@"%@ and %@ do not match.  %d point penalty", card.contents, secondCard.contents, MISMATCH_PENALTY];
                        }
                        break;
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
    card.faceUp = !card.isFaceUp;
}
@end
