//
//  Weather.h
//  Smucisca
//
//  Created by jürgen on 11/26/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property int temperature;
@property NSString *windSpeed;
@property NSString *description;
@property NSString *descriptionIndex;
@property NSString *datetime;
@property NSString *cloudiness;

@end
