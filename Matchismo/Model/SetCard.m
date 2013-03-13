//
//  SetCard.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/7/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "SetCard.h"
//card has number, symbol, shading, and color
/////////////////////////////
//rules
////////////////////////////
//They all have the same number, or they have three different numbers.
//They all have the same symbol, or they have three different symbols.
//They all have the same shading, or they have three different shadings.
//They all have the same color, or they have three different colors.
//////////////////////////////////////////////////////


@implementation SetCard
@synthesize cardAttrString = _cardAttrString, rank = _rank, colorValue = _colorValue;
@synthesize shape = _shape, shadingValue = _shadingValue;

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2)
    {
        SetCard *secondCard = otherCards[0];
        SetCard *thirdCard = [otherCards lastObject];
        
        if ((self.rank == secondCard.rank && self.rank == thirdCard.rank) ||
            (self.rank != secondCard.rank && self.rank != thirdCard.rank && secondCard.rank != thirdCard.rank))
        {
            if (([self.colorValue isEqual:secondCard.colorValue] && [self.colorValue isEqual:thirdCard.colorValue]) ||
                (![self.colorValue isEqual:secondCard.colorValue] && ![self.colorValue isEqual:thirdCard.colorValue] && ![secondCard.colorValue isEqual:thirdCard.colorValue]))
            {
                if (([self.shape isEqualToString:secondCard.shape] && [self.shape isEqualToString:thirdCard.shape]) ||
                    (![self.shape isEqualToString:secondCard.shape] && ![self.shape isEqualToString:thirdCard.shape] && ![secondCard.shape isEqualToString:thirdCard.shape]))
                {
                    if ((self.shadingValue == secondCard.shadingValue && self.shadingValue == thirdCard.shadingValue) ||
                        (self.shadingValue != secondCard.shadingValue && self.shadingValue != thirdCard.shadingValue && secondCard.shadingValue != thirdCard.shadingValue))
                    {
                        score = 30;
                    }
                }
            }
        }
    }
    
    return score;
}

- (NSString*)contents
{
    //return rank, color, shading, shape
    return [NSString stringWithFormat:@"%d, %@, %d, %@", self.rank, self.colorValue, self.shadingValue, self.shape];
    
}

 +(NSArray*)validShapes
{
    return @[@"◆",@"●",@"■"];
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape])
    {
        _shape = @"";
        for (NSUInteger currentRank=0; currentRank<self.rank; currentRank++)
        {
            _shape = [_shape stringByAppendingString:[NSString stringWithFormat:@"%@", shape]];
        }
        
        //_shape = [_shape stringByAppendingString:[NSString stringWithFormat:@"%d", _shadingValue]];
    }
}

//Inits the NSAttributedString equal to the shape NSString
- (void)setCardAttrString:(NSMutableAttributedString *)cardAttrString
{
    if (_shape)
        if (!_cardAttrString) _cardAttrString = [[NSMutableAttributedString alloc]initWithString:_shape];
    
    [self setAttributesForCardAttrString];
}

- (void) setAttributesForCardAttrString
{
    NSInteger _stringLength=[self.cardAttrString length];
        
    switch (self.shadingValue) {
        case solid:
            [self.cardAttrString addAttribute:NSForegroundColorAttributeName value:self.colorValue range:NSMakeRange(0, _stringLength)];
            break;
        case striped:
        {
            [self.cardAttrString addAttribute:NSStrokeWidthAttributeName value:@-5 range:NSMakeRange(0, _stringLength)];
            [self.cardAttrString addAttribute:NSStrokeColorAttributeName value:self.colorValue range:NSMakeRange(0, _stringLength)];
            [self.cardAttrString addAttribute:NSForegroundColorAttributeName value:[self.colorValue colorWithAlphaComponent:0.2] range:NSMakeRange(0, _stringLength)];
        }
            break;
        case none:
        {
            [self.cardAttrString addAttribute:NSStrokeWidthAttributeName value:@-5 range:NSMakeRange(0, _stringLength)];
            [self.cardAttrString addAttribute:NSStrokeColorAttributeName value:self.colorValue range:NSMakeRange(0, _stringLength)];
            [self.cardAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, _stringLength)];
        }
            break;
    }
}

- (void)setShadingValue:(shading_value)shadingValue
{
    if (shadingValue < 3)
    {
        _shadingValue = shadingValue;
    }
}

+ (NSArray*)validColors
{
    return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}



- (void)setRank:(NSUInteger)rank
{
    if (rank < 4 && rank > 0)
    {
        _rank = rank;
    }
    
}
@end
