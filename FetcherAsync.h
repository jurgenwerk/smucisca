//
//  FetcherAsync.h
//  Smucisca
//
//  Created by jürgen on 12/23/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetcherAsync : NSObject

@property (strong, nonatomic) NSMutableData *responseData;

- (NSMutableArray * )fetch;


@end
