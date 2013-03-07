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
#import "Game.h"

enum {
	twoCardMatching     = 0,
    threeCardMatching,
    
};
typedef NSInteger cardGameMatchType;

@interface CardMatchingGame : Game

//designated initializer

@property (nonatomic)cardGameMatchType cardMatchType;


@end
