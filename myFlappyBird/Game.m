//
//  Game.m
//  myFlappyBird
//
//  Created by Marcelo Sampaio on 3/21/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "Game.h"

#define JUMP_HEIGTH 25.00f // Higher jump is harder to achieve
#define TUNNEL_GAP 655.00f // Bigger GAP makes the 

@interface Game ()



@end

@implementation Game

@synthesize bird,startGame,birdMovement,birdFlight;
@synthesize top,bottom,tunnelBottom,tunnelTop,tunnelMovement;
@synthesize randomBottomTunnelPosition,randomTopTunnelPosition;
@synthesize collisionDetected;
@synthesize soundId;
@synthesize score,scoreLabel;

#pragma mark - Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gameStarted=NO;
    
    self.tunnelTop.hidden=YES;
    self.tunnelBottom.hidden=YES;
    self.scoreLabel.hidden=YES;
}


#pragma mark - UI Actions
- (IBAction)start:(UIButton *)sender
{
    self.score=0;
    self.scoreLabel.text=[NSString stringWithFormat:@"%d",score];
    self.passedByTheGAP=NO;
    self.collisionDetected=NO;
    self.tunnelTop.hidden=NO;
    self.tunnelBottom.hidden=NO;
    self.scoreLabel.hidden=NO;
    self.startGame.hidden=YES;
    self.gameStarted=YES;
    self.birdMovement=[NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(birdMoving) userInfo:nil repeats:YES];
    
    [self placeTunnels];
    self.tunnelMovement=[NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(tunnelMoving) userInfo:nil repeats:YES];
    
}

#pragma mark - Moving Methods
- (void)birdMoving
{
    [self gap];
    [self collision];
    
    
    if (collisionDetected) {
        self.gameStarted=NO;

        [self.birdMovement invalidate];
        [self.tunnelMovement invalidate];
        
        // fart sound
        NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"fartSound" ofType:@"wav"]];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        AudioServicesPlaySystemSound(soundId);
        // end sound
        
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Flappy Bird" message:@"Game Over" delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    self.bird.center=CGPointMake(self.bird.center.x, self.bird.center.y - self.birdFlight);
    // make the bird fall any tick
    self.birdFlight=self.birdFlight-5;
    
    // Limit bottom
    if (self.birdFlight < -15) {
        self.birdFlight = -15;
    }
    
    // changing bird's face (depending on moving up or down)
    //  birdFlight >0 he is going up screen
    if (self.birdFlight>0) {
        self.bird.image=[UIImage imageNamed:@"birdUp.png"];
    }
    
    if (self.birdFlight<0) {
        self.bird.image=[UIImage imageNamed:@"birdDown.png"];
    }
}

- (void)tunnelMoving
{
    self.tunnelTop.center=CGPointMake(self.tunnelTop.center.x - 1, self.tunnelTop.center.y);
    self.tunnelBottom.center=CGPointMake(self.tunnelBottom.center.x - 1, self.tunnelBottom.center.y);
    
    if (self.tunnelTop.center.x<-28) {
        [self placeTunnels];
    }
    
    
}

#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clicked alert=%@   buttonIndex=%d",alertView.title,buttonIndex);
    if (buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.tunnelTop.hidden=YES;
        self.tunnelBottom.hidden=YES;
    }
    
    
}

#pragma mark - Working Methods
-(void)placeTunnels
{
    self.passedByTheGAP=NO;
    // Top tunnel will be betwenn Y=-228 and Y=122
    self.randomTopTunnelPosition=arc4random() %350;
    self.randomTopTunnelPosition=self.randomTopTunnelPosition - 228;
    
    // Fixed GAP always ::: difficult can be set in GAP  (+ or -)
    self.randomBottomTunnelPosition=self.randomTopTunnelPosition+TUNNEL_GAP;
    
    self.tunnelTop.center=CGPointMake(340, randomTopTunnelPosition);
    self.tunnelBottom.center=CGPointMake(340, randomBottomTunnelPosition);
    
}

-(void)collision
{
    // Top collisions
    if (CGRectIntersectsRect(self.bird.frame, self.top.frame)) {
        self.collisionDetected=YES;
    }
    
    // Bottom collisions
    if (CGRectIntersectsRect(self.bird.frame, self.bottom.frame)) {
        self.collisionDetected=YES;
    }

    // topTunnel collision
    if (CGRectIntersectsRect(self.bird.frame, self.tunnelTop.frame)) {
        self.collisionDetected=YES;
    }

    // bottomTunnel collision
    if (CGRectIntersectsRect(self.bird.frame, self.tunnelBottom.frame)) {
        self.collisionDetected=YES;
    }

    
}

-(void)gap
{
    if (self.passedByTheGAP) {
        return;
    }
    
    if (self.bird.center.x>self.tunnelTop.center.x) {
        // beep sound
        NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep" ofType:@"wav"]];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        AudioServicesPlaySystemSound(soundId);
        // end sound
        self.passedByTheGAP=YES;
        score=score+1;
        self.scoreLabel.text=[NSString stringWithFormat:@"%d",score];
    }
}

#pragma mark - Touch Events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Touches are accepted AFTER gae started
    if (!self.gameStarted) {
        return;
    }
    
    // Flapp sound
    NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"flapSound" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
    AudioServicesPlaySystemSound(soundId);
    // end sound
    
    
    self.birdFlight=JUMP_HEIGTH;
}


#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
