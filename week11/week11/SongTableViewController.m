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
    _Unit = [[NSMutableArray alloc]init];
    _txtBuffer = [[NSMutableString alloc]init];
//    [self openDB];
//    _songs = [self getDatas];
    
    [self makeDocumentDirDB];
    [self getXMLData:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
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

- (void) makeDocumentDirDB{
    //    경로를 정해서 sqlite.db파일을 폴더에 넣는다
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"newsfeed.db"];
    
    //  db가 원래 존재하는지 체크
    bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
    if(sqlite3_open([databasePath UTF8String], &_feedDb) == SQLITE_OK){
        if(!databaseAlreadyExists){
            //  create tbl_newsfeed table
            const char *sqlStatement = "CREATE TABLE IF NOT EXISTS tbl_newsfeed (TITLE TEXT PRIMARY KEY, LINK TEXT, DESCRIPTION TEXT, PUBDATE TEXT)";
            char* error;
            
            if(sqlite3_exec(_feedDb, sqlStatement, NULL, NULL, &error) == SQLITE_OK){
                NSLog(@"DB table created");
            } else {
                NSLog(@"Error: %s", error);
            }
        }
    }
}

-(void) getXMLData:(NSString*)urlstr{
    NSURL *url = [[NSURL alloc] initWithString:urlstr];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    xmlParser.delegate = self;
    [xmlParser parse];//start
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
//    초기화
    _nowTagStr = @"";
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"item"]){
        _itemFlag = YES;
//        NSLog(@"[item]");
    }
    if(([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"link"] || [elementName isEqualToString:@"description"] || [elementName isEqualToString:@"pubDate"])&&_itemFlag){
		_nowTagStr = [NSString stringWithString:elementName];
//		_txtBuffer = @"";
//        NSLog(@"%@", _nowTagStr);
	}

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([_nowTagStr isEqualToString:@"title"] || [_nowTagStr isEqualToString:@"link"] || [_nowTagStr isEqualToString:@"description"] || [_nowTagStr isEqualToString:@"pubDate"]) {
        
        if(_itemFlag == YES&& ![string isEqualToString:@"\n"]){
            // 텍스트 버퍼에 문자열을 추가한다.
//            NSLog(@"%@", string);
            [_txtBuffer appendString:string];
//            [_Unit addObject:string];
//            NSLog(@"%@", _Unit);
//            _txtBuffer = [_txtBuffer stringByAppendingFormat:string];
        }
	}
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([_nowTagStr isEqualToString:@"title"] || [_nowTagStr isEqualToString:@"link"] || [_nowTagStr isEqualToString:@"description"] || [_nowTagStr isEqualToString:@"pubDate"]){
        if([elementName isEqualToString:_nowTagStr]){
            [_Unit addObject:_txtBuffer];
            _txtBuffer = [NSMutableString stringWithString:@""];
        }
    }
    if([elementName isEqualToString:@"item"]){
        [self insertXML:_Unit];
        [_Unit removeAllObjects];
    }
}

- (void) insertXML:(NSMutableArray*)dic{
//    NSLog(@"%d", dic.count);
    NSString* title = dic[0];
    NSString* link = dic[1];
    NSString* description = dic[2];
    NSString* pubDate = dic[3];
    
    NSString* query = [[NSString alloc]initWithFormat:@"insert into \"tbl_newsfeed\" (title, link, description, pubDate) values(\"%@\" ,\"%@\" ,\"%@\" ,\"%@\")", title, link, description, pubDate];
    
    char *error;
    if(sqlite3_exec(_feedDb, [query UTF8String], NULL, NULL, &error) == SQLITE_FAIL){
        NSLog(@"FAIL");
    }
    
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
