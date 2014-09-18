//
//  SongTableViewController.h
//  week11
//
//  Created by 김민주 on 2014. 9. 18..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SongTableViewController : UITableViewController
@property sqlite3 *db;
@property NSMutableArray* songs;

@end
