//
//  CamCell.h
//  Smucisca
//
//  Created by jürgen on 12/24/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CamCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cellImage;
@property (strong, nonatomic) IBOutlet UILabel *cellName;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;


@end
