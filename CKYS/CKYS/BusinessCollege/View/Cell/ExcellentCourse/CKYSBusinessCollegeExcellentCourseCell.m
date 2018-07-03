//
//  CKYSBusinessCollegeExcellentCourseCell.m
//  CKYS
//
//  Created by Yan on 2018/7/3.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "CKYSBusinessCollegeExcellentCourseCell.h"

#import "Masonry.h"
#import "Common.h"

#import "CKYSBusinessCollegeExcellentCourseCellDelegate.h"
#import "CKYSBusinessCollegeFreshListItemCell.h"

#import "UILabel+Category.h"
#import "UIButton+Title_Image.h"
#import "UIButton+ImageTitleSpacing.h"

#import "CKYSBusinessCollegeTitleMoreButtonView.h"

@interface CKYSBusinessCollegeExcellentCourseCell ()

<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
CKYSBusinessCollegeTitleMoreButtonViewDelegate>

@property (nonatomic, strong) UICollectionView *businessCollegeFreshListItemView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) id<CKYSBusinessCollegeExcellentCourseCellDelegate> delegate;

@property (nonatomic, strong) CKYSBusinessCollegeTitleMoreButtonView *titleMoreButtonView;

@end

@implementation CKYSBusinessCollegeExcellentCourseCell

- (void)setDelegate:(id<CKYSBusinessCollegeExcellentCourseCellDelegate>)dalegate {
    _delegate = dalegate;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"CKYSBusinessCollegeExcellentCourseCellID";
    CKYSBusinessCollegeExcellentCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CKYSBusinessCollegeExcellentCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initTitleAndMore];
        [self initItemView];
    }
    return self;
}

- (void)initTitleAndMore {//height 47
    _titleMoreButtonView = [[CKYSBusinessCollegeTitleMoreButtonView alloc] initWithDelegate:self];
    [self.contentView addSubview:_titleMoreButtonView];
    [_titleMoreButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.centerX.equalTo(self.contentView);
        make.height.equalTo(@47);
    }];
    [_titleMoreButtonView setTitle:@"新鲜出炉"];
}

- (void)buttonMoreAction:(UIButton *)sender {
    
}

- (void)initItemView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    _businessCollegeFreshListItemView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _businessCollegeFreshListItemView.backgroundColor = [UIColor whiteColor];
    [_businessCollegeFreshListItemView registerClass:[CKYSBusinessCollegeFreshListItemCell class] forCellWithReuseIdentifier:@"CKYSBusinessCollegeFreshListItemCell"];
    _businessCollegeFreshListItemView.delegate = self;
    _businessCollegeFreshListItemView.dataSource = self;
    _businessCollegeFreshListItemView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_businessCollegeFreshListItemView];
    [_businessCollegeFreshListItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(47);
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.height.equalTo(@(AdaptedHeight(274)));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CKYSBusinessCollegeFreshListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CKYSBusinessCollegeFreshListItemCell" forIndexPath:indexPath];

    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  1;
}

#pragma mark - UICollectionViewDelegateFlowLayout

/**设置每个item的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH/3,AdaptedHeight(105));
}

/**设置每个item的UIEdgeInsets*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
/**设置每个item水平间距*/
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark- UICollectionViewDelegate 点击跳转到对应页面

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self responseDelegateWithAtIndexPath:indexPath];
}

- (void)responseDelegateWithAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(businessCollegeExcellentCourseCellDelegateCell:indexpath:)]) {
        [_delegate businessCollegeExcellentCourseCellDelegateCell:self indexpath:indexPath];
    }
}

#pragma mark - CKYSBusinessCollegeTitleMoreButtonViewDelegate
- (void)CKYSBusinessCollegeTitleMoreButtonViewDelegate:(CKYSBusinessCollegeTitleMoreButtonView *)view moreAction:(UIButton *)sender {
    
}

@end
