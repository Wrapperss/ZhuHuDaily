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

@interface ZhuHuViewController ()

@end

@implementation ZhuHuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadLastStory];
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadBeforeStory];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NavigationBar
- (void)setNav {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:52/255.0 green:185/255.0 blue:252/255.0 alpha:1];
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

#pragma mark - LoadStory
- (void)loadLastStory {
    [[NetworkTool sharedNetworkTool] loadDataInfo:LatestStoryUrl parameters:nil success:^(id  _Nullable responseObject) {
        for (NSDictionary *story in responseObject[@"stories"]) {
            StoryModel *storyModel = [StoryModel mj_objectWithKeyValues:story];
            [self.items addObject:storyModel];
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nullable error) {

    }];
}

- (void)loadBeforeStory {
    [[NetworkTool sharedNetworkTool] loadDataInfo:[[NSString stringWithFormat:BeforeStoryUrl] stringByAppendingString:self.nowDate] parameters:nil success:^(id  _Nullable responseObject) {
        for (NSDictionary *story in responseObject[@"stories"]) {
            StoryModel *storyModel = [StoryModel mj_objectWithKeyValues:story];
            [self.items addObject:storyModel];
            [self.tableView reloadData];
        }        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - LazyLoad
- (NSMutableArray *)items {
    if (!_items) {
        self.items = [[NSMutableArray alloc] init];
    }
    return _items;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.items.count == 0) {
        return 10;
    }
    else{
        return self.items.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [StoryCell cellWithTableView:tableView];
    if (self.items.count == 0) {
        cell.titleLabel.text = @"纸糊日报";
    }
    else {
        [cell setCellMsg:self.items[indexPath.row]];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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

@end
