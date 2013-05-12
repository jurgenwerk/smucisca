//
//  Forecast.h
//  Smucisca
//
//  Created by jürgen on 11/29/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface Forecast : NSObject

@property Weather *todayMorning;
@property Weather *todayAfternoon;
@property Weather *tomorrowMorning;
@property Weather *tomorrowAfternoon;
@property Weather *dayAfterTomorrowMorning;
@property Weather *dayAfterTomorrowAfternoon;

@end
