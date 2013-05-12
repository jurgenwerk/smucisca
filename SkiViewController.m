//
//  SmuciscaViewController.m
//  Smucisca
//
//  Created by jürgen on 11/26/12.
//  Copyright (c) 2012 jürgen. All rights reserved.
//

#import "SkiViewController.h"
#import "SkiSlope.h"
#import "Fetcher.h"
#import "FetcherAsync.h"
#import "SkiCell.h"
#import "SkiDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppSettings.h"
#import "WeatherImageEnum.h"

@interface SkiViewController ()

@end

@implementation SkiViewController

@synthesize skiSlopes;
@synthesize responseData;
@synthesize normalRefreshButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self.view.layer setCornerRadius:5.0];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    imageView.tag = 999;
    [self.view addSubview:imageView];
    self.tableView.backgroundView = imageView;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.skiSlopes count];
}

- (CGFloat)tableView:(UITableView *)tabelView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //the last cell is larger because of reasons
    if (indexPath.row == self.skiSlopes.count - 1){
        return 67+12;
    }
    
    return 67;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // this is the image view shown when table is loading, then we remove it
//    NSArray *a = self.view.subviews;
//    for (UIView* view in a) {
//        if (view.tag == 999)
//        {
//            [view ]
//            [view removeFromSuperview];
//        }
//    }
    
    SkiCell *cell = (SkiCell *)[self.tableView
                                      dequeueReusableCellWithIdentifier:@"SkiSlopeCell"];
    
    if (indexPath.row == 0)
        [cell.cellBgImg setImage:[UIImage imageNamed:@"cell1.png"]];
    else if (indexPath.row == 1)
        [cell.cellBgImg setImage:[UIImage imageNamed:@"cell2.png"]];
    else 
        [cell.cellBgImg setImage:[UIImage imageNamed:@"cell3.png"]];
    
	SkiSlope *skiSlope = [self.skiSlopes objectAtIndex:indexPath.row];
	cell.skiName.text = skiSlope.name;
	cell.snowLevel.text = [NSString stringWithFormat:@"%d", skiSlope.snowLevel];
    cell.temperature.text = [NSString stringWithFormat:@"%d°C", skiSlope.currentWeather.temperature];
    cell.wind.text = [NSString stringWithFormat: @"%@", skiSlope.currentWeather.windSpeed];
    
    [cell.weatherImg setImage:[WeatherImageEnum GetImageFromDescription:skiSlope.currentWeather.descriptionIndex]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:skiSlope.name])
    {
        [cell.favButton setImage: [UIImage imageNamed:@"fav1.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.favButton setImage:[UIImage imageNamed:@"fav2.png"] forState:UIControlStateNormal];
    }
    
    cell.favButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    cell.favButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //the last cell is custom designed 
    if ([skiSlopes indexOfObject:skiSlope] == skiSlopes.count - 1){
        [cell.cellBgImg setImage:[UIImage imageNamed:@"cell4.png"]];

    }
        

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//    NSString *stringToMove = [self.skiSlopes objectAtIndex:fromIndexPath.row];
//    [self.skiSlopes removeObjectAtIndex:fromIndexPath.row];
//    [self.skiSlopes insertObject:stringToMove atIndex:toIndexPath.row];
//
//}



//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)RefreshAction:(UIBarButtonItem *)sender {
    
    if (self.skiSlopes.count == 0)
        [self createCustomActivityView];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [activityView sizeToFit];
    [activityView startAnimating];
    [activityView setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
    
    [activityView setFrame:CGRectMake(50,50,32,50)];
    
    UIBarButtonItem *loadingRefreshButton = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    
    UIBarButtonItem *_normalRefreshButton = self.navigationItem.rightBarButtonItem;
    
    self.navigationItem.rightBarButtonItem = loadingRefreshButton;
    
    [self performSelector:@selector(FetchDataFromWeb:) withObject:_normalRefreshButton afterDelay:0.01];
}

-(void)FetchDataFromWeb:(UIBarButtonItem*)_normalRefreshButton
{
    //sync
    //skiSlopes = [Fetcher fetch];
    
    //async
    self.normalRefreshButton = _normalRefreshButton;
    responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[AppSettings URL]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120];
    (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSkiDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SkiDetailsViewController *destViewController = segue.destinationViewController;
        destViewController.skiName = ((SkiSlope*)[skiSlopes objectAtIndex:indexPath.row]).name;
        destViewController.skiSlope = (SkiSlope*)[skiSlopes objectAtIndex:indexPath.row];
    }
}
- (IBAction)FavButtonClick:(id)sender {
    
    UIButton* button = (UIButton *) sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)
                              [[sender superview] superview]];
    
    int index = indexPath.row;
    SkiSlope *skiSlope  = skiSlopes[index];
    NSString *name = skiSlope.name;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (![userDefaults boolForKey:skiSlope.name])
    {
        [userDefaults setBool:YES forKey:name];
        [button setImage: [UIImage imageNamed:@"fav1.png"] forState:UIControlStateNormal];
    }
    else
    {
        [userDefaults setBool:NO forKey:name];
        [button setImage: [UIImage imageNamed:@"fav2.png"] forState:UIControlStateNormal];
    }
    
    [userDefaults synchronize];
    
    self.skiSlopes = [self RearrangeObjects:skiSlopes];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [self RefreshTable];
}

- (void) RefreshTable
{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSMutableArray *) RearrangeObjects : (NSMutableArray *) skiSlopes
{
    NSMutableArray *favorited = [NSMutableArray new];
    NSMutableArray *notFavorited = [NSMutableArray new];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    for(SkiSlope *skiSlope in self.skiSlopes)
    {
        
        if ([userDefaults boolForKey:skiSlope.name])
            [favorited addObject:skiSlope];
        else
            [notFavorited addObject:skiSlope];
    }
    
    [favorited addObjectsFromArray:notFavorited];
    return favorited;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.navigationItem.rightBarButtonItem = self.normalRefreshButton;
    
    NSArray *a = self.view.subviews;
    for (UIView* view in a) {
        if (view.tag == 1000) // custom activity
        {
            [(UIImageView*)view removeFromSuperview];
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Težave s povezavo!" message:@"Preveri povezavo in poskusi znova!" delegate:nil cancelButtonTitle:@"Zapri"otherButtonTitles: nil];
    [alert show];
    
    NSLog(@"%@", error);
}
- (NSMutableArray* )connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSArray *a = self.view.subviews;
        for (UIView* view in a) {
            if (view.tag == 1000) // custom activity
            {
                [(UIImageView*)view removeFromSuperview];
            }
        }
    
    NSError* error;

    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
    
    self.skiSlopes = [Fetcher ParseJSON:jsonArray];
    
    NSString* notification = ((SkiSlope*)self.skiSlopes[0]).notification;
    if (notification != nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Obvestilo" message:[NSString stringWithFormat:@"%@", notification] delegate:nil cancelButtonTitle:@"Zapri"otherButtonTitles: nil];
        [alert show];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.navigationItem.rightBarButtonItem = self.normalRefreshButton;
    self.skiSlopes = [self RearrangeObjects:skiSlopes];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation: UITableViewRowAnimationFade];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg1@2x.png"]];
    self.tableView.backgroundView = imageView;
    
    return nil;
}

- (void ) createCustomActivityView
{
    //Create the first status image and the indicator view
    UIImage *statusImage = [UIImage imageNamed:@"circle_1.png"];
    UIImageView *activityImageView = [[UIImageView alloc]
                                      initWithImage:statusImage];
    
    activityImageView.tag = 1000;
    //Add more images which will be used for the animation
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"circle_1.png"],
                                         [UIImage imageNamed:@"circle_2.png"],
                                         [UIImage imageNamed:@"circle_3.png"],
                                         [UIImage imageNamed:@"circle_4.png"],
                                         [UIImage imageNamed:@"circle_5.png"],
                                         [UIImage imageNamed:@"circle_6.png"],
                                         [UIImage imageNamed:@"circle_7.png"],
                                         [UIImage imageNamed:@"circle_8.png"],
                                         nil];
    
    
    activityImageView.animationDuration = 2.5;
    
    
    activityImageView.frame = CGRectMake(
                                         self.view.frame.size.width/2
                                         -statusImage.size.width/2,
                                         self.view.frame.size.height/2
                                         -statusImage.size.height/2,
                                         statusImage.size.width,
                                         statusImage.size.height);
    
    [activityImageView startAnimating];
    activityImageView.layer.opacity = 0.95;
    
    [self.view addSubview:activityImageView];
}

@synthesize tableView;


@end
