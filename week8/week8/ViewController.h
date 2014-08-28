//
//  ViewController.h
//  week8
//
//  Created by 김민주 on 2014. 8. 26..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarGraphView.h"
#import "PieGraphView.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet BarGraphView *barView;
@property (weak, nonatomic) IBOutlet PieGraphView *pieGraphView;

@end
