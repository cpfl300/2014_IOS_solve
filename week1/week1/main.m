//
//  main.m
//  week1
//
//  Created by 김민주 on 2014. 7. 10..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileSearch.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSURL *myURL = [NSURL URLWithString:
                        @"file:////Users/Kimminju/Documents/2-2NEXT/DBA"];
        NSString *path = [myURL path];
        FileSearch *fs = [[FileSearch alloc]init];
        
        NSArray* temp = [fs findAllFileToArray: path];
        NSSortDescriptor* sortDiscriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
        NSArray* sortedArray = [temp sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDiscriptor, nil]];
        
//        for(NSString* name in sortedArray){
//            NSLog(@"%@", name);
//        }
        
        [fs printAllSubFiles:path];
        
        [fs isExistFilename:@"2.복제.pdf" At:path];
        

    }
    return 0;
}

