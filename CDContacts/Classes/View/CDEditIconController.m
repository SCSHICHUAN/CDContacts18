//
//  CDEditIconController.m
//  CDContacts
//
//  Created by 蓝科 on 16/5/27.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDEditIconController.h"
#import "CDAddViewController.h"
#import "CDEditIconRenderView.h"
@interface CDEditIconController ()<UIGestureRecognizerDelegate>
- (IBAction)creatHeadButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonOutlet;
@property (weak, nonatomic) IBOutlet UILabel *headLable;
- (IBAction)albumButton;
@property (weak, nonatomic) IBOutlet UIButton *albumOutlet;
@property (weak, nonatomic) IBOutlet UILabel *albumLableOutlet;




@end

@implementation CDEditIconController
-(UIImageView *)imageViewSurface
{
    if (!_imageViewSurface) {
        _imageViewSurface = [[UIImageView alloc] initWithFrame:self.tailorView.bounds];
           _imageViewSurface.userInteractionEnabled = YES;
        
//        _imageViewSurface.backgroundColor = [ UIColor greenColor];
        
        _imageViewSurface.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageViewSurface;
}
-(UIView *)tailorView
{
    if (!_tailorView) {
       
        _tailorView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5-125,[UIScreen mainScreen].bounds.size.height*0.5-125, 250, 250)];
//        _tailorView.center = self.view.center;
//        CGFloat a = self.imageViewSurface.center.x;
//        CGFloat b = self.imageViewSurface.center.y;
//        
//        _tailorView.center= CGPointMake(a, b);
        _tailorView.clipsToBounds = YES;
        _tailorView.backgroundColor = [UIColor clearColor];
    
        _tailorView.layer.cornerRadius = _tailorView.bounds.size.width*0.5;
    }
    return _tailorView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    //毛玻璃效果的Style
    UIBlurEffect *blurEffect= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //初始化一个毛玻璃
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    effectView.frame = [UIScreen mainScreen].bounds;
    
    self.imageView.image = self.image;
    self.imageViewSurface.image = self.image;
//    self.imageViewSurface.backgroundColor = [UIColor greenColor];
    
    
    [self.view addSubview:effectView];
    [effectView addSubview:self.tailorView];
    [self.tailorView addSubview:self.imageViewSurface];
    
    
    
    //创建捏合手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinchGesture.delegate = self;
    [self.imageViewSurface addGestureRecognizer:pinchGesture];
    

    
    //创建旋转手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotationGesture.delegate = self;
    [self.imageViewSurface addGestureRecognizer:rotationGesture];


    //创建拖拽手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    panGesture.delegate = self;
    [self.imageViewSurface addGestureRecognizer:panGesture];

    [effectView addSubview:self.buttonOutlet];
    [effectView addSubview:self.headLable];
    [effectView addSubview:self.albumOutlet];
    [effectView addSubview:self.albumLableOutlet];

}


    


- (void)pinch:(UIPinchGestureRecognizer*)pinchGesture
{
    self.imageViewSurface.transform = CGAffineTransformScale(self.imageViewSurface.transform, pinchGesture.scale, pinchGesture.scale);
    
    //复位
    pinchGesture.scale = 1.0f;
}

- (void)rotation:(UIRotationGestureRecognizer *)rotationGesture
{
    self.imageViewSurface.transform = CGAffineTransformRotate(self.imageViewSurface.transform, rotationGesture.rotation);
    //复位
    rotationGesture.rotation = 0.0f;
}

- (void)pan:(UIPanGestureRecognizer *)panGesture
{
    CGPoint point = [panGesture translationInView:self.imageViewSurface];
    self.imageViewSurface.transform = CGAffineTransformTranslate(self.imageViewSurface.transform, point.x, point.y);
    //复位
    [panGesture setTranslation:CGPointZero inView:self.imageViewSurface];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//生成头像
- (IBAction)creatHeadButton:(UIButton *)sender {
    
    CDEditIconRenderView *editIconRenderView = [[CDEditIconRenderView alloc] init];
    editIconRenderView.iconView = self.tailorView;

    
//    UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 140, 140)];
//    head.image = editIconRenderView.image;
//    head.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:head];
    
    self.image = editIconRenderView.image;
    
    if ([self.delegate respondsToSelector:@selector(creatHeadEditIconController:andHead:)]) {
        [self.delegate creatHeadEditIconController:self andHead:self.image];
    }
    

    [self.navigationController popViewControllerAnimated:YES];
    
}



- (IBAction)albumButton {
    if ([self.delegate respondsToSelector:@selector(albumButtonClick)]) {
        [self.delegate albumButtonClick];
    }
}












@end
