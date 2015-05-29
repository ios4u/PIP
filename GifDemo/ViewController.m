//
//  ViewController.m
//  GifDemo
//
//  Created by Rick on 15/5/26.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import "ViewController.h"
#import "GifView.h"
#import "ImageCropperView.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "PendantImageView.h"
#import "BackImageView.h"
#import <CoreImage/CoreImage.h>
#import "ImageFilterItem.h"
#import "UIImage+Util.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ImageCropperView *_cropper;
    UIButton *_btn;
    BackImageView *_backImageView;
    UIButton *_chooseBtn;
    NSMutableArray *_array;
    NSDictionary *_selectedPipDic;
    UITableView *_tableView;
    PendantImageView *_pendantImageView;
    UIImageView *_lastImageView;
    UIView *_backgroundView;
    
    UIScrollView *_imageFilterScrollView;
    NSMutableArray *_filterNamesArray;
    UIImage *_originalImage;
}
@end

@implementation ViewController

-(void)arrayInit{
    NSMutableArray *array = [NSMutableArray array];
    _array = array;
    NSDictionary *dict1 = @{
                            @"name":@"画中画01背景.jpg",
                            @"isGIF":@NO,
                            @"layerMasksToBounds":@NO,//layer是否需要裁减圆角
                            @"hasPendant":@YES,//是否有挂件
                            @"pendantName":@"画中画01前景效果.png",
                            @"width":@320,
                            @"height":@192,
                            @"photoFrame":[NSValue valueWithCGRect:CGRectMake(188/2, 38/2, 256/2, 308/2)],
                            @"pendantFrame":[NSValue valueWithCGRect:CGRectMake(188/2, 38/2, 256/2, 308/2)]
                            };

    
    NSDictionary *dict2 = @{
                            @"name":@"画中画02背景.gif",
                            @"isGIF":@YES,
                            @"layerMasksToBounds":@NO,//layer是否需要裁减圆角
                            @"hasPendant":@NO,//是否有挂件
                            @"pendantName":@"",
                            @"width":@320,
                            @"height":@192,
                            @"photoFrame":[NSValue valueWithCGRect:CGRectMake(195/2, 40/2, 251/2, 302/2)]
                            };
    
    NSDictionary *dict4 = @{
                            @"name":@"画中画04背景.jpg",
                            @"isGIF":@NO,
                            @"layerMasksToBounds":@NO,//layer是否需要裁减圆角
                            @"hasPendant":@YES,//是否有挂件
                            @"pendantName":@"画中画04前景效果.png",
                            @"width":@320,
                            @"height":@192,
                            @"photoFrame":[NSValue valueWithCGRect:CGRectMake(147/2, 33/2, 256/2, 308/2)],
                            @"pendantFrame":[NSValue valueWithCGRect:CGRectMake(147/2, 33/2, 256/2, 308/2)]
                            };
    
    
    NSDictionary *dict5 = @{
                            @"name":@"画中画05背景.jpg",
                            @"isGIF":@NO,
                            @"layerMasksToBounds":@NO,//layer是否需要裁减圆角
                            @"hasPendant":@NO,//是否有挂件
                            @"pendantName":@"",
                            @"width":@320,
                            @"height":@192,
                            @"photoFrame":[NSValue valueWithCGRect:CGRectMake(275/2, 36/2, 256/2, 308/2)]
                            };
    
    
    NSDictionary *dict6 = @{
                            @"name":@"画中画06背景.jpg",
                            @"isGIF":@NO,
                            @"hasPendant":@YES,//是否有挂件
                            @"layerMasksToBounds":@YES,//layer是否需要裁减圆角
                            @"cornerRadius":@(25/2),//圆角弧度
                            @"pendantName":@"画中画06前景效果.png",
                            @"width":@320,
                            @"height":@192,
                            @"photoFrame":[NSValue valueWithCGRect:CGRectMake(236/2, 86/2, 164/2, 220/2)],
                            @"pendantFrame":[NSValue valueWithCGRect:CGRectMake(236/2, 86/2, 164/2, 220/2)]
                            };
    
    
    NSDictionary *dict7 = @{
                            @"name":@"画中画07背景.jpg",
                            @"isGIF":@NO,
                            @"hasPendant":@YES,//是否有挂件
                            @"layerMasksToBounds":@NO,//layer是否需要裁减圆角
                            @"pendantName":@"画中画07前景效果.png",
                            @"width":@320,
                            @"height":@192,
                            @"photoFrame":[NSValue valueWithCGRect:CGRectMake(146/2, 110/2, 200/2, 239/2)],
                            @"pendantFrame":[NSValue valueWithCGRect:CGRectMake(146/2, 110/2, 200/2, 239/2)]
                            };
    
    NSDictionary *dict8 = @{
                            @"name":@"画中画08背景.jpg",
                            @"isGIF":@NO,
                            @"hasPendant":@YES,//是否有挂件
                            @"layerMasksToBounds":@NO,//layer是否需要裁减圆角
                            @"pendantName":@"画中画08前景效果.png",
                            @"width":@320,
                            @"height":@192,
                            @"photoFrame":[NSValue valueWithCGRect:CGRectMake(177/2, 127/2, 296/2, 156/2)],
                            @"pendantFrame":[NSValue valueWithCGRect:CGRectMake(177/2, 127/2, 296/2, 156/2)]
                            };
    
    NSDictionary *dict9 = @{
                            @"name":@"画中画09背景.png",
                            @"isGIF":@NO,
                            @"isIrregular":@YES,//是否为不规则的背景
                            @"hasPendant":@NO,//是否有挂件
                            @"layerMasksToBounds":@NO,//layer是否需要裁减圆角
                            @"width":@320,
                            @"height":@192,
                            @"photoFrame":[NSValue valueWithCGRect:CGRectMake(177/2, 127/2, 296/2, 156/2)]
                            };
    [array addObject:dict1];
    [array addObject:dict2];
    [array addObject:dict4];
    [array addObject:dict5];
    [array addObject:dict6];
    [array addObject:dict7];
    [array addObject:dict8];
    [array addObject:dict9];
}

-(void)filterNamesArrayInit{
    _filterNamesArray = [NSMutableArray array];
    NSDictionary *dict0 = @{@"NONE":@"None"};
    NSDictionary *dict1 = @{@"CISRGBToneCurveToLinear":@"Linear"};
    NSDictionary *dict2 = @{@"CIVignetteEffect":@"Effect"};
    NSDictionary *dict3 = @{@"CIPhotoEffectInstant":@"Instant"};
    NSDictionary *dict4 = @{@"CIPhotoEffectProcess":@"Process"};
    NSDictionary *dict5 = @{@"CIPhotoEffectTransfer":@"Transfer"};
    NSDictionary *dict6 = @{@"CISepiaTone":@"Tone"};
    NSDictionary *dict7 = @{@"CIPhotoEffectChrome":@"Chrome"};
    NSDictionary *dict8 = @{@"CIPhotoEffectFade":@"Fade"};
    NSDictionary *dict9 = @{@"CILinearToSRGBToneCurve":@"Curve"};
    NSDictionary *dict10 = @{@"CIPhotoEffectTonal":@"Tonal"};
    NSDictionary *dict11 = @{@"CIPhotoEffectNoir":@"Noir"};
    NSDictionary *dict12 = @{@"CIPhotoEffectMono":@"Mono"};
    NSDictionary *dict13 = @{@"CIColorInvert":@"Invert"};
    [_filterNamesArray  addObject:dict0];
    [_filterNamesArray  addObject:dict1];
    [_filterNamesArray  addObject:dict2];
    [_filterNamesArray  addObject:dict3];
    [_filterNamesArray  addObject:dict4];
    [_filterNamesArray  addObject:dict5];
    [_filterNamesArray  addObject:dict6];
    [_filterNamesArray  addObject:dict7];
    [_filterNamesArray  addObject:dict8];
    [_filterNamesArray  addObject:dict9];
    [_filterNamesArray  addObject:dict10];
    [_filterNamesArray  addObject:dict11];
    [_filterNamesArray  addObject:dict12];
    [_filterNamesArray  addObject:dict13];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self arrayInit];
    [self filterNamesArrayInit];
    _pendantImageView = [[PendantImageView alloc] init];
    
    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, kScreenWidth, kScreenWidth/320 * 192)];
//    _backgroundView.center = CGPointMake(kScreenWidth/2, _backgroundView.frame.size.height/2+_backgroundView.frame.origin.y);
    [self.view addSubview:_backgroundView];
    
    _selectedPipDic = _array.firstObject;
    [self changePip:_array.firstObject];
    
    _lastImageView = [[UIImageView alloc]init];
    [self.view addSubview:_lastImageView];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"完成" forState:UIControlStateNormal];
    _btn.backgroundColor = [UIColor redColor];    
    _btn.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 80, 50, 50);
    [_btn addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_chooseBtn setTitle:@"画中画" forState:UIControlStateNormal];
    _chooseBtn.backgroundColor = [UIColor redColor];
    _chooseBtn.frame = CGRectMake(CGRectGetMaxX(_btn.frame)+20, _btn.frame.origin.y, 100, 50);
    [_chooseBtn addTarget:self action:@selector(showPIPTableView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_chooseBtn];
    
    
    UIButton *imageFilterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageFilterBtn setTitle:@"滤镜" forState:UIControlStateNormal];
    imageFilterBtn.frame = CGRectMake(CGRectGetMaxX(_chooseBtn.frame)+20, _btn.frame.origin.y, 50, 50);
    imageFilterBtn.backgroundColor = [UIColor redColor];
    [imageFilterBtn addTarget:self action:@selector(showImageFilterScrollView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imageFilterBtn];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    resetButton.backgroundColor = [UIColor redColor];
    resetButton.frame = CGRectMake(CGRectGetMaxX(imageFilterBtn.frame)+20, _chooseBtn.frame.origin.y, 50, 50);
    [resetButton addTarget:self action:@selector(resetCroperView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
}

-(void)changePip:(NSDictionary *)dict{
    [_cropper reset];
    if(_backImageView == nil){

        _backImageView = [[BackImageView alloc]init];
        
        _backImageView.frame = CGRectMake(0, 0, _backgroundView.frame.size.width, _backgroundView.frame.size.height);

        [_backgroundView addSubview:_backImageView];
        if(_cropper == nil){
            _cropper = [[ImageCropperView alloc]init];
            [_backImageView addSubview:_cropper];
            _cropper.frame = CGRectMake(0, 0, 100, 100);
            [_cropper setup];
        }
        
        
    }
    
    NSString *name = dict[@"name"];
    BOOL hasPendant = [dict[@"hasPendant"] boolValue];
    if (hasPendant) {
        _pendantImageView.alpha = 1.0;
        NSURL *pendantImageURL = [[NSBundle mainBundle] URLForResource:dict[@"pendantName"] withExtension:nil];
        [_pendantImageView sd_setImageWithURL:pendantImageURL];
    }else{
        _pendantImageView.alpha = 0;
    }

    CGRect photoFrame = [dict[@"photoFrame"] CGRectValue];
    NSURL *backImageFileUrl = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
    [_backImageView sd_setImageWithURL:backImageFileUrl];

    
    
    BOOL layerMasksToBounds = [dict[@"layerMasksToBounds"] boolValue];
    if (layerMasksToBounds) {
        _cropper.layer.masksToBounds = YES;
        _cropper.layer.cornerRadius = [dict[@"cornerRadius"] doubleValue];
    }else{
        _cropper.layer.masksToBounds = YES;
        _cropper.layer.cornerRadius = 0;
    }
    
    BOOL isIrregular = [dict[@"isIrregular"] boolValue];
    if (isIrregular) {
        [_pendantImageView removeFromSuperview];
        if (hasPendant) {
            _pendantImageView.alpha =1;
            [_backImageView addSubview:_pendantImageView];
        }
        
        //不规则的背景图
        _backImageView.isIrregular = YES;
        _backImageView.userInteractionEnabled = YES;
        [_cropper removeFromSuperview];
        [_backgroundView addSubview:_cropper];
        [_backgroundView bringSubviewToFront:_backImageView];
        _cropper.frame = CGRectMake(0, 0, _backImageView.frame.size.width, _backImageView.frame.size.height);
        
    }else{
        //规则背景图
        _backImageView.userInteractionEnabled = YES;
        _backImageView.isIrregular = NO;
        [_cropper removeFromSuperview];

        _cropper.frame = CGRectMake(kScreenWidth/320*photoFrame.origin.x, kScreenWidth/320*photoFrame.origin.y, kScreenWidth/320*photoFrame.size.width, kScreenWidth/320*photoFrame.size.height);
        [_backImageView addSubview:_cropper];
        _pendantImageView.frame = CGRectMake(0, 0, _cropper.frame.size.width, _cropper.frame.size.height);
        _pendantImageView.userInteractionEnabled = YES;
        
        [_cropper addSubview:_pendantImageView];
//        [_cropper bringSubviewToFront:_pendantImageView];
    }
    
    UIImage *image = [UIImage imageNamed:@"IMG_0027.JPG"];
    _originalImage = [image copy];
    _cropper.image = image;
//    CIContext *context = [CIContext contextWithOptions:nil];
//    //黑白滤镜
//    CIImage *beginImage = [CIImage imageWithCGImage:image.CGImage];
//    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectNoir"
//                                  keysAndValues: kCIInputImageKey, beginImage, nil];
//
//    CIImage *outputImage = [filter outputImage];
//    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[beginImage extent]];
//    UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:image.scale orientation:image.imageOrientation];
//    _cropper.image = newImage;
//    CGImageRelease(cgimg);

}

-(void)showImageFilterScrollView:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        if (_imageFilterScrollView == nil) {
            UIImage *iconThumbnail = [_originalImage aspectFill:CGSizeMake(50*[[UIScreen mainScreen] scale], 50*[[UIScreen mainScreen] scale])];
            
            _imageFilterScrollView = [[UIScrollView alloc]init];
            _imageFilterScrollView.frame = CGRectMake(0, btn.frame.origin.y-80, kScreenWidth, 80);
            _imageFilterScrollView.contentSize = CGSizeMake(80*_filterNamesArray.count-10, 80);
            for (NSInteger i = 0 ; i<_filterNamesArray.count; i++) {
                NSDictionary *dict = _filterNamesArray[i];
                NSString *filterNameValue = [dict allValues].firstObject;
                NSString *filterNameKey = [dict allKeys].firstObject;
                ImageFilterItem *btn = [[ImageFilterItem alloc]init];
                btn.frame = CGRectMake(i*80, 0, 80, 80);
                btn.imageView.backgroundColor = [UIColor blueColor];
                btn.imageView.layer.borderWidth = 1.0f;
                btn.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
                btn.backgroundColor = [UIColor grayColor];
                btn.titleLabel.text = filterNameValue;
                [_imageFilterScrollView addSubview:btn];
                if (i==0) {
                    btn.iconImage = [iconThumbnail copy];
                    [btn setIconImage:[iconThumbnail copy]];
                }else{
                    if (btn.iconImage == nil) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            UIImage *iconImage = [self filteredImage:iconThumbnail withFilterName:filterNameKey];
                            [btn performSelectorOnMainThread:@selector(setIconImage:) withObject:iconImage waitUntilDone:NO];
                        });
                    }
                }
                
            }
            [self.view addSubview:_imageFilterScrollView];
            
        }
    }else{
        [_imageFilterScrollView removeFromSuperview];
        _imageFilterScrollView = nil;
    }
    
}

-(UIImage *)filteredImage:(UIImage *)image withFilterName:(NSString *)filterName{
    CIContext *context = [CIContext contextWithOptions:nil];
    //黑白滤镜
    CIImage *beginImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:filterName
                                  keysAndValues: kCIInputImageKey, beginImage, nil];
    
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[beginImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(cgimg);
    return newImage;
}

-(void)resetCroperView{
    [_cropper reset];
    _lastImageView.image = nil;
    
}
- (void)buttonClicked
{
    UIImage *image;
    UIGraphicsBeginImageContextWithOptions(_cropper.bounds.size, NO, 0);
    [_cropper.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
   
    UIGraphicsEndImageContext();

    [self addWaterAction:image];
    
}

-(void)showPIPTableView:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        if (!_tableView) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(btn.frame.origin.x-btn.frame.size.width/2, btn.frame.origin.y-300, 300, 300) style:UITableViewStylePlain];
            _tableView.delegate =self;
            _tableView.dataSource = self;
            _tableView.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:_tableView];
        }

    }else{
        [_tableView removeFromSuperview];
        _tableView = nil;
    }
}

-(void)addWaterAction:(UIImage *)image{
    NSDate *date = [NSDate date];

    
    if ([_selectedPipDic[@"isGIF"]boolValue]) {
        //读取本地GIF图中每一帧图像的信息
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:_selectedPipDic[@"name"] withExtension:nil];
        NSDictionary *dic = [GifView getGifInfo:fileUrl];
        NSMutableArray *imageArray = [NSMutableArray array];
        
        //在gif图的每一帧上面添加一段文字
        for(int index=0;index<[dic[@"images"] count];index++)
        {
            //绘制view 已GIf图中的某一帧为背景并在view上添加文字
            UIView *tempView = [[UIView alloc] initWithFrame:CGRectFromString(dic[@"bounds"])];
            tempView.backgroundColor = [UIColor colorWithPatternImage:dic[@"images"][index]];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            CGRect photoFrame = [_selectedPipDic[@"photoFrame"] CGRectValue];
//            imageView.frame = CGRectMake(195, 40, 251, 302);
            imageView.frame = CGRectMake(photoFrame.origin.x*2, photoFrame.origin.y*2, photoFrame.size.width*2, photoFrame.size.height*2);
            [tempView addSubview:imageView];
            
            
            //将UIView转换为UIImage
            UIGraphicsBeginImageContextWithOptions(tempView.bounds.size, NO, tempView.layer.contentsScale);
            [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            [imageArray addObject:image];
            UIGraphicsEndImageContext();
        }
        //生成GIF图 -- loopCount 为0表示无限播放
        NSString *path = [GifView exportGifImages:[imageArray copy] delays:dic[@"delays"] loopCount:0];
        NSURL *gifURL = [NSURL fileURLWithPath:path];
        [_lastImageView sd_setImageWithURL:gifURL];
        NSLog(@"图片生成路劲：%@",path);
    }else{
        UIImage *backGroundImage;
        UIGraphicsBeginImageContextWithOptions(_backImageView.bounds.size, NO, 0);
        [_backgroundView.layer renderInContext:UIGraphicsGetCurrentContext()];
        backGroundImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _lastImageView.image = backGroundImage;
        
    }
    
    _lastImageView.frame = CGRectMake(_backgroundView.frame.origin.x, CGRectGetMaxY(_backgroundView.frame)+10, _backgroundView.frame.size.width, _backgroundView.frame.size.height);
    
    NSLog(@"合成GIF图用时：%f秒",[[NSDate date] timeIntervalSinceDate:date]);

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
    
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict = _array[indexPath.row];
    //设置cell数据
    cell.imageView.image = [UIImage imageNamed:dict[@"name"]];
    cell.textLabel.text = dict[@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedPipDic = _array[indexPath.row];
    [self changePip:_selectedPipDic];
    _chooseBtn.selected = NO;
    [_tableView removeFromSuperview];
    _tableView = nil;
}

@end
