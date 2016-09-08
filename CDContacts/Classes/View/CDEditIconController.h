//
//  CDEditIconController.h
//  CDContacts
//
//  Created by 蓝科 on 16/5/27.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDAddViewController;
@class CDEditIconRenderView;
@class CDEditIconController;

@protocol CDEditIconControllerDelegate <NSObject>
//把编辑好的头像传到CDAddViewController
-(void)creatHeadEditIconController:(CDEditIconController *)conVc andHead:(UIImage *)image;
//掉CDAddViewController里的方法到相册
-(void)albumButtonClick;


@end




@interface CDEditIconController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic,strong)UIImageView *imageViewSurface;
@property (nonatomic,strong)UIView *tailorView;
@property (nonatomic,strong)CDEditIconRenderView *editIconRenderView;
@property (nonatomic,weak)id<CDEditIconControllerDelegate>delegate;


@end
