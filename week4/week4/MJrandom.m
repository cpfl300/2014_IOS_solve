//
//  MJrandom.m
//  week4
//
//  Created by 김민주 on 2014. 7. 31..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "MJrandom.h"

@implementation MJrandom

-(void)randomize{


    NSArray* choose = [[NSArray alloc]initWithObjects:@"가위", @"바위", @"보", nil];
    
    int ranNum = arc4random() % 3;
    NSString *ranResult = [choose objectAtIndex:ranNum];
    NSDictionary*result = [[NSDictionary alloc]initWithObjectsAndKeys: ranResult, @"result", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resultChanged" object:self userInfo:result];
    
}

@end
