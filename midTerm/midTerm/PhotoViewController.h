//
//  PhotoViewController.h
//  midTerm
//
//  Created by 김민주 on 2014. 8. 12..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property NSDictionary* selectedData;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
@property (weak, nonatomic) IBOutlet UIImageView *viewImage;
@property (weak, nonatomic) IBOutlet UILabel *viewDate;

@end
