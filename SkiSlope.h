//
//  SkiSlope
//  Smucisca
//
//  Created by jürgen on 11/26/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import "Forecast.h"

@interface SkiSlope : NSObject

@property NSString *name;
@property int snowLevel;
@property Weather *currentWeather;
@property Forecast *forecast;
@property int height;
@property NSString *updatedAt;
@property NSArray *cams;
@property NSString *notification;
@end
