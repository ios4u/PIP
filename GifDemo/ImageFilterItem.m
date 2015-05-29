//
//  ImageFilterBtn.m
//  GifDemo
//
//  Created by Rick on 15/5/29.
//  Copyright (c) 2015年 Rick. All rights reserved.
//
#define kImageRatio 0.8

#import "ImageFilterItem.h"

@implementation ImageFilterItem


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
    }
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_titleLabel];
    }
    
    _imageView.frame = CGRectMake(0, 0, 50, 50);
    _titleLabel.frame = CGRectMake(_imageView.frame.origin.x, CGRectGetMaxY(_imageView.frame)+10, _imageView.frame.size.width, 20);

}

- (void)setIconImage:(UIImage *)iconImage
{
    _imageView.image = iconImage;
}
@end
