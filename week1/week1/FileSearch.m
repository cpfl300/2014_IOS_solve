//
//  FileSearch.m
//  week1
//
//  Created by 김민주 on 2014. 7. 15..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "FileSearch.h"

@implementation FileSearch

-(NSMutableArray*) findAllFileToArray: (NSString*) path{
    NSMutableArray* files = [[NSMutableArray alloc] init];
    
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:path];
    
    for(NSString *filename in fileEnumerator){
        [files addObject:filename];
    }
    
    return files;
}


-(void) printAllSubFiles: (NSString*) path
{
    NSArray* fileList = [self findAllFileToArray: path];
    for(NSString* fileName in fileList){
        NSLog(@"%@\n",fileName);
    }
}

-(void) isExistFilename: (NSString*) findfile At:(NSString*) path
{
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:path];
    
    for(NSString *filename in fileEnumerator){
        if([filename isEqualToString:findfile] == 1){
            NSLog(@"FIND \"%@\" file!! \n",filename);
            return;
        }
    }
    NSLog(@"I DON'T HAVE \"%@\" file...\n",findfile);
}


@end
