//
//  TravelTableViewController.m
//  TaipeiTravel
//
//  Created by Mac on 2018/7/19.
//  Copyright © 2018年 Link. All rights reserved.
//

#import "TravelTableViewController.h"
#import "MBProgressHUD.h"

#import "TravelTableViewCell.h"
#import "TTConst.h"
#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TTProtocol.h"
#import "TravelTableViewModel.h"
@interface TravelTableViewController () <TTTravelViewModelDelegate>{
    int travelTotal;
    int travelOffset;
    int travelLimit;
    BOOL isLoading;
    TravelTableViewModel *viewModel;
}

@end

@implementation TravelTableViewController

static NSString *cellIdentifier = @"travelTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    viewModel = [[TravelTableViewModel alloc]initWithDelegate:self];
    [viewModel getTravelData];
    [self.tableView registerNib:[UINib nibWithNibName:[TravelTableViewCell description] bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickAttractionPhoto:) name:AttractionPhotoClickNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
}

- (void)clickAttractionPhoto:(NSNotification *)aNotification {
    NSString *path = aNotification.userInfo[@"path"];
    DetailViewController *detailVc = DetailViewController.new;
    [detailVc.imageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:nil];
    [self.navigationController pushViewController:detailVc animated:YES];
}
- (void)dataDidLoad {
    [self.tableView reloadData];
}

- (void)getDataFail:(NSError*)error{
    NSDictionary *p_dic = error.userInfo;
    NSString *errorDescprition = p_dic[@"NSLocalizedDescription"];
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Network Error"
                                 message:errorDescprition
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"%@", p_dic.description);
}
- (void)showHud:(BOOL)isShow{
    if (isShow) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return viewModel.attractions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = UIColor.clearColor;
    
    if (indexPath.row < viewModel.attractions.count) {
        TTAttractions *attraction = viewModel.attractions[indexPath.row];
        [cell loadData:attraction];
        cell.attraction = attraction;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewAutomaticDimension;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    if (aScrollView.contentOffset.y >= (aScrollView.contentSize.height - aScrollView.frame.size.height)) {
        [viewModel loadMore];
    }
}


@end
