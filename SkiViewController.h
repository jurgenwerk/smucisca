//
//  SmuciscaViewController.h
//  Smucisca
//
//  Created by jürgen on 11/26/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SkiViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *skiSlopes;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) UIBarButtonItem* normalRefreshButton;

@property (nonatomic, strong) IBOutlet UITableView *tableView;


- (IBAction)FavButtonClick:(UIButton *)sender;

- (IBAction)RefreshAction:(id)sender;


@end
