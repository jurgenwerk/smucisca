//
//  WeatherImageEnum.m
//  Smucisca
//
//  Created by jürgen on 12/16/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import "WeatherImageEnum.h"

@implementation WeatherImageEnum

+ (UIImage *)GetImageFromDescription : (NSString * ) description
{
    if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"0"]) 
        return [UIImage imageNamed:@"clear.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"1"]) 
        return [UIImage imageNamed:@"fog.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"2"]) 
        return [UIImage imageNamed:@"fog.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"3"])
        return [UIImage imageNamed:@"partlycloudy.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"4"])
        return [UIImage imageNamed:@"partlycloudy.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"5"])
        return [UIImage imageNamed:@"partysunnyrain.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"6"])
        return [UIImage imageNamed:@"flurries.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"7"])
        return [UIImage imageNamed:@"flurries.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"8"])
        return [UIImage imageNamed:@"scatteredclouds.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"9"])
        return [UIImage imageNamed:@"cloundysnow.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"10"])
        return [UIImage imageNamed:@"cloundysnow.png"];
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"11"])
        return [UIImage imageNamed:@"cloundysnow.png"];
    
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"12"])
        return [UIImage imageNamed:@"cloundysnow.png"];
    
    else if ([[NSString stringWithFormat:@"%@", description] isEqualToString:@"13"])
        return [UIImage imageNamed:@"partlysunny.png"];
    
    else return nil;
}

@end
