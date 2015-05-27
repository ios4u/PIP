//
//  PendantImageView.m
//  GifDemo
//
//  Created by Rick on 15/5/27.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import "PendantImageView.h"

@implementation PendantImageView

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView  *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }else{
        return hitView;
    }
    
}

@end
