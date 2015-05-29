//
//  ImageFilterBtn.h
//  GifDemo
//
//  Created by Rick on 15/5/29.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFilterItem : UIView
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *titleLabel;
//@property(nonatomic,strong) NSDictionary *filterDict;
@property(nonatomic,strong) UIImage *iconImage;
- (void)setIconImage:(UIImage *)iconImage;
@end
