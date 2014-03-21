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

@property (weak, nonatomic) IBOutlet UIImageView *tunnelTop;
@property (weak, nonatomic) IBOutlet UIImageView *tunnelBottom;
@property (weak, nonatomic) IBOutlet UIImageView *top;
@property (weak, nonatomic) IBOutlet UIImageView *bottom;

@property (strong,nonatomic) NSTimer *birdMovement;
@property (strong,nonatomic) NSTimer *tunnelMovement;


@property int birdFlight;
@property int randomTopTunnelPosition;
@property int randomBottomTunnelPosition;



@property BOOL gameStarted;


#pragma mark - UI Actions
- (IBAction)start:(UIButton *)sender;


#pragma mark - Moving Methods
- (void)birdMoving;

- (void)tunnelMoving;

#pragma mark - Working Methods
-(void)placeTunnels;

@end
