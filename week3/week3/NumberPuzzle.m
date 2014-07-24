//
//  NumberPuzzle.m
//  week3
//
//  Created by 김민주 on 2014. 7. 24..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "NumberPuzzle.h"

@implementation NumberPuzzle
    NSMutableArray* puzzle;

-(void)createPuzzle:(int)xSize By:(int)ySize{
    if(xSize == ySize){
        NSMutableArray* col = [[NSMutableArray alloc]init];

        NSNumber* temp;
        for(int i = 0; i < xSize; i++){
            NSMutableArray* row = [[NSMutableArray alloc]init];
            for(int j = 1; j <= xSize; j++){
                if(i*xSize+j == xSize*ySize){
                   temp = [[NSNumber alloc]initWithInt:0];
                }else{
                    temp = [[NSNumber alloc]initWithInt:i*xSize+j];
                }
                
                [row addObject:temp];
                [temp release];
            }
            [col addObject:row];
            [row release];
        }
        puzzle = col;

        //퍼즐 섞기
        [self mixedNum:xSize];
        [self printPuzzle];
    }else{
        NSLog(@"xSize와 ySize를 갖게 해주세요!");
    }
}

-(void) printPuzzle {
    int size = [puzzle count];
    NSMutableString* result = [[NSMutableString alloc]init];
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            NSNumber* num = [[puzzle objectAtIndex:i]objectAtIndex:j];
            NSString* append = [NSString stringWithFormat:@"%@",num];
            [result appendString: append];
            [result appendString:@" "];

        }
        [result appendString:@"\n"];
    }

    NSLog(@"%@", result);
    [result release];
}

-(void) swap: (int)srcCol And:(int)srcRow To:(int)destCol And:(int)destRow{
    NSNumber* src = [[puzzle objectAtIndex:srcCol-1]objectAtIndex:srcRow-1];
    NSNumber* dest = [[puzzle objectAtIndex:destCol-1]objectAtIndex:destRow-1];
    [[puzzle objectAtIndex:srcCol-1] replaceObjectAtIndex:srcRow-1 withObject:dest];
    [[puzzle objectAtIndex:destCol-1] replaceObjectAtIndex:destRow-1 withObject:src];

    
}

-(void) mixedNum:(int)puzzleRow{
    for(int i = 0 ; i < puzzleRow; i++){
        [self swap:(1+arc4random()%puzzleRow) And:(1+arc4random()%puzzleRow) To:(1+arc4random()%puzzleRow) And:(1+arc4random()%puzzleRow)];
    }
    
}


@end
