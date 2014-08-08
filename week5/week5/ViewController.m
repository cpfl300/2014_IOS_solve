//
//  ViewController.m
//  week5
//
//  Created by 김민주 on 2014. 8. 7..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat imgheight;
    NSMutableDictionary* imgViews;
    NSArray *imgName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger imgNum = 22;
    CGFloat curYLoc = 0;
    imgheight = _scrollView.frame.size.height/2; //284.00

    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, imgheight*imgNum);
    
    imgName = [[NSArray alloc]initWithObjects:@"01.jpg", @"02.jpg", @"03.jpg", @"04.jpg", @"05.jpg", @"06.jpg", @"07.jpg", @"08.jpg", @"09.jpg", @"10.jpg", @"11.jpg", @"12.jpg", @"13.jpg", @"14.jpg", @"15.jpg", @"16.jpg", @"17.jpg", @"18.jpg", @"19.jpg", @"20.jpg", @"21.jpg", @"22.jpg", nil];
    
    imgViews = [[NSMutableDictionary alloc] init];
    for(int i=0; i < imgName.count; i++){
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, imgheight)];
        img.image = [UIImage imageNamed:[imgName objectAtIndex:i]];
        CGRect frame = img.frame;
        frame.origin = CGPointMake(0, curYLoc);
        img.frame = frame;
        curYLoc += imgheight;
        [imgViews setObject:img forKey:[imgName objectAtIndex:i]];
    }
    
    
    NSInteger fitstviewCount = _scrollView.frame.size.height/imgheight;

    for(int i=0; i < fitstviewCount; i++){
        [_scrollView addSubview:[imgViews objectForKey:[imgName objectAtIndex:i]]];
    }
    
//    UIImageView* temp = [imgViews objectForKey:@"01.jpg"];
//    [temp removeFromSuperview];
//    [_scrollView addSubview:[imgViews objectForKey:@"01.jpg"]];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"스크롤 WILL: %@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int Start = (int)ceil(scrollView.contentOffset.y/imgheight);
    int End = (int)ceil(Start + scrollView.frame.size.height/imgheight);
    
    for(int i=0; i < imgViews.count; i++){
        if(Start-1 <= i && i < End){
            if(![[imgViews objectForKey:[imgName objectAtIndex:i]] isDescendantOfView:scrollView]){
                [_scrollView addSubview:[imgViews objectForKey:[imgName objectAtIndex:i]]];
            }
        } else {
            if([[imgViews objectForKey:[imgName objectAtIndex:i]] isDescendantOfView:scrollView]){
                [[imgViews objectForKey:[imgName objectAtIndex:i]] removeFromSuperview];
            }
        }
    }

}



@end
