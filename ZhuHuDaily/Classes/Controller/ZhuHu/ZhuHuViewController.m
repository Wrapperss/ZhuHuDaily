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

#define NAVBAR_CHANGE_POINT 50

@interface ZhuHuViewController ()<TopStoryViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)TopStoryView *topStoryView;
@property (nonatomic, retain)UITableView *tableView;

@end

@implementation ZhuHuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRefresh];
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TopStoryViewDelegate 
- (void)showTopStoryDetail {
    NSLog(@"点击了");
}
#pragma mark - UI
- (void)setUpUI {
    [self setNav];
    [self setTableView];
    [self setTableviewHeadView];
}
- (void)setNav {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}
- (void)setTableView {
    [self.view addSubview:self.tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
- (void)setTableviewHeadView {
    self.tableView.tableHeaderView = self.topStoryView;
}

#pragma mark - Scrollview from tableview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //navigationBar
    UIColor * color = ZhuHuColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
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
    YYCache *topStoriesCache = [YYCache cacheWithName:@"TopStoriesCache"];
    YYCache *stotriesCache = [YYCache cacheWithName:@"storiesCache"];
    NSString *todayTitle = [[DateTool shareDateTool] transformTitleStringFromDate:[NSDate date]];
    [[NetworkTool sharedNetworkTool] loadDataInfo:LatestStoryApi parameters:nil success:^(id  _Nullable responseObject) {
        //最新故事
        for (NSDictionary *story in responseObject[@"stories"]) {
            StoryModel *storyModel = [StoryModel mj_objectWithKeyValues:story];
            [self.storiesArray addObject:storyModel];
        }
        [stotriesCache setObject:self.storiesArray forKey:todayTitle];
        //封面故事
        for (NSDictionary *topStory in responseObject[@"top_stories"]) {
            TopStoryModel *topStoryModel = [TopStoryModel mj_objectWithKeyValues:topStory];
            [self.topStoriesArray addObject:topStoryModel];
        }
        [self.topStoryView reSetUpUI:self.topStoriesArray];
        [topStoriesCache setObject:self.topStoriesArray forKey:@"topStories"];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nullable error) {
        
        if ([stotriesCache containsObjectForKey:todayTitle]) {
            [SVProgressHUD showErrorWithStatus:@"刷新失败～"];
            self.storiesArray = (NSMutableArray<StoryModel *> *)[stotriesCache objectForKey:todayTitle];
            [self.tableView reloadData];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"加载失败～"];
            [self loadBeforeStory];
        }
        self.topStoriesArray = (NSMutableArray<TopStoryModel *> *)[topStoriesCache objectForKey:@"topStories"];
        [self.topStoryView reSetUpUI:self.topStoriesArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadBeforeStory {
    YYCache *stotriesCache = [YYCache cacheWithName:@"storiesCache"];
    
    NSString *completeBeforeStoryUrl = [[NSString stringWithFormat:BeforeStoryApi] stringByAppendingString:[[DateTool shareDateTool] transformUrlStringFromDate:self.date]];
    self.date = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:_date];
    
    //缓存中存在
    if ([stotriesCache containsObjectForKey:[[DateTool shareDateTool] transformTitleStringFromDate:self.date]]) {
        [self.beforeStoriesArray addObject:(NSMutableArray<StoryModel *> *)[stotriesCache objectForKey:[[DateTool shareDateTool] transformTitleStringFromDate:self.date]]];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }
    //缓存中不存在
    else {
        [[NetworkTool sharedNetworkTool] loadDataInfo:completeBeforeStoryUrl parameters:nil success:^(id  _Nullable responseObject) {
            NSMutableArray<StoryModel *> *array = [[NSMutableArray alloc] init];
            for (NSDictionary *story in responseObject[@"stories"]) {
                StoryModel *storyModel = [StoryModel mj_objectWithKeyValues:story];
                [array addObject:storyModel];
            }
            [stotriesCache setObject:array forKey:[[DateTool shareDateTool] transformTitleStringFromDate:self.date]];
            
            [self.beforeStoriesArray addObject:array];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSError * _Nullable error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            [self.tableView.mj_footer endRefreshing];
        }];
    }
}

#pragma mark - LazyLoad
- (NSMutableArray<StoryModel *> *)storiesArray {
    if (!_storiesArray) {
        self.storiesArray = [[NSMutableArray alloc] init];
    }
    return _storiesArray;
}
- (NSMutableArray<TopStoryModel *> *)topStoriesArray {
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

- (TopStoryView *)topStoryView {
    if (!_topStoryView) {
        _topStoryView = [[TopStoryView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, TopStoriesHeight)];
        _topStoryView.delegate = self;
        [_topStoryView setUpUI];
    }
    return _topStoryView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, AppWidth, AppHeight + 64) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
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
            return 0;
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
        storyViewController = [[StoryViewController alloc] initWithStoryId:self.beforeStoriesArray[indexPath.section-1][indexPath.row].ID];
    }
    
    [self.navigationController pushViewController:storyViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//设置tableViewCell分割线上下去边线，中间缩进
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets UIEgde = UIEdgeInsetsMake(0, 15, 0, 15);
    
    
    if (indexPath.section == self.storiesArray.count-1) {
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsMake(0, AppWidth, 0, 0);
    }else{
        [cell setSeparatorInset:UIEgde];
        
    }
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
