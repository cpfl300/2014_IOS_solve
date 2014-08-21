//
//  DetailViewController.h
//  week6
//
//  Created by 김민주 on 2014. 8. 21..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property NSMutableData *imgData;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
