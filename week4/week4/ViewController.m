//
//  ViewController.m
//  week4
//
//  Created by 김민주 on 2014. 7. 31..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "ViewController.h"
#import "MJrandom.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //add observer
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"resultChanged"
                                               object:nil];
    
    //method call
    MJrandom *ran = [[MJrandom alloc]init];
    [ran randomize];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receivedNotification:(NSNotification *) notification {
    NSDictionary *dict = [notification userInfo];
    NSString* result = [dict objectForKey:@"result"];

    UIImage * picture;
    if([result isEqualToString:@"가위"]){
        picture = [UIImage imageNamed:@"scissors.jpg"];
    } else if([result isEqualToString:@"바위"]){
        picture = [UIImage imageNamed:@"rock.jpg"];
    } else if([result isEqualToString:@"보"]){
        picture = [UIImage imageNamed:@"paper.jpg"];
    }
    
    _img.image = picture;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        MJrandom *ran = [[MJrandom alloc]init];
        [ran randomize];
    }
}


@end
