//
//  Fetcher.m
//  Smucisca
//
//  Created by jürgen on 11/29/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import "Fetcher.h"
#import "SkiSlope.h"
#import "Weather.h"
#import "Forecast.h"
#import "AppSettings.h"

@implementation Fetcher 


+ (NSMutableArray*) ParseJSON: (NSArray* ) skiSlopesData
{
    NSMutableArray *skiSlopeObjects = [[NSMutableArray alloc] init];

    for (int i = 0; i < [skiSlopesData count]; i++)
    {
        NSDictionary *basic = [skiSlopesData objectAtIndex:i];
        
        SkiSlope *skiSlope = [[SkiSlope alloc] init];
        
        if([basic objectForKey:@"Name"] != nil)
        {
            skiSlope.name = [basic objectForKey:@"Name"];
        }
        
        if([basic objectForKey:@"Notification"] != nil)
        {
            skiSlope.notification = [basic objectForKey:@"Notification"];
        }
        
        if([basic objectForKey:@"Height"] != nil)
        {
            skiSlope.height = [(NSString *) [basic objectForKey:@"Height"] intValue];
        }
        
        if([basic objectForKey:@"CurrentSnowLevel"] != nil)
        {
            skiSlope.snowLevel = [(NSString *) [basic objectForKey:@"CurrentSnowLevel"] intValue];
        }
        
        if([basic objectForKey:@"UpdatedAt"] != nil)
        {
            NSString *timeString = [basic objectForKey:@"UpdatedAt"];
           
            skiSlope.updatedAt = timeString;
        }
        
        skiSlope.cams = [basic objectForKey:@"CamsUrlList"];
        
        Weather *currentWeather = [[Weather alloc] init];
        
        NSDictionary *currentWeatherDict = [basic objectForKey:@"CurrentWeather"];
        
        if([currentWeatherDict objectForKey:@"Temperature"] != nil)
        {
            currentWeather.temperature = [(NSString *) [currentWeatherDict objectForKey:@"Temperature"] intValue];
        }
        
        if([currentWeatherDict objectForKey:@"WindSpeed"] != nil)
        {
            currentWeather.windSpeed = [currentWeatherDict objectForKey:@"WindSpeed"];
        }
        
        if([currentWeatherDict objectForKey:@"DescriptionString"] != nil)
        {
            currentWeather.description = [currentWeatherDict objectForKey:@"DescriptionString"];
        }
        
        if([currentWeatherDict objectForKey:@"Description"] != nil)
        {
            currentWeather.descriptionIndex = [currentWeatherDict objectForKey:@"Description"];
        }
        
        if([currentWeatherDict objectForKey:@"Cloudiness"] != nil)
        {
            currentWeather.cloudiness = [currentWeatherDict objectForKey:@"Cloudiness"];
        }
        
        if([currentWeatherDict objectForKey:@"TimeString"] != nil)
        {
//            NSString *timeString = [currentWeatherDict objectForKey:@"TimeString"];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
//            NSDate *datetime = [formatter dateFromString:timeString];
//            currentWeather.datetime = datetime;
        }
        
        skiSlope.currentWeather = currentWeather;
        
        Forecast *forecast = [[Forecast alloc] init];
        
        Weather *todayMorning = [[Weather alloc] init];
        Weather *todayAfternoon = [[Weather alloc] init];
        Weather *tomorrowMorning = [[Weather alloc] init];
        Weather *tomorrowAfternoon = [[Weather alloc] init];
        Weather *dayAfterTomorrowMorning = [[Weather alloc] init];
        Weather *dayAfterTomorrowAfternoon = [[Weather alloc] init];
        
        if([basic objectForKey:@"Forecast"] != nil)
        {
            NSDictionary *forecastDict = [basic objectForKey:@"Forecast"];
            
            todayMorning = [self SetWeather:forecastDict :@"TodayMorning" :todayMorning];
            todayAfternoon = [self SetWeather:forecastDict :@"TodayAfternoon" :todayAfternoon];
            tomorrowMorning = [self SetWeather:forecastDict :@"TomorrowMorning" :tomorrowMorning];
            tomorrowAfternoon = [self SetWeather:forecastDict :@"TomorrowAfternoon" :tomorrowAfternoon];
            dayAfterTomorrowMorning = [self SetWeather:forecastDict :@"DayAfterTomorrowMorning" :dayAfterTomorrowMorning];
            dayAfterTomorrowAfternoon = [self SetWeather:forecastDict :@"DayAfterTomorrowAfternoon" :dayAfterTomorrowAfternoon];
        }
        
        forecast.todayMorning = todayMorning;
        forecast.todayAfternoon = todayAfternoon;
        forecast.tomorrowMorning = tomorrowMorning;
        forecast.tomorrowAfternoon = tomorrowAfternoon;
        forecast.dayAfterTomorrowMorning = dayAfterTomorrowMorning;
        forecast.dayAfterTomorrowAfternoon = dayAfterTomorrowAfternoon;
        
        skiSlope.forecast = forecast;
        
        [skiSlopeObjects addObject:skiSlope];
    }
    
    return skiSlopeObjects;


}

+ (NSMutableArray *)fetch
{
    NSURL *apiURL = [NSURL URLWithString:[AppSettings URL]];
    
    NSData *data = [NSData dataWithContentsOfURL: apiURL];
    NSError* error;
    NSArray* skiSlopesData = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
    
    return [self ParseJSON:skiSlopesData];
    
}

    
    
+ (Weather *) SetWeather: (NSDictionary *) forecastDict : (NSString *) key : (Weather *) w
{
    if([forecastDict objectForKey:key] != nil)
    {
        NSDictionary *weatherDict = [forecastDict objectForKey:key];
        
        if([weatherDict objectForKey:@"Temperature"] != nil)
        {
            w.temperature = [(NSString *) [weatherDict objectForKey:@"Temperature"] intValue];
        }
        
        if([weatherDict objectForKey:@"WindSpeed"] != nil)
        {
            w.windSpeed = [weatherDict objectForKey:@"WindSpeed"];
        }
                
        if([weatherDict objectForKey:@"Description"] != nil)
        {
            w.descriptionIndex = [weatherDict objectForKey:@"Description"];
        }
        
        if([weatherDict objectForKey:@"Time"] != nil)
        {
            NSString *timeString = [weatherDict objectForKey:@"Time"];

            w.datetime = timeString;
        }
    }
    
    return w;
}

@end

