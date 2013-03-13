//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/7/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    if (self)
    {
        for (NSString* shape in [SetCard validShapes])
        {
            for (NSUInteger rank=1; rank <= 3; rank++)
            {
                for (NSUInteger shadingValue=0; shadingValue<3; shadingValue++)
                {
                    for (UIColor *color in [SetCard validColors])
                    {
                        SetCard *card = [[SetCard alloc]init];
                        card.rank = rank;
                        card.shape = shape;
                        card.shadingValue = shadingValue;
                        card.colorValue = color;
                        //Initializer sets cardAttrString equal to shape string.
                        [card setCardAttrString:nil];
                        
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
