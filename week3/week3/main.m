//
//  main.m
//  week3
//
//  Created by 김민주 on 2014. 7. 24..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberPuzzle.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NumberPuzzle *np = [[NumberPuzzle alloc]init];
        [np createPuzzle:3 By:3];
        
        //키 입력 받아오기
        //사용자에게 특정 문자열 입력받거나 다 맞추면 while문 종료
        
//        while(true){
//            NSString* str = [[NSString alloc]init];
//            scanf("%s",str);
//            NSString* mystr = [NSString stringWithUTF8String:str];
//            NSLog(@"%@",mystr);
//        }
        [np release];
        
    }
    
    return 0;
}

