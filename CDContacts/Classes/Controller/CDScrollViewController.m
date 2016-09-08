//
//  CDScrollViewController.m
//  CDContacts
//
//  Created by 蓝科 on 16/6/9.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDScrollViewController.h"
#import "CDCollectionViewCell.h"
#import "CDFlowLayout.h"
#import "CDFlowLayoutOne.h"
#import "CDSetView.h"
#import "CDContactsModal.h"

#define kScreenW self.view.bounds.size.width
#define kScreenH self.view.bounds.size.height

static NSString *cellIdentrer = @"cellIdentrer";

@interface CDScrollViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    CDCollectionViewCell *cell;
    
}
@property (nonatomic,strong)CDFlowLayoutOne *lauoutB;

@end

@implementation CDScrollViewController

-(UICollectionViewLayout *)lauoutB
{
    if (_lauoutB == nil) {
        _lauoutB = [[CDFlowLayoutOne alloc] init];
    }
    return _lauoutB;
}
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds  collectionViewLayout:[[CDFlowLayoutOne alloc] init]];
        _collectionView.frame = [UIScreen mainScreen].bounds;
        
        if (self.collectionViewType == Type_A ) {
            _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[CDFlowLayout alloc] init]];
        }else if(self.collectionViewType == Type_B){
            _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[CDFlowLayoutOne alloc] init]];
        }
        
        
        [_collectionView registerNib:[UINib nibWithNibName:@"CDCollectionViewCell" bundle:nil]    forCellWithReuseIdentifier:cellIdentrer];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  - collection 布局动画

-(void)collectionAnimationAa
{
    [self.collectionView setCollectionViewLayout:[[CDFlowLayout alloc] init] animated:YES completion:nil];
    
}

-(void)collectionAnimationBb
{
    [self.collectionView setCollectionViewLayout:self.lauoutB animated:YES completion:nil];
    
    
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contactsModles.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentrer forIndexPath:indexPath];
    
    cell.contanctModles = self.contactsModles[indexPath.item];
    return cell;
    
  
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"%s",__func__);
    
   
    
    
    
    if (cell.frame.size.width > 200.0) {
        
        CDContactsModal *modle = self.contactsModles[indexPath.item];
        
        //选中cell的动画
        
        UIBlurEffect *blurEffect1= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        UIVisualEffectView  *callView = [[UIVisualEffectView alloc] initWithEffect:blurEffect1];
        callView.frame = [UIScreen mainScreen].bounds;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 240, 240)];
        imageView.center = self.view.center;
        imageView.image = modle.icon;
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 120, self.view.bounds.size.width, 30)];
        nameLable.font = [UIFont systemFontOfSize:20];
        nameLable.textAlignment =  NSTextAlignmentCenter;
      
        NSString *name = [NSString stringWithFormat:@"%@",modle.name];
        nameLable.text = name;
        
        UILabel *nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0,120, self.view.bounds.size.width, 30)];
        nameLable1.font = [UIFont systemFontOfSize:20];
        nameLable1.textAlignment =  NSTextAlignmentCenter;
        
        nameLable1.text = @"正在呼叫...";
        nameLable1.textColor = [UIColor redColor];
        
        UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 66, self.view.bounds.size.width, 30)];
        numberLable.textAlignment =  NSTextAlignmentCenter;
        NSString *number = [NSString stringWithFormat:@"%@",modle.phoneNumber];
        numberLable.font = [UIFont systemFontOfSize:32];
        numberLable.text = number;
        
        UIBlurEffect *blurEffect2= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        UIVisualEffectView  *callView2 = [[UIVisualEffectView alloc] initWithEffect:blurEffect2];
        callView2.frame = [UIScreen mainScreen].bounds;
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        
        [window addSubview:callView2];
        
        
        [callView addSubview:imageView];
        
        
        [window addSubview:callView];
        [window addSubview:nameLable];
        [window addSubview:nameLable1];
        [window addSubview:numberLable];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            callView.frame = CGRectMake(0, 10, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                callView.frame = CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.1 animations:^{
                    callView.frame = CGRectMake(0,  10, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        callView.frame = CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            callView.frame = CGRectMake(0, 10, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.1 animations:^{
                                callView.frame = CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.1 animations:^{
                                    callView.frame = CGRectMake(0, 10, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                                } completion:^(BOOL finished) {
                                    
                                    [nameLable removeFromSuperview];
                                    [numberLable removeFromSuperview];
                                    [nameLable1 removeFromSuperview];
                                    [callView2 removeFromSuperview];
                                    [callView removeFromSuperview];
                                }];
                                
                            }];
                            
                        }];
                        
                    }];
                }];
                
            }];
            
        }];

        
        //打电话
        
        NSString *urlString = [NSString stringWithFormat:@"tel:%@",modle.phoneNumber];
        NSURL *url = [NSURL URLWithString:urlString];
        NSLog(@"ffffffffTTFFFFFGHGHHGHGHGHHGHG%s",__func__);
        //不弹出提示框 直接拨打电话
        [[UIApplication sharedApplication] openURL:url];
        UIWebView *webView = [[UIWebView alloc] init];
        [self.view addSubview:webView];

    }
    
    [self collectionAnimationBb];
    [self.collectionView reloadInputViews];
    
}



#pragma mark - UICollectionViewDelegate
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(80, 100);
//}
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
