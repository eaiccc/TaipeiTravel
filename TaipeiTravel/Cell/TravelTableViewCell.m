//
//  TravelTableViewCell.m
//  TaipeiTravel
//
//  Created by Mac on 2018/7/20.
//  Copyright © 2018年 Link. All rights reserved.
//

#import "TravelTableViewCell.h"
#import "TravelPictureCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TTConst.h"
@implementation TravelTableViewCell
static NSString *cellIdentifier = @"TravelPictureCollectionViewCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.travelCollectionView.delegate = self;
    self.travelCollectionView.dataSource = self;
    
    [self.travelCollectionView registerNib:[UINib nibWithNibName:[TravelPictureCollectionViewCell description] bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

- (void) loadData:(TTAttractions *) attraction{
    self.attraction = attraction;
    self.titleLabel.text = attraction.title;
    self.descriptionTextView.text = attraction.body;
    [self.travelCollectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.attraction != nil && self.attraction.files != nil){
        return self.attraction.files.count;
    }
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TravelPictureCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *path = self.attraction.files[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:path]
                                        placeholderImage:nil];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *path = self.attraction.files[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:AttractionPhotoClickNotification object:self userInfo:@{ @"path" : path }];

}

@end
