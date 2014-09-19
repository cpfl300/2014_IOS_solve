//
//  SongTableViewController.h
//  week11
//
//  Created by 김민주 on 2014. 9. 18..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SongTableViewController : UITableViewController<NSXMLParserDelegate>

@property sqlite3 *db;
@property sqlite3 *feedDb;
@property NSMutableArray* songs;

@property BOOL itemFlag;
@property NSMutableArray* Unit;
@property NSString* nowTagStr;
//지울 것

@property NSMutableString* txtBuffer;

@end
