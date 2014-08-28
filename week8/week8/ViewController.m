//
//  ViewController.m
//  week8
//
//  Created by 김민주 on 2014. 8. 26..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "ViewController.h"
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    NSMutableArray *data = [[NSMutableArray alloc]initWithObjects:[[NSDictionary alloc]initWithObjectsAndKeys:@"April", @"title", @5, @"value", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"May", @"title", @12, @"value", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"June", @"title", @18, @"value", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"July", @"title", @11, @"value", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"August", @"title", @15, @"value", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"September", @"title", @9, @"value", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"October", @"title", @17, @"value", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"Nobember", @"title", @25, @"value", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"December", @"title", @31, @"value", nil], nil];
    _barView.data = data;
    [_barView setBackgroundColor:RGBA(45, 100, 245, 0.3)];
    
    NSString* sPie = @"[{\"title\":\"April\", \"percentage\":18},{\"title\":\"May\", \"percentage\":12},{\"title\":\"June\",\"percentage\":18},{\"title\":\"July\", \"percentage\":13},{\"title\":\"August\", \"percentage\":18},{\"title\":\"September\", \"percentage\":9},{\"title\":\"October\", \"percentage\":18}]";
    NSError* error;
    NSData *dPie = [sPie dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* aPie = [NSJSONSerialization JSONObjectWithData:dPie options:kNilOptions error:&error];

    _pieGraphView.data = aPie;
    [_pieGraphView setBackgroundColor:RGBA(45, 100, 245, 0.3)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
