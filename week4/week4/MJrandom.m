//
//  MJrandom.m
//  week4
//
//  Created by 김민주 on 2014. 7. 31..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "MJrandom.h"

@implementation MJrandom

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //to save observer
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveLast:)
                                                     name:@"save"
                                                   object:nil];
   
    }
    return self;
}

-(void)randomize{
    NSArray* choose = [[NSArray alloc]initWithObjects:@"가위", @"바위", @"보", nil];
    
    int ranNum = arc4random() % 3;
    NSString *ranResult = [choose objectAtIndex:ranNum];
    _lastVal = ranResult;
    NSDictionary*result = [[NSDictionary alloc]initWithObjectsAndKeys: ranResult, @"result", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resultChanged" object:self userInfo:result];
}

- (void)saveLast:(NSNotification *) notification {
    
}

@end
