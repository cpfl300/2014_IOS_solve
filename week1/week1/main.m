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

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSURL *myURL = [NSURL URLWithString:
                        @"file:////Users/Kimminju/Documents/2-2NEXT/IOS"];
        NSString *path = [myURL path];
        printAllSubFiles(path);
    }
    return 0;
}

