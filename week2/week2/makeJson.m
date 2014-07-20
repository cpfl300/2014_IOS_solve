//
//  makeJson.m
//  week2
//
//  Created by 김민주 on 2014. 7. 20..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "makeJson.h"

@implementation makeJson

-(NSString*)convertToJson: (id)target {
    NSString* cla = [self findClass:target];
    
    if([cla isEqualToString:@"Array"]){
        return [self arrayToString:target];
    } else if([cla isEqualToString:@"Dictionary"]){
        return [self dicToString:target];
    }else{
        return NULL;
    }
}

-(NSString*)arrayToString:(NSArray*)arr{

    NSMutableString* concat = [[NSMutableString alloc]init];
    int arrLength = [arr count];
    
    for(int i = 0; i < arrLength; i++){
        NSString* cla = [self findClass:[arr objectAtIndex:i]];
        if([cla isEqualToString:@"String"]){
            [concat appendString: @", "];
            [concat appendString: [arr objectAtIndex:i]];
        } else if ([cla isEqualToString:@"Array"]){
            [concat appendString: @", "];
            [concat appendString:[self arrayToString:[arr objectAtIndex:i]]];
        } else if([cla isEqualToString:@"Dictionary"]){
            [concat appendString: @", "];
            [concat appendString:[self dicToString:[arr objectAtIndex:i]]];
        } else {
            NSLog(@"이상한 값이 들어와 있습니다.");
        }
    }
    
    NSMutableString* bracket = [NSMutableString stringWithString:@"["];
    [bracket appendString:[concat substringFromIndex:2]];
    [bracket appendString:@"]"];
    
    return bracket;
}

-(NSString*)dicToString:(NSDictionary*)dic{
    NSMutableString* concat = [[NSMutableString alloc]init];
    NSArray* keys = [dic allKeys];
    int keysLength = [keys count];
    
    for(int i = 0; i < keysLength; i++){
        [concat appendString: @", "];
        [concat appendString:[keys objectAtIndex:i]]; //key 추가
        NSString* cla = [self findClass:[dic objectForKey:[keys objectAtIndex:i]]];
        if([cla isEqualToString:@"String"]){
            [concat appendString: @": "];
            [concat appendString: [dic objectForKey:[keys objectAtIndex:i]]];
        } else if ([cla isEqualToString:@"Array"]){
            [concat appendString: @": "];
            [concat appendString:[self arrayToString:[dic objectForKey:[keys objectAtIndex:i]]]];
        } else if([cla isEqualToString:@"Dictionary"]){
            [concat appendString: @": "];
            [concat appendString:[self dicToString:[dic objectForKey:[keys objectAtIndex:i]]]];
        } else {
            NSLog(@"이상한 값이 들어와 있습니다.");
        }
    }
    
    NSMutableString* bracket = [NSMutableString stringWithString:@"{"];
    [bracket appendString:[concat substringFromIndex:2]];
    [bracket appendString:@"}"];
    
    return bracket;
}

-(NSString*)findClass: (id)target {
    NSString* result;
    NSString* cla = [target className];
    if([cla rangeOfString:@"Dictionary"].location != NSNotFound){
        result = @"Dictionary";
    } else if([cla rangeOfString:@"Array"].location != NSNotFound){
        result = @"Array";
    } else if([cla rangeOfString:@"String"].location != NSNotFound){
        result = @"String";
    }
    
    return result;
}
@end
