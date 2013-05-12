//
//  CamCell.m
//  Smucisca
//
//  Created by jürgen on 12/24/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import "CamCell.h"

@implementation CamCell

@synthesize cellImage;
@synthesize cellName;
@synthesize activity;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
