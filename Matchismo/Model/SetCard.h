//
//  SetCard.h
//  Matchismo
//
//  Created by Josh Huerkamp on 3/7/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//
//card has number, symbol, shading, and color
/////////////////////////////
//rules
////////////////////////////
//They all have the same number, or they have three different numbers.
//They all have the same symbol, or they have three different symbols.
//They all have the same shading, or they have three different shadings.
//They all have the same color, or they have three different colors.
//////////////////////////////////////////////////////

#import "Card.h"

enum
{
    solid = 0,
    striped,
    none
}; typedef NSInteger shading_value;

@interface SetCard : Card

@property (strong, nonatomic) NSMutableAttributedString *cardAttrString;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong)UIColor *colorValue;
@property (nonatomic, strong)NSString *shape;
@property (nonatomic)shading_value shadingValue;

+ (NSArray*)validShapes;
+ (NSArray*)validColors;


@end
