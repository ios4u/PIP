//
//  BackImageView.m
//  GifDemo
//
//  Created by Rick on 15/5/27.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import "BackImageView.h"
#import "ImageCropperView.h"

@implementation BackImageView


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *hitView = [super hitTest:point withEvent:event];
    if (!_isIrregular) {
        return self;
    }else{
        NSArray *array = hitView.superview.subviews;
        if (array.count>0) {
            for (UIView *view in array) {
                if ([view isKindOfClass:[ImageCropperView class]]) {
                    return nil;
                }
            }
        }
        return self;
    }
}

@end