//
//  main.m
//  week1
//
//  Created by 김민주 on 2014. 7. 10..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <Foundation/Foundation.h>

void printAllSubFiles(NSString *path){
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:path];
    
    for(NSString *filename in fileEnumerator){
        NSLog(@"%@\n",filename);
    }
    
}

NSMutableArray* findAllFileToArray(NSString *path){
    NSMutableArray* files = [[NSMutableArray alloc] init];
    
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:path];
    
    for(NSString *filename in fileEnumerator){
        [files addObject:filename];
    }
    
    return files;
}

void isExistFilename(NSString* findfile, NSString* path){
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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSURL *myURL = [NSURL URLWithString:
                        @"file:////Users/Kimminju/Documents/2-2NEXT/IOS"];
        NSString *path = [myURL path];
//        printAllSubFiles(path);
        
//        NSArray* temp = findAllFileToArray(path);
        
        
        NSString* temp = @"2014_IOS_solve";
        isExistFilename(temp, path);

        

    }
    return 0;
}

