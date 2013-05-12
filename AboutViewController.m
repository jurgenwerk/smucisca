//
//  AboutViewController.m
//  Smucisca
//
//  Created by jürgen on 12/26/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CloseAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SendAction:(id)sender {
    
    NSString *to = @"matic@jurglic.si";
    NSString *subject = @"Aplikacija Slo Smučišča";

    NSString *body = @"";

    
    NSString *mailString = [NSString stringWithFormat:@"mailto=%@&subject=%@&body=%@",
                            [to stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                            [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                            [body stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
}
@end
