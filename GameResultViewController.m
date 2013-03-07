//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Josh Huerkamp on 3/7/13.
//  Copyright (c) 2013 Josh Huerkamp. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()

@end

@implementation GameResultViewController

- (void) setup
{
    //Initialization that can't wait until viewDidLoad.
}

- (void)awakeFromNib
{
    [self setup];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}


@end
