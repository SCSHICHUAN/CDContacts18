//
//  SCPlayButton.m
//  Recorder
//
//  Created by 蓝科 on 16/5/18.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import "SCPlayButton.h"

@interface SCPlayButton ()
@property (nonatomic, strong) NSArray *images;


@end


@implementation SCPlayButton
#pragma mark - 懒加载
- (NSArray *)images
{
    if (_images == nil) {
        NSMutableArray *images = [NSMutableArray array];
        for (int i=1; i<4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"lp_bugle%d",i];
            UIImage *image = [UIImage imageNamed:imageName];
            [images addObject:image];
        }
        _images = images;
    }
    return _images;
}
#pragma mark - 重写父类方法
#pragma mark 纯代码初始化调用的方法
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContent];
    }
    return self;
}

#pragma mark xib加载回调的方法
-(void)awakeFromNib
{
    [self setContent];
}
#pragma mark 设置按钮中imageView的frame的回调方法
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w=18;
    CGFloat h=16;
    CGFloat x=contentRect.size.width*0.5+8;
    CGFloat y=(contentRect.size.height-h)/2.0;
    
    return CGRectMake(x, y, w, h);
}
#pragma mark 设置按钮中titleLabel的frame的回调方法
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    contentRect.origin.x=contentRect.size.width*0.5 - 28;
    contentRect.size.width = 30;
    return contentRect;
}

#pragma mark - 自定义方法
#pragma mark 设置显示内容
- (void)setContent
{
    self.backgroundColor = [UIColor clearColor];
    [self setBackgroundImage:[UIImage imageNamed:@"lp_audioplay_button"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"lp_audioplay_button"] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:@"lp_bugle3"] forState:UIControlStateNormal];
    [self setTitle:@"0\"" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.imageView.animationImages = self.images;
    self.imageView.animationDuration = 1.0f;
    
    
    
}

-(void)setDuration:(NSTimeInterval)duration
{
    
    _duration = duration;
    NSString *str = [NSString stringWithFormat:@"%.f\"",_duration+1];
    [self setTitle:str forState:UIControlStateNormal];

}

#pragma mark 播放动画
- (void)startAnimating
{
    [self.imageView startAnimating];
}

#pragma mark 停止动画
- (void)stopAnimating
{
    [self.imageView stopAnimating];
}






@end
