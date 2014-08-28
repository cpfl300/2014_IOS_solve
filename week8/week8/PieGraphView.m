//
//  PieGraphView.m
//  week8
//
//  Created by 김민주 on 2014. 8. 28..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "PieGraphView.h"

@implementation PieGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(float) getRandomFloat:(float)min and:(float)max{
    return ((double)arc4random() / RAND_MAX)* (max - min)+ min;
}

- (void) drawPie{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(100, 100);

    float all = 0;
    for(int i = 0 ; i < _data.count; i++){
        all += [[[_data objectAtIndex:i]objectForKey:@"percentage"] intValue];
    }
    
    float startAngle = 0;

    for(int i=0; i < _data.count; i++){
        float value = [[[_data objectAtIndex:i]objectForKey:@"percentage"] intValue];
        CGContextSaveGState(ctx);
        CGContextSetLineWidth(ctx,5);
        CGContextSetRGBFillColor(ctx, [self getRandomFloat:0.0 and:1.0], [self getRandomFloat:0.0 and:1.0], [self getRandomFloat:0.0 and:1.0], 1.0);
        CGContextMoveToPoint(ctx, center.x, center.y);
        CGContextAddArc(ctx, center.x, center.y, 98, startAngle, startAngle -M_PI*2 *value /all, YES);
        
        CGContextDrawPath(ctx, kCGPathFill);
        
        
        CGFloat x = center.x + (98+10) * (cos((startAngle-90)*M_PI/180.0) + cos(((startAngle -M_PI*2 *value /all)-90)*M_PI/180.0)) / 2;
        CGFloat y = center.y + (98+10) * (sin((startAngle-90)*M_PI/180.0) + sin(((startAngle -M_PI*2 *value /all)-90)*M_PI/180.0)) / 2;
        
        startAngle -= M_PI*2 *value /all;
        
        NSString *month = [[_data objectAtIndex:i]objectForKey:@"title"];
        [[UIColor grayColor] set];
        UIFont * font = [UIFont fontWithName:@"ArialMT" size:18];
        [month drawAtPoint:CGPointMake(x, y) withFont:font];
        
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawPie];
}


@end
