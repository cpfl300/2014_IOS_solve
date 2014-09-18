//
//  SongTableViewController.m
//  week11
//
//  Created by 김민주 on 2014. 9. 18..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "SongTableViewController.h"
#import "Song.h"
#import <sqlite3.h>

@interface SongTableViewController ()

@end

@implementation SongTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self openDB];
    _songs = [self getDatas];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _songs.count;
}

- (void)openDB{
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *databasePath = [bundlePath stringByAppendingPathComponent:@"top25.db"];
    
    int dbrc;
    dbrc = sqlite3_open([databasePath UTF8String], &_db);
    if(dbrc){
        NSLog(@"couldn't open DB...");
        return;
    }
}

- (NSMutableArray*)getDatas{
    NSMutableArray *songs = [[NSMutableArray alloc]init];
    NSString *queryStatement = [NSString stringWithFormat:@"SELECT ID, TITLE, CATEGORY, IMAGE FROM tbl_songs"];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(_db, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSNumber *id = [NSNumber numberWithInt:sqlite3_column_int(statement, 0)];
            NSString *title = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
            NSString *category = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
            NSString *img = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
            
            Song *song = [[Song alloc]initWithID:id andTitle:title andCategory:category withImg:img];
            [songs addObject:song];
        }
        sqlite3_finalize(statement);
    }
    return songs;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *item = [dataModel.data objectAtIndex:indexPath.row];
    Song *song = [_songs objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aSong" forIndexPath:indexPath];
    
    cell.textLabel.text = [song title];
    cell.detailTextLabel.text = [song category];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
