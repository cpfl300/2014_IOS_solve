//
//  Song.h
//  week11
//
//  Created by 김민주 on 2014. 9. 18..
//  Copyright (c) 2014년 김민주. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject
@property NSNumber* id;
@property NSString* title;
@property NSString* category;
@property NSString* img;

-(id)initWithID:(NSNumber*)id andTitle:(NSString*)title andCategory:(NSString*)category withImg:(NSString*)img;

@end
