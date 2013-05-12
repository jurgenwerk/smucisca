//
//  SkiCell.h
//  Smucisca
//
//  Created by jürgen on 12/1/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkiCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *snowLevel;
@property (strong, nonatomic) IBOutlet UILabel *temperature;
@property (strong, nonatomic) IBOutlet UILabel *wind;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImg;
@property (strong, nonatomic) IBOutlet UIImageView *cellBgImg;
@property (strong, nonatomic) IBOutlet UILabel *skiName;
@property (strong, nonatomic) IBOutlet UIButton *favButton;


@end
