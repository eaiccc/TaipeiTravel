//
//  DetailViewController.m
//  TaipeiTravel
//
//  Created by Mac on 2018/7/21.
//  Copyright © 2018年 Link. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
