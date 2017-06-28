//
//  HeSubCategoryView.m
//  Health
//
//  Created by 快摇002 on 2017/6/17.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeSubCategoryView.h"
#import "HeCategoryCell.h"

@interface HeSubCategoryView ()<UICollectionViewDelegate,
                                UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) NSMutableArray <HeCategoryModel *>*items;
@property (copy, nonatomic) subCategoryViewDidSelected block;

@end

@implementation HeSubCategoryView

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self.contentView addSubview:self.collectionView];

    self.backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];

    @weakify(self);
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        [self dismiss];
    }];
}

+ (instancetype)getSubCategoryView
{
    HeSubCategoryView *subCategory = [HeSubCategoryView viewWithXib];
    subCategory.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    return subCategory;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    self.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity,
//                                                        CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    }];

//    [self showAnimationWithView:self.contentView duration:0.25];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
//    [self dismissAnimationWithView:self.contentView duration:0.25];
}

- (void)setSubCategoryViewTitle:(NSString *)title items:(NSMutableArray *)items callBackBlock:(subCategoryViewDidSelected)block
{
    self.titleLabel.text = title;
    self.items = items;
    _block = block;
    [self.collectionView reloadData];
}

-(void)showAnimationWithView:(UIView *)view duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;

    animation.fillMode = kCAFillModeForwards;

    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];

    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];

    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];

    [view.layer addAnimation:animation forKey:nil];
}

-(void)dismissAnimationWithView:(UIView *)view duration:(CFTimeInterval)duration{

    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;

    animation.fillMode = kCAFillModeForwards;

    NSMutableArray *values = [NSMutableArray array];

    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];

    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];

    [view.layer addAnimation:animation forKey:nil];
}
#pragma mark - lazyload

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, WIDTH, HEIGHT - 50-50) collectionViewLayout:layout];
        [_collectionView registerNib:[HeCategoryCell loadNib] forCellWithReuseIdentifier:@"HeCategoryCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     HeCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeCategoryCell" forIndexPath:indexPath];
    HeCategoryModel *model = [self.items objectAtIndex:indexPath.row];
    cell.title = model.posts_classification_name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self dismiss];
    _block(indexPath.row);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH/3, 40);
}


@end
