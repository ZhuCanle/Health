//
//  HeImagesView.m
//  Health
//
//  Created by 快摇002 on 2017/6/18.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeImagesView.h"

#define LEFT_MARGIN 15
#define RIGHT_MARGIN 15
#define IMAGEVIEW_MARGIN 10

@interface HeImagesView ()

@property (strong, nonatomic) NSMutableArray *imageViewCollection;

@property (assign, nonatomic) CGFloat imageViewWidth;

@end

@implementation HeImagesView

- (NSMutableArray *)imageViewCollection
{
    if (_imageViewCollection == nil) {
        _imageViewCollection = [[NSMutableArray alloc]init];
    }
    return _imageViewCollection;
}

- (void)setImages:(NSMutableArray<HeImageModel *> *)images
{
    _images = images;

    _imageViewWidth = 0;

    while (images.count > self.imageViewCollection.count) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = UIColorFromRGB(0xf3f2f0);
        [self addSubview:imageView];
        [self.imageViewCollection addObject:imageView];
    }


    for (NSInteger i = 0; i < self.imageViewCollection.count; i ++ )
    {
        UIImageView *imageView = [self.imageViewCollection objectAtIndex:i];
        if (i < images.count) {

            imageView.hidden = NO;
            HeImageModel *model = [self.images objectAtIndex:i];

            //只有一张的图片情况
            if (images.count == 1)
            {
                [imageView setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@""]];

                if (model.width >= WIDTH - LEFT_MARGIN - RIGHT_MARGIN)
                {
                    imageView.frame = CGRectMake(0, 0, WIDTH - LEFT_MARGIN - RIGHT_MARGIN, (WIDTH - LEFT_MARGIN - RIGHT_MARGIN) *model.height/model.width);
                }else
                {
                    imageView.frame = CGRectMake(0, 0, model.width, model.height);
                }

            }else
            {
                 NSUInteger maxCol = 3;//最大列数

                _imageViewWidth = ((WIDTH - LEFT_MARGIN - RIGHT_MARGIN - (maxCol - 1) *IMAGEVIEW_MARGIN))/3;
                NSUInteger col = i % maxCol;
                NSUInteger row = i / maxCol;

                imageView.frame = CGRectMake(col*_imageViewWidth + col*IMAGEVIEW_MARGIN , row*(_imageViewWidth +IMAGEVIEW_MARGIN), _imageViewWidth, _imageViewWidth);
                imageView.clipsToBounds = YES;
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                [self addSubview:imageView];
                imageView.userInteractionEnabled = YES;
                imageView.tag = i+1000;
                imageView.backgroundColor = UIColorFromRGB(0xf3f2f0);
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoImageViewClick:)];
                [imageView addGestureRecognizer:tap];
            }
        }else
        {
            imageView.hidden = YES;
        }
    }
}

- (void)photoImageViewClick:(UITapGestureRecognizer *)tap
{


}

+ (CGSize)imgaesViewSizeWith:(NSMutableArray <HeImageModel *>*)images
{
    if (images.count == 0) {
        return CGSizeZero;
    }else if (images.count == 1)
    {
        HeImageModel *model = [images firstObject];
        if (model.width == 0  || model.height == 0) {
            return CGSizeZero;
        }else
        {
            if (model.width >= WIDTH - LEFT_MARGIN - RIGHT_MARGIN)
            {
                 return CGSizeMake(WIDTH - LEFT_MARGIN - RIGHT_MARGIN, (WIDTH - LEFT_MARGIN - RIGHT_MARGIN) *model.height/model.width);
            }else
            {
                return CGSizeMake(model.width, model.height);

            }
        }
    }else
    {
        NSUInteger maxCol = 3;//最大列数
        NSUInteger row = images.count / maxCol;

        CGFloat width = ((WIDTH - LEFT_MARGIN - RIGHT_MARGIN - (maxCol - 1) *IMAGEVIEW_MARGIN))/3;

        return CGSizeMake(WIDTH - LEFT_MARGIN - RIGHT_MARGIN, row*IMAGEVIEW_MARGIN + (row + 1)*width);
    }
}


@end
