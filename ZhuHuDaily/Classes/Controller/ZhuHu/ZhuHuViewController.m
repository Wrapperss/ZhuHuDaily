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
#import "StoryViewController.h"

@interface ZhuHuViewController ()

@end

@implementation ZhuHuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setRefresh];
}


- (void)reSetNav {
    NSLog(@"重新设置");
    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI 
- (void)setUpUI {
    [self setNav];
    [self setTableviewHeadView];
}
- (void)setNav {
    self.navigationController.navigationBar.barTintColor = ZhuHuColor;
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

- (void)setTableviewHeadView {
    self.tableView.tableHeaderView = [[TopStoryView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, TopStoriesHeight) TopStoryArray:self.topStoriesArray];
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
    [[NetworkTool sharedNetworkTool] loadDataInfo:LatestStoryApi parameters:nil success:^(id  _Nullable responseObject) {
        //最新故事
        for (NSDictionary *story in responseObject[@"stories"]) {
            StoryModel *storyModel = [StoryModel mj_objectWithKeyValues:story];
            [self.storiesArray addObject:storyModel];
            
        }
        //封面故事
        self.topStoriesArray = [NSMutableArray arrayWithArray:responseObject[@"top_stories"]];
        
        [self setTableviewHeadView];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nullable error) {

    }];
}

- (void)loadBeforeStory {
    NSString *completeBeforeStoryUrl = [[NSString stringWithFormat:BeforeStoryApi] stringByAppendingString:[[DateTool shareDateTool] transformUrlStringFromDate:self.date]];
    
    [[NetworkTool sharedNetworkTool] loadDataInfo:completeBeforeStoryUrl parameters:nil success:^(id  _Nullable responseObject) {
        self.date = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:_date];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *story in responseObject[@"stories"]) {
            StoryModel *storyModel = [StoryModel mj_objectWithKeyValues:story];
            [array addObject:storyModel];
        }
        [self.beforeStoriesArray addObject:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - LazyLoad
- (NSMutableArray<StoryModel *> *)storiesArray {
    if (!_storiesArray) {
        self.storiesArray = [[NSMutableArray alloc] init];
    }
    return _storiesArray;
}
- (NSMutableArray<StoryModel *> *)topStoriesArray {
    if (!_topStoriesArray) {
        self.topStoriesArray = [[NSMutableArray alloc] init];
    }
    return _topStoriesArray;
}
- (NSMutableArray<NSMutableArray<StoryModel *> *> *)beforeStoriesArray {
    if (!_beforeStoriesArray) {
        self.beforeStoriesArray = [[NSMutableArray alloc] init];
    }
    return _beforeStoriesArray;
}
- (NSDate *)date {
    if (!_date) {
        _date = [[NSDate alloc] init];
    }
    return _date;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_beforeStoriesArray.count == 0) {
        return 1;
    }
    else {
        return _beforeStoriesArray.count + 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_storiesArray.count == 0) {
            return 10;
        }
        else {
            return _storiesArray.count;
        }
    }
    else {
        return _beforeStoriesArray[section-1].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [StoryCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        if (_storiesArray.count == 0) {
            cell.titleLabel.text = @"纸糊日报";
        }
        else {
            [cell setCellMsg:_storiesArray[indexPath.row]];
        }
    }
    else {
        [cell setCellMsg:_beforeStoriesArray[indexPath.section-1][indexPath.row]];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDate *nowDate = [[NSDate alloc] init];
    for (int i = 0; i < section; i++) {
        nowDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:nowDate];
    }
    DateSectioinView *dateSectionView = [[DateSectioinView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, 30) Date:[[DateTool shareDateTool] transformTitleStringFromDate:nowDate]];
    return dateSectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryViewController *storyViewController;
    if (indexPath.section == 0) {
        storyViewController = [[StoryViewController alloc] initWithStoryId:self.storiesArray[indexPath.row].ID];
    }
    else {
        storyViewController = [[StoryViewController alloc] initWithStoryId:self.beforeStoriesArray[indexPath.section][indexPath.row].ID];
    }
    
    [self.navigationController pushViewController:storyViewController animated:YES];
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
