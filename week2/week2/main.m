//
//  main.m
//  week2
//
//  Created by 김민주 on 2014. 7. 19..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "convertor.h"
#import "makeJson.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        NSString* array_sample = @"[{\"id\":\"001\", \"name\":\"john\"},{\"id\":\"007\",\"name\":\"james\"}]";
        NSString* dict_sample = @"{\"id\":007,\"name\":\"james\",\"weapons\":[gun,pen]}";
        
        NSString* simple_arr = @"[test1, test2, test3]";
        NSString* simple_dic = @"{key:val, key2:3, key3:val3}";
        
        convertor* cv = [[convertor alloc]init];

//        NSArray* simple_ar = [cv convertingStringToDicOrArr: simple_arr];
//        NSDictionary* simple_di = [cv convertingStringToDicOrArr: simple_dic];
        NSArray* ar_sample = [cv convertingStringToDicOrArr: array_sample];
        NSDictionary* di_sample = [cv convertingStringToDicOrArr: dict_sample];
        
        makeJson *mj = [[makeJson alloc]init];
        NSLog(@"%@",[mj convertToJson:di_sample]);
        
    }
    return 0;
}

