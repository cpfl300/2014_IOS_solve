//
//  MyView.m
//  week8
//
//  Created by 김민주 on 2014. 8. 26..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "MyView.h"
#define RAND_MAX 0x100000000

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void) drawRanLine{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for(int i = 0; i < 10; i++){
        CGPoint start = [self getRanPoint:0 and:320 with:0 and:568];
        [path moveToPoint:start];
        CGPoint end = [self getRanPoint:0 and:320 with:0 and:568];
        [path addLineToPoint:end];
        [path setLineWidth:5.0];
    }
    [path stroke];
}

- (void) drawCircle{
    CGContextRef ctx= UIGraphicsGetCurrentContext();

    for(int i=0; i < 10; i++){
        CGPoint center = [self getRanPoint:0 and:320 with:0 and:568];
        CGContextSaveGState(ctx);
        CGContextSetLineWidth(ctx,5);
        CGContextSetRGBFillColor(ctx, [self getRandomFloat:0.0 and:1.0], [self getRandomFloat:0.0 and:1.0], [self getRandomFloat:0.0 and:1.0], 1.0);

        
        CGContextAddArc(ctx, center.x, center.y, 30, 0.0, M_PI*2, YES);
        CGContextDrawPath(ctx, kCGPathFill);
    }
    

}

-(CGPoint) getRanPoint:(int)xMin and:(int)xMax with:(int)yMin and:(int)yMax{
    return CGPointMake((((float) arc4random() / RAND_MAX) * (xMax-xMin)) + xMin, (((float) arc4random() / RAND_MAX)* (yMax-yMin)) + yMin);
}

-(int) getRandomInt:(int)min and:(int)max{
    return min + arc4random() % (max - min);
}

-(float) getRandomFloat:(float)min and:(float)max{
    return ((double)arc4random() / RAND_MAX)* (max - min)+ min;
}

-(void) drawText{
    NSString *str = @"뀳";

    [[UIColor grayColor] set];
    UIFont * font = [UIFont fontWithName:@"ArialMT" size:30];
    [str drawAtPoint:[self getRanPoint:0 and:320-30 with:0 and:568] withFont:font];



}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [self gradient];
    CGPoint startP = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endP = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(ctxt, gradient, startP, endP, 0);
    CGGradientRelease(gradient);
    
    [self drawRanLine];
    [self drawCircle];
    [self drawText];
}

- (CGGradientRef) gradient{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0};
    NSArray *colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor purpleColor].CGColor, (id)[UIColor greenColor].CGColor];
//    NSMutableArray *setColor = [NSMutableArray alloc];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    return gradient;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}

@end
