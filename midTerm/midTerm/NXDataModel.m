//
//  NXDataModel.m
//  midTerm
//
//  Created by 김민주 on 2014. 8. 12..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "NXDataModel.h"

@implementation NXDataModel

- (void) initData{
    char * data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\{\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\{\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\{\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\{\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\{\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\{\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\{\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\{\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
    
    NSData* imgData = [NSData dataWithBytes:data length:strlen(data)];
    NSError* err = nil;
    NSMutableDictionary* dic = [NSJSONSerialization JSONObjectWithData:imgData options:NSJSONReadingMutableContainers error:&err];
    _data = (NSMutableArray*)dic;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jsonComplete" object:self userInfo:dic];
}

- (void) orderView{
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
    [_data sortUsingDescriptors:sortDescriptors];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jsonComplete" object:self userInfo:(NSDictionary*)_data];

}
@end
