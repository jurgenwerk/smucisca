//
//  SkiDetailsViewController.h
//  Smucisca
//
//  Created by jürgen on 12/1/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkiSlope.h"
#import "Fetcher.h"
#import "FGalleryViewController.h"

@interface SkiDetailsViewController : UIViewController
<FGalleryViewControllerDelegate>{
    NSArray *localCaptions;
    NSArray *localImages;
    NSArray *networkCaptions;
    NSArray *networkImages;
	FGalleryViewController *localGallery;
    FGalleryViewController *networkGallery;
}


@property (strong, nonatomic) IBOutlet UILabel *tempLabel;

@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *cloudLabel;
@property (strong, nonatomic) IBOutlet UILabel *snowLabel;
@property (strong, nonatomic) IBOutlet UILabel *skiNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UIImageView *currentWeatherImg;
@property (strong, nonatomic) IBOutlet UILabel *updatedLabel;

@property (strong, nonatomic) IBOutlet UILabel *todayLabel;
@property (strong, nonatomic) IBOutlet UILabel *tomorrowLabel;
@property (strong, nonatomic) IBOutlet UIImageView *todayWeatherMorningImg;
@property (strong, nonatomic) IBOutlet UIImageView *todayWeatherAfternoonImg;

@property (strong, nonatomic) IBOutlet UIImageView *tomorrowWeatherMorningImg;
@property (strong, nonatomic) IBOutlet UIImageView *tomorrowWeatherAfternoonImg;
@property (strong, nonatomic) IBOutlet UILabel *todayMorningTemp;
@property (strong, nonatomic) IBOutlet UILabel *todayMorningWind;
@property (strong, nonatomic) IBOutlet UILabel *todayAfternoonTemp;
@property (strong, nonatomic) IBOutlet UILabel *todayAfternoonWind;
@property (strong, nonatomic) IBOutlet UILabel *tomorrowMorningTemp;
@property (strong, nonatomic) IBOutlet UILabel *tomorrowMorningWind;
@property (strong, nonatomic) IBOutlet UILabel *tomorrowAfternoonTemp;
@property (strong, nonatomic) IBOutlet UILabel *tomorrowAfternoonWind;
@property (strong, nonatomic) IBOutlet UILabel *cloudinessLabel;

@property (strong, nonatomic) IBOutlet UILabel *weatherDesc;
@property (nonatomic, strong) NSString *skiName;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *wind;
@property (nonatomic, strong) NSString *cloudy;
@property (strong, nonatomic) UIBarButtonItem* normalRefreshButton;
@property (strong, nonatomic) NSMutableData *responseData;

@property (nonatomic, strong) SkiSlope *skiSlope;

- (IBAction)RefreshAction:(id)sender;

@end
