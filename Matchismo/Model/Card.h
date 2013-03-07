//
//  Card.h
//  Matchismo
//
//  Created by Josh Huerkamp on 3/4/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong,nonatomic)NSString* contents;
@property (nonatomic, getter = isFaceUp)BOOL faceUp;
@property (nonatomic, getter = isUnplayable)BOOL unplayable;

- (int)match:(NSArray*)otherCards;

@end
