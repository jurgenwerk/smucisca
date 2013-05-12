//
//  FetcherAsync.m
//  Smucisca
//
//  Created by jürgen on 12/23/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import "FetcherAsync.h"
#import "Fetcher.h"
#import "AppSettings.h"

@implementation FetcherAsync

@synthesize responseData;

- (NSMutableArray *)fetch
{
    responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[AppSettings URL]]];
    (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSMutableArray *skiSlopeObjects = [[NSMutableArray alloc] init];
    
    return skiSlopeObjects;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}
- (NSMutableArray* )connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
//    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
    return [Fetcher ParseJSON:jsonArray];
}


@end
