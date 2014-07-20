//
//  convertor.m
//  week2
//
//  Created by 김민주 on 2014. 7. 19..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "convertor.h"

@implementation convertor

-(id)convertingStringToDicOrArr:(NSString*)jsonData{
    
    if([[jsonData substringToIndex:1] isEqualToString:@"["]){
        NSLog(@"ARR!!!");
        return [self convertToArray:jsonData];
    }else if([[jsonData substringToIndex:1] isEqualToString:@"{"]){
        NSLog(@"DIC!!!");
        return [self convertToDic:jsonData];
    }
    return NULL;
}

-(NSMutableArray*)convertToArray:(NSString*)jsonData{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    NSMutableString* trimed = [self trimForArr:jsonData];
    Boolean hasEle = true;
    
    NSString* target;
    NSMutableString* substr;
    
    while (hasEle) {
        
        if([self countCharacter:trimed WidthCharacter:@"{"] == 1
           &&
           [[trimed substringToIndex:1] isEqualToString:@"{"] &&
           [self countCharacter:trimed WidthCharacter:@":"]
           > [self countCharacter:trimed WidthCharacter:@","]) {
            hasEle = false;
            target = trimed;
        }else if([trimed rangeOfString:@"{"].location == NSNotFound && [trimed rangeOfString:@","].location == NSNotFound){
            hasEle = false;
            target = trimed;
        }else{
            target = [trimed substringToIndex:[trimed rangeOfString:@","].location];
        }
        
        if([target rangeOfString:@"{"].location == NSNotFound){
            if(hasEle){
                target = [trimed substringToIndex:[trimed rangeOfString:@","].location];
                substr = [self removeFirstWhiteSpace:[trimed substringFromIndex:[trimed rangeOfString:@","].location+1]];
            }else{
                target = trimed;
                substr = NULL;
            }
            
            [result addObject:target];
            trimed = substr;
            
        }else{
            if(hasEle){
                target = [trimed substringToIndex:[trimed rangeOfString:@"}"].location+1];
                substr = [self removeFirstWhiteSpace:[trimed substringFromIndex:[trimed rangeOfString:@"}"].location+2]];
            }else{
                target = trimed;
                substr = NULL;
            }
            [result addObject:[self convertToDic:target]];
            trimed =  substr;
        }
    }
    
    return result;
}

-(NSMutableDictionary*)convertToDic:(NSString*)jsonData{
    
    NSMutableDictionary* result = [[NSMutableDictionary alloc]init];
    NSMutableString* trimed = [self trimForDic:jsonData];
    
    NSMutableDictionary* temp = [[NSMutableDictionary alloc]init];
    NSString* target;
    Boolean hasEle = true;
    
    while(hasEle){
        [temp setObject:[trimed substringToIndex:[trimed rangeOfString:@":"].location] forKey:@"key"];
        trimed = [self removeFirstWhiteSpace:[trimed substringFromIndex:[trimed rangeOfString:@":"].location+1]];
        
        
        if([[trimed substringToIndex:1] isEqualToString:@"["]){
            NSString* check = [trimed componentsSeparatedByString:@"]"][1];
            if([check rangeOfString:@","].location == NSNotFound){
                hasEle = false;
                target = trimed;
            }
            
        }else if([trimed rangeOfString:@"["].location == NSNotFound && [trimed rangeOfString:@","].location == NSNotFound){
            hasEle = false;
            target = trimed;
        } else{
            target = [trimed substringToIndex:[trimed rangeOfString:@","].location];
        }
        
        if([target rangeOfString:@"["].location == NSNotFound){
            [result setObject:target forKey:[temp objectForKey:@"key"]];
            if(hasEle){
                trimed = [self removeFirstWhiteSpace:[trimed substringFromIndex:[trimed rangeOfString:@","].location+1]];
            }else{
                trimed = NULL;
            }
            
        }else{
            target = [trimed substringToIndex:[trimed rangeOfString:@"]"].location+1];
            [result setObject:[self convertToArray:target] forKey:[temp objectForKey:@"key"]];
            if(hasEle){
                trimed = [self removeFirstWhiteSpace:[trimed substringFromIndex:[trimed rangeOfString:@"]"].location+2]];
            }else{
                trimed = NULL;
            }
        }
        
    }
    
    return result;
}

-(NSMutableString*)trimForArr:(NSString*)jsonData{
    NSString* trim = [[NSString alloc]init];
    
    if ([jsonData rangeOfString:@"["].location != NSNotFound){
        trim = [jsonData stringByReplacingCharactersInRange:[jsonData rangeOfString:@"["] withString:@""];
    }
    
    if ([trim rangeOfString:@"]"].location != NSNotFound){
        trim = [trim stringByReplacingCharactersInRange:[trim rangeOfString:@"]"] withString:@""];
    }
    
    if ([trim rangeOfString:@"\""].location != NSNotFound){
        trim = [trim stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    }
    
    return [NSMutableString stringWithString:trim];
}

-(NSMutableString*)trimForDic:(NSString*)jsonData{
    NSString* trim = [[NSString alloc]init];
    
    if ([jsonData rangeOfString:@"{"].location != NSNotFound){
        trim = [jsonData stringByReplacingCharactersInRange:[jsonData rangeOfString:@"{"] withString:@""];
    }
    
    if ([trim rangeOfString:@"}"].location != NSNotFound){
        trim = [trim stringByReplacingCharactersInRange:[trim rangeOfString:@"}"] withString:@""];
    }
    
    if ([trim rangeOfString:@"\""].location != NSNotFound){
        trim = [trim stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    }
    
    return [NSMutableString stringWithString:trim];
}

-(NSMutableString*)removeFirstWhiteSpace:(NSString*)src{
    NSString* removedWS = [src stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [NSMutableString stringWithString: removedWS];
}

-(NSUInteger)countCharacter:(NSString*)string WidthCharacter: (NSString*)findChar {
    
    NSUInteger numberOfMatches = [[string componentsSeparatedByString:findChar] count] - 1;
    return numberOfMatches;
}




@end
