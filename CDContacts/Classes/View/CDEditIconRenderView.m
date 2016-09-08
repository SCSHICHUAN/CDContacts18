//
//  CDEditIconRenderView.m
//  CDContacts
//
//  Created by 蓝科 on 16/5/27.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDEditIconRenderView.h"

@implementation CDEditIconRenderView

-(void)setIconView:(UIView *)iconView
{
    _iconView = iconView;
    
    //开启上下文.裁剪的大小
    UIGraphicsBeginImageContextWithOptions(_iconView.bounds.size, NO, 0.0f);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //渲染控制器的view的图层到上下文
    //图层只能用render（渲染） 不能用draw（画）
    [_iconView.layer renderInContext:ctx];
    
    //获取截屏图片
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();

    
}




//-(void)drawRect:(CGRect)rect
//{

    
    
//}

@end
