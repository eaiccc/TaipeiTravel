//
//  TravelTableViewCell.h
//  TaipeiTravel
//
//  Created by Mac on 2018/7/20.
//  Copyright © 2018年 Link. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTAttractions.h"
@interface TravelTableViewCell:UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *travelCollectionView;
@property (weak, nonatomic) TTAttractions *attraction;

- (void) loadData:(TTAttractions *) attraction;
@end
