//
//  ViewController.m
//  myFlappyBird
//
//  Created by Marcelo Sampaio on 3/21/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize highScoreLabel;


#pragma mark - Initialization
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    // Load score data
    [self loadScore];
}

#pragma mark - Working Methods
-(void)loadScore
{
    // Get stored score
    NSString *storedScore=[[NSUserDefaults standardUserDefaults] objectForKey:@"score"];
    int numericStoredScore=[storedScore intValue];
    
    NSMutableString *temp=[NSMutableString stringWithFormat:@"Higher Score: "];
    [temp appendFormat:@"%d",numericStoredScore];
    self.highScoreLabel.text=temp;
}


#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
