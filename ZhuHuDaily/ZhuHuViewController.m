//
//  ZhuHuViewController.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/22.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "ZhuHuViewController.h"
#import "StoryCell.h"
#import "StoryModel.h"
#import "TopStoryView.h"
#import "DateSectioinView.h"

@interface ZhuHuViewController ()

@end

@implementation ZhuHuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setRefresh];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI 
- (void)setUpUI {
    [self setNav];
    self.tableView.tableHeaderView = [[TopStoryView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 250) TopStoryArray:self.topStoriesArray];
}
- (void)setNav {
    self.navigationController.navigationBar.barTintColor = ZhuHuColor;
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

#pragma mark - Refresh 
- (void)setRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadLastStory];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadBeforeStory];
    }];
}


#pragma mark - LoadStory
- (void)loadLastStory {
    [[NetworkTool sharedNetworkTool] loadDataInfo:LatestStoryUrl parameters:nil success:^(id  _Nullable responseObject) {
        for (NSDictionary *story in responseObject[@"stories"]) {
            StoryModel *storyModel = [StoryModel mj_objectWithKeyValues:story];
            [self.storiesArray addObject:storyModel];
            
        }
        self.topStoriesArray = [NSMutableArray arrayWithArray:responseObject[@"top_stories"]];
        self.tableView.tableHeaderView = [[TopStoryView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 250) TopStoryArray:self.topStoriesArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nullable error) {

    }];
}

- (void)loadBeforeStory {
    [[NetworkTool sharedNetworkTool] loadDataInfo:[[NSString stringWithFormat:BeforeStoryUrl] stringByAppendingString:self.nowDate] parameters:nil success:^(id  _Nullable responseObject) {
        for (NSDictionary *story in responseObject[@"stories"]) {
            StoryModel *storyModel = [StoryModel mj_objectWithKeyValues:story];
            [self.storiesArray addObject:storyModel];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - LazyLoad
- (NSMutableArray *)storiesArray {
    if (!_storiesArray) {
        self.storiesArray = [[NSMutableArray alloc] init];
    }
    return _storiesArray;
}
- (NSMutableArray *)topStoriesArray {
    if (!_topStoriesArray) {
        self.topStoriesArray = [[NSMutableArray alloc] init];
    }
    return _topStoriesArray;
}
- (NSString *)nowDate {
    if (!_nowDate) {
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYYMMdd"];
        
        self.nowDate = [dateformatter stringFromDate:senddate];
    }
    return _nowDate;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.storiesArray.count == 0) {
        return 10;
    }
    else{
        return self.storiesArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [StoryCell cellWithTableView:tableView];
    if (self.storiesArray.count == 0) {
        cell.titleLabel.text = @"纸糊日报";
    }
    else {
        [cell setCellMsg:self.storiesArray[indexPath.row]];
    }
    NSLog(@"第%ld节", indexPath.section);
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DateSectioinView *dateSectionView = [[DateSectioinView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 30) Date:@"2017年02月23日"];
    return dateSectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
/*
 Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     Return NO if you do not want the specified item to be editable.
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

@end
