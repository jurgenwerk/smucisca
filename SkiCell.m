//
//  SkiCell.m
//  Smucisca
//
//  Created by jürgen on 12/1/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import "SkiCell.h"

@implementation SkiCell

@synthesize skiName;
@synthesize snowLevel;
@synthesize temperature;
@synthesize wind;
@synthesize favButton;
@synthesize cellBgImg;
@synthesize weatherImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favButton:(UIButton *)sender {
}
@end
