//
//  WDMeTableViewController.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDMeTableViewController.h"
#import "WDUserTableViewCell.h"
#import "GlobalDefines.h"

static NSString *const kProfileCellIdentifier = @"ProfileCell";
static NSString *const kOtherCellIdentifier = @"OtherCell";

@interface WDMeTableViewController ()

@property (nonatomic, strong) NSArray *dataOfSections;

@end

@implementation WDMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadData
{
    if (!_dataOfSections) {
        _dataOfSections = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"me.plist" ofType:nil]];
        
        if ([WDUserDefaults objectForKey:kUserID]) {
            [[[_dataOfSections objectAtIndex:0] objectAtIndex:0] setValue:[WDUserDefaults objectForKey:kUserName] forKey:@"name"];
            [[[_dataOfSections objectAtIndex:0] objectAtIndex:0] setValue:@"WDProfileViewController" forKey:@"class"];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataOfSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataOfSections objectAtIndex: section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSDictionary *cellDict = [self getTableCellDictionaryWithIndexPath:indexPath];
    if (indexPath.section == 0)
    {
        NSLog(@"string");
        cell = [tableView dequeueReusableCellWithIdentifier:kProfileCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = cellDict[@"name"];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:kOtherCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = cellDict[@"name"];
    }
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSDictionary *)getTableCellDictionaryWithIndexPath: (NSIndexPath *)indexpath
{
    return [[_dataOfSections objectAtIndex:indexpath.section] objectAtIndex:indexpath.row];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = RGB(239, 239, 244);
    self.view.backgroundColor = RGB(239, 239, 244);
    [self.tableView registerClass:[WDUserTableViewCell class] forCellReuseIdentifier:kProfileCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kOtherCellIdentifier];
}

@end
