//
//  SkiDetailsViewController.m
//  Smucisca
//
//  Created by jürgen on 12/1/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import "SkiDetailsViewController.h"
#import "AppSettings.h"
#import "WeatherImageEnum.h"

@interface SkiDetailsViewController ()

@end

@implementation SkiDetailsViewController

@synthesize skiNameLabel;
@synthesize tempLabel;
@synthesize windLabel;
@synthesize snowLabel;
@synthesize heightLabel;
@synthesize cloudLabel;
@synthesize skiName;
@synthesize temperature;
@synthesize wind;
@synthesize cloudy;
@synthesize skiSlope;
@synthesize currentWeatherImg;
@synthesize updatedLabel;
@synthesize todayLabel;
@synthesize tomorrowLabel;
@synthesize todayWeatherMorningImg;
@synthesize todayWeatherAfternoonImg;
@synthesize tomorrowWeatherMorningImg;
@synthesize tomorrowWeatherAfternoonImg;
@synthesize todayMorningTemp;
@synthesize todayMorningWind;
@synthesize todayAfternoonTemp;
@synthesize todayAfternoonWind;
@synthesize tomorrowMorningTemp;
@synthesize tomorrowMorningWind;
@synthesize tomorrowAfternoonTemp;
@synthesize tomorrowAfternoonWind;
@synthesize normalRefreshButton;

@synthesize responseData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView* scrollview = (UIScrollView*) self.view.subviews[0];
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    UIImageView *imageView = nil;
    
    if (result.height == 568) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1_568.png"]];
    }
    else{
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1.png"]];
    }
    
    [self.view insertSubview:imageView belowSubview:scrollview];

//    [scrollview setBounces:NO];
//    [scrollview setScrollEnabled:NO];
    
	// Do any additional setup after loading the view.
    skiNameLabel.text = skiName;
    tempLabel.text =[NSString stringWithFormat:@"%d", skiSlope.currentWeather.temperature];
    windLabel.text = [NSString stringWithFormat:@"%@", skiSlope.currentWeather.windSpeed];
    cloudLabel.text = [NSString stringWithFormat:@"%@", skiSlope.currentWeather.cloudiness];
    snowLabel.text = [NSString stringWithFormat:@"%d", skiSlope.snowLevel];
    
    heightLabel.text = [NSString stringWithFormat:@"%d m", skiSlope.height];
 
    _weatherDesc.text = [NSString stringWithFormat:@"%@",skiSlope.currentWeather.description];
    
    _weatherDesc.text = [NSString stringWithFormat:@"%@",skiSlope.currentWeather.description];
    
    
    [currentWeatherImg setImage:[WeatherImageEnum GetImageFromDescription: skiSlope.currentWeather.descriptionIndex]];
    
    [todayWeatherMorningImg setImage:[WeatherImageEnum GetImageFromDescription: skiSlope.forecast.todayMorning.descriptionIndex]];

    [todayWeatherAfternoonImg setImage:[WeatherImageEnum GetImageFromDescription: skiSlope.forecast.todayAfternoon.descriptionIndex]];

    [tomorrowWeatherMorningImg setImage:[WeatherImageEnum GetImageFromDescription: skiSlope.forecast.tomorrowMorning.descriptionIndex]];

    [tomorrowWeatherAfternoonImg setImage:[WeatherImageEnum GetImageFromDescription: skiSlope.forecast.tomorrowAfternoon.descriptionIndex]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm, dd.MM.yyyy"];
    
    updatedLabel.text = [NSString stringWithFormat:@"%@", skiSlope.updatedAt];
    
    NSDateFormatter *formatter_ddMM = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatter_dayName = [[NSDateFormatter alloc] init];
    [formatter_ddMM setDateFormat:@"dd.MM"];
    [formatter_dayName setDateFormat:@"EEEE"];
    
    todayLabel.text = [NSString stringWithFormat:@"%@",skiSlope.forecast.todayAfternoon.datetime];
    tomorrowLabel.text = [NSString stringWithFormat:@"%@",skiSlope.forecast.tomorrowAfternoon.datetime];
    todayMorningTemp.text = [NSString stringWithFormat:@"%d °C", skiSlope.forecast.todayMorning.temperature];
    todayMorningWind.text = [NSString stringWithFormat:@"%@", skiSlope.forecast.todayMorning.windSpeed];
    todayAfternoonTemp.text = [NSString stringWithFormat:@"%d °C", skiSlope.forecast.todayAfternoon.temperature];
    todayAfternoonWind.text = [NSString stringWithFormat:@"%@", skiSlope.forecast.todayAfternoon.windSpeed];
    tomorrowMorningTemp.text = [NSString stringWithFormat:@"%d °C", skiSlope.forecast.tomorrowMorning.temperature];
    tomorrowMorningWind.text = [NSString stringWithFormat:@"%@", skiSlope.forecast.tomorrowMorning.windSpeed];
    tomorrowAfternoonTemp.text = [NSString stringWithFormat:@"%d °C", skiSlope.forecast.tomorrowAfternoon.temperature];
    tomorrowAfternoonWind.text = [NSString stringWithFormat:@"%@", skiSlope.forecast.tomorrowAfternoon.windSpeed];
    
    if (skiSlope.cams == nil || [skiSlope.cams isKindOfClass:[NSNull class]] || [skiSlope.cams count] == 0)
    {
        [self.view viewWithTag: 1001].hidden = YES;
    }
    
    self.navigationItem.title = skiName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)TranslateDay:(NSString*) day
{
    if ([day isEqualToString:@"Monday"])
        return @"Ponedeljek";
    else if ([day isEqualToString:@"Tuesday"])
        return @"Torek";
    else if ([day isEqualToString:@"Wednesday"])
        return @"Sreda";
    else if ([day isEqualToString:@"Thursday"])
        return @"Četrtek";
    else if ([day isEqualToString:@"Friday"])
        return @"Petek";
    else if ([day isEqualToString:@"Saturday"])
        return @"Sobota";
    else if ([day isEqualToString:@"Sunday"])
        return @"Nedelja";
    
    return day;
    
}

- (IBAction)RefreshAction:(id)sender {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [activityView sizeToFit];
    [activityView startAnimating];
    [activityView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
        
    [activityView setFrame:CGRectMake(50,50,32,50)];
        
    UIBarButtonItem *loadingRefreshButton = [[UIBarButtonItem alloc] initWithCustomView:activityView];
        
    UIBarButtonItem *_normalRefreshButton = self.navigationItem.rightBarButtonItem;
        
    self.navigationItem.rightBarButtonItem = loadingRefreshButton;
        
    [self performSelector:@selector(FetchDataFromWeb:) withObject:_normalRefreshButton afterDelay:0.01];
    
}

-(void)FetchDataFromWeb:(UIBarButtonItem*)_normalRefreshButton
{
    self.normalRefreshButton = _normalRefreshButton;
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[AppSettings URL]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120];
    (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.navigationItem.rightBarButtonItem = self.normalRefreshButton;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Težave s povezavo!" message:@"Preveri povezavo in poskusi znova!" delegate:nil cancelButtonTitle:@"Zapri"otherButtonTitles: nil];
    [alert show];
    
    NSLog(@"%@", error);
}
- (NSMutableArray* )connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error;
    
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&error];
    
    NSMutableArray *skiSlopes= [Fetcher ParseJSON:jsonArray];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.navigationItem.rightBarButtonItem = self.normalRefreshButton;

    for (SkiSlope* s in skiSlopes) {
        if ([self.skiSlope.name isEqualToString:s.name])
        {
            self.skiSlope = s;
            break;
        }
    }
    
    [self viewDidLoad];
    
    return nil;
}

#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num;
    if( gallery == localGallery ) {
        num = [localImages count];
    }
    else if( gallery == networkGallery ) {
        num = [networkImages count];
    }
	return num;
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
	if( gallery == localGallery ) {
		return FGalleryPhotoSourceTypeLocal;
	}
	else return FGalleryPhotoSourceTypeNetwork;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    if( gallery == localGallery ) {
        caption = [localCaptions objectAtIndex:index];
    }
    else if( gallery == networkGallery ) {
        caption = [networkCaptions objectAtIndex:index];
    }
	return caption;
}

- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [localImages objectAtIndex:index];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [networkImages objectAtIndex:index];
}


- (IBAction)ShowCams:(UIButton *)sender {
    networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    networkImages = skiSlope.cams;
    [self.navigationController pushViewController:networkGallery animated:YES];
}
@end
