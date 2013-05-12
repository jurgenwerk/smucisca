//
//  Fetcher.h
//  Smucisca
//
//  Created by jürgen on 11/29/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fetcher : NSObject 

+ (NSMutableArray * )fetch;
+ (NSMutableArray*) ParseJSON: (NSArray* ) data;

@end
