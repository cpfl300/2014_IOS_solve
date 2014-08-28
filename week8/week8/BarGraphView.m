//
//  BarGraphView.m
//  week8
//
//  Created by 김민주 on 2014. 8. 28..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "BarGraphView.h"
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation BarGraphView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) drawLine :(CGPoint)start and:(CGPoint)end{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:start];
    [path addLineToPoint:end];
    [path setLineWidth:20.0];
    [RGBA(0, 0, 255, 0.5) set];
    [path stroke];
}

-(void) drawGraph{
    NSString* month = [NSString alloc];
    CGPoint start;
    CGPoint end;
    int lineStartPoint = 50;
    for(int i = 0 ; i < 4; i++){
        month = [[_data objectAtIndex:i]objectForKey:@"title"];
        int val = [[[_data objectAtIndex:i]objectForKey:@"value"] intValue];
        
        [[UIColor grayColor] set];
        UIFont * font = [UIFont fontWithName:@"ArialMT" size:18];
        [month drawAtPoint:CGPointMake(6.0, 1.0 * (i* 50) + 10) withFont:font];
        start = CGPointMake(lineStartPoint, (i* 50) + 20);
        end = CGPointMake(lineStartPoint + val*8, (i* 50) + 20);
        [self drawLine:start and:end];
    }
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawGraph];
}


@end
