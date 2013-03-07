//
//  Game.h
//  Matchismo
//
//  Created by Josh Huerkamp on 3/7/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface Game : NSObject

//designated initializer
- (id) initWithCardCount:(NSUInteger)count usindDeck:(Deck*)deck;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic)int score;
@property (strong, nonatomic)NSString *lastMoveResults;

@end
