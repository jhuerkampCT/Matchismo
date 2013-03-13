//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/4/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardMatchSwitch;
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;

//@property (strong, nonatomic)Deck *deck; // remove because CardMatchingGame handles deck
@property (strong, nonatomic)CardMatchingGame *game; //create instance of model cardMatchingGame

@end

@implementation CardGameViewController

- (CardMatchingGame*)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usindDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}

//
//Remove after CardMatchingGame implemented above
//- (Deck*)deck
//{
//    if (!_deck) _deck = [[PlayingCardDeck alloc]init];
//    return _deck;
//}

- (void)setCardButtons:(NSArray *)cardButtons
{
    
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{    
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        if (!cardButton.selected)
        {
            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
            [cardButton setImage:[UIImage imageNamed:@"AppleImage.png"] forState:UIControlStateNormal];
        }
        else
            [cardButton setImage:nil forState:UIControlStateNormal];
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score :%d",[self.game score]];
    }
    [self.gameStatusLabel setText:[self.game lastMoveResults]];
    
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.cardMatchSwitch setEnabled:NO];
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
}

- (IBAction)cardMatchSwitchChanged:(UISegmentedControl *)sender
{
    self.game.cardMatchType = sender.selectedSegmentIndex;
}

- (IBAction)restartCardGame:(id)sender
{
    [self.cardMatchSwitch setEnabled:YES];
    self.cardMatchSwitch.selectedSegmentIndex = 0;
    
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}



@end
