//
//  WDMeTableViewController.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDMeTableViewController.h"
#import "WDUserTableViewCell.h"
#import "WDNormalTableViewCell.h"
#import "WDUserModel.h"
#import "WDProfileViewController.h"
#import "WDLoginViewController.h"
#import "GlobalDefines.h"

static NSString *const kProfileCellIdentifier = @"ProfileCell";
static NSString *const kOtherCellIdentifier = @"OtherCell";

@interface WDMeTableViewController ()

@property (nonatomic, strong) NSArray *dataOfSections;
@property (nonatomic, strong) WDUserModel *userModel;

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
    if (!_dataOfSections)
    {
        _dataOfSections = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"me.plist" ofType:nil]];
        
        if ([WDUserDefaults objectForKey:kUserID])
        {
            if ([WDUserDefaults objectForKey:@"userModel"])
            {
                _userModel = [WDUserModel yy_modelWithDictionary:[WDUserDefaults objectForKey:@"userModel"]];
            }
            else
            {
                [WDNetOperation getRequestWithURL:[NSString stringWithFormat:@"/users/%@", [WDUserDefaults objectForKey:kUserID]]
                                       parameters:nil
                                          success:^(id responseObject){
                                              NSDictionary *dict = (NSDictionary*)responseObject;
                                              if ([dict[@"code"] intValue] == 200)
                                              {
                                                  _userModel = [WDUserModel yy_modelWithDictionary:dict[@"content"]];
                                                  [WDUserDefaults setObject: dict[@"content"] forKey:@"userModel"];
                                                  [WDUserDefaults synchronize];
                                              }
                                              else
                                              {
                                                  _userModel = [WDUserModel new];
                                                  _userModel.name = @"点击登录";
                                              }
                                              [self.tableView reloadData];
                                          } failure:^(NSError *error) {
                                          }];
            }
        }
        else
        {
            _userModel = [WDUserModel new];
            _userModel.name = @"点击登录";
            _userModel.head_image = @"test";
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
        WDUserTableViewCell* userCell = [tableView dequeueReusableCellWithIdentifier:kProfileCellIdentifier forIndexPath:indexPath];
        userCell.model = _userModel;
        cell = userCell;
    }
    else
    {
        WDNormalTableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:kOtherCellIdentifier forIndexPath:indexPath];
        normalCell.nameLabel.text = cellDict[@"name"];
        normalCell.iconImageView.image = [UIImage imageNamed:cellDict[@"icon"]];
        cell = normalCell;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc;
    if (indexPath.section == 0) {
        if (![WDUserDefaults objectForKey:kUserID])
        {
            vc = [WDLoginViewController new];
        }
        else
        {
            WDProfileViewController *pv = [WDProfileViewController new];
            pv.userModel = _userModel;
            vc = pv;
        }
    }
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = RGB(245, 245, 245);
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,10, 0, 20)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsMake(0,10, 0, 20)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.section == 0)
    {
        height = [WDUserTableViewCell fixedHeight];
    }
    else
    {
        height = [WDNormalTableViewCell fixedHeight];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

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
    self.tableView.backgroundColor = WDGlobalBackgroundColor;
    self.view.backgroundColor = WDGlobalBackgroundColor;
    [self.tableView registerClass:[WDUserTableViewCell class] forCellReuseIdentifier:kProfileCellIdentifier];
    [self.tableView registerClass:[WDNormalTableViewCell class] forCellReuseIdentifier:kOtherCellIdentifier];
}

@end
