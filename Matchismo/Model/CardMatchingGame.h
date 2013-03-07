//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Josh Huerkamp on 3/4/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

enum {
	twoCardMatching     = 0,
    threeCardMatching,
    
};
typedef NSInteger cardGameMatchType;

@interface CardMatchingGame : NSObject

//designated initializer
- (id) initWithCardCount:(NSUInteger)count usindDeck:(Deck*)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic)int score;
@property (nonatomic)cardGameMatchType cardMatchType;
@property (strong, nonatomic)NSString *lastMoveResults;


@end
