//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/7/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetMatchingGame.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setCardButtons;
@property (strong, nonatomic) SetMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;


@end

@implementation SetGameViewController

- (SetMatchingGame*)game
{
    if (!_game) _game = [[SetMatchingGame alloc]initWithCardCount:[self.setCardButtons count] usindDeck:[[SetCardDeck alloc]init]];
    return _game;
}

- (void)setSetCardButtons:(NSArray *)setCardButtons
{
    _setCardButtons = setCardButtons;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (void) updateUI
{	
    for (UIButton *setButton in self.setCardButtons)
    {
        SetCard *card = (SetCard*)[self.game cardAtIndex:[self.setCardButtons indexOfObject:setButton]];
        [setButton setAttributedTitle:card.cardAttrString forState:UIControlStateNormal];
        //[setButton setTitle:[card.cardAttrString string] forState:UIControlStateNormal];
        [setButton setTitleColor:card.colorValue forState:UIControlStateNormal];
        
        setButton.selected = card.isFaceUp;
        if (setButton.isSelected)
        {
            [setButton setBackgroundColor:[UIColor lightGrayColor]];
        }
        else
        {
            [setButton setBackgroundColor:[UIColor whiteColor]];
        }
        setButton.enabled = !card.isUnplayable;
        setButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
    }
    
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score :%d",[self.game score]];
    self.lastMoveLabel.attributedText = self.game.lastMoveAttrString;
    self.scoreLabel.attributedText = self.game.lastMoveAttrString;


}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.setCardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}


- (IBAction)dealNewDeck:(UIButton *)sender
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


@end
