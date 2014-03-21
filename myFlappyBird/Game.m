//
//  Game.m
//  myFlappyBird
//
//  Created by Marcelo Sampaio on 3/21/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

@synthesize bird,startGame,birdMovement,birdFlight;

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
}


#pragma mark - UI Actions
- (IBAction)start:(UIButton *)sender
{
    self.startGame.hidden=YES;
    self.gameStarted=YES;
    self.birdMovement=[NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(birdMoving) userInfo:nil repeats:YES];
    
    
}

#pragma mark - Moving Methods
- (void)birdMoving
{
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

#pragma mark - Touch Events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Touches are accepted AFTER gae started
    if (!self.gameStarted) {
        return;
    }
    
    self.birdFlight=30;
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
