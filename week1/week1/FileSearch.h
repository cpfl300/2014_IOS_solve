//
//  FileSearch.h
//  week1
//
//  Created by 김민주 on 2014. 7. 15..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSearch : NSObject

@property NSFileManager *manager;

-(NSMutableArray*) findAllFileToArray: (NSString*) path;
-(void) printAllSubFiles: (NSString*) path;
-(void) isExistFilename: (NSString*) findfile At:(NSString*) path;

@end
