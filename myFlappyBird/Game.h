//
//  Game.h
//  myFlappyBird
//
//  Created by Marcelo Sampaio on 3/21/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Game : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *bird;
@property (weak, nonatomic) IBOutlet UIButton *startGame;


@property (strong,nonatomic) NSTimer *birdMovement;
@property int birdFlight;


@property BOOL gameStarted;

- (IBAction)start:(UIButton *)sender;
- (void)birdMoving;
@end
