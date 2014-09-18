//
//  Song.m
//  week11
//
//  Created by 김민주 on 2014. 9. 18..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import "Song.h"

@implementation Song

-(id)initWithID:(NSNumber *)id andTitle:(NSString *)title andCategory:(NSString *)category withImg:(NSString *)img{
    
    self = [super init];
    if(self) {
        _id = id;
        _title = title;
        _category = category;
        _img = img;
    }
    return self;
}
@end
