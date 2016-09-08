//
//  ViewController.m
//  CDContacts
//
//  Created by 蓝科 on 16/5/26.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "ViewController.h"
#import "CDContactsModal.h"
#import "CDTableViewCell.h"
#import "CDAddViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CDSetController.h"
#import "CDSetView.h"
#import "CDScrollViewController.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,CDAddViewControllerDelegate,CDTableViewCellDelegate,CDSetViewDelegate>
{
    AVAudioPlayer *_player;//语音播放器
    int _maxArryCount;
    NSIndexPath *_indexPath;
    CDScrollViewController *_scrollViewController1;
    CDScrollViewController *scrollViewController;
    CGFloat _cellY;
    CGFloat _contentOffsetY;
    
}
@property (nonatomic, strong)CDTableViewCell *contactsCell;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConstraint;
@property (nonatomic,assign)CDType type;



@end

@implementation ViewController

- (IBAction)addPeoplesButton:(UIBarButtonItem *)sender {
    self.setView.frame = CGRectMake(0, -37, [UIScreen mainScreen].bounds.size.width, 101);
   NSLog(@"%s",__func__);
    
}

- (IBAction)setViewShowButton:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        NSLog(@"%s",__func__);
        if (self.setView.frame.origin.y == -37) {
            self.setView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 101);
        }else if(self.setView.frame.origin.y == 64){
            self.setView.frame = CGRectMake(0, -37, [UIScreen mainScreen].bounds.size.width, 101);
        }
    } completion:nil];
    
    
}

#pragma mark - 懒加载方法

-(CDSetView *)setView
{
    if (_setView == nil) {
        _setView = [CDSetView setView];
        _setView.frame = CGRectMake(0, -37, [UIScreen mainScreen].bounds.size.width, 101);
        _setView.delegate = self;
        
    }
    return _setView;
}

-(CDTableViewCell *)contactsCell
{
    if (_contactsCell == nil) {
        _contactsCell = [[CDTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 404, 139)];
    }
    return _contactsCell;
   
}

-(NSMutableArray *)contactsArray
{
    if (!_contactsArray) {
        _contactsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"contacts.data"]];
        
        if (!_contactsArray) {
            _contactsArray = [NSMutableArray array];
            
        }
    }
    return _contactsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.setView];
}


//执行segue的时候，跳转之前调用 一般用作跳转之前的准备工作，给下一个控制器传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //获取目标控制器AddContactsController  挂代理
    
    if ([segue.identifier isEqualToString:@"toAddController"]) {
        CDAddViewController *addVC = segue.destinationViewController;
        addVC.delegate = self;
        addVC.count = (int)self.contactsArray.count;
    }else if ([segue.identifier isEqualToString:@"toSet"]){
        CDSetController *setController = [[CDSetController alloc] init];
        setController.view.backgroundColor = [UIColor redColor];
    }
    
    
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactsArray.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[[NSString alloc] init] 这样菜会分配新的地址
    
    self.cell = [CDTableViewCell TableView:tableView];
    self.cell.contactsModal = self.contactsArray[indexPath.row];
    self.cell.delegate = self;
    return _cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.contactsCell.frame.size.height;
}



#pragma mark - AddContactsControllerDelegate
-(void)addContactsController:(CDAddViewController *)addVc didAddContacts:(CDContactsModal *)contactsModal
{
    NSLog(@"%s %@",__func__,contactsModal);
    
    //更新数据源
    [self.contactsArray addObject:contactsModal];
    
    //刷新collectionView
    [scrollViewController.collectionView reloadData];
    
    
    //在tableView中插入cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.contactsArray.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    //归档
    [NSKeyedArchiver archiveRootObject:self.contactsArray toFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"contacts.data"]];
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CDTableViewCellDelegate
-(void)playButtonClickWithButton:(UIButton *)button
{

    NSLog(@"button = %lu ",button.tag);

    
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
//    if (/* DISABLES CODE */ (YES)) {
//        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
//    } else {
//        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
//    }
    [audioSession setActive:YES error:nil];

    
    
    NSArray *playPathArry = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *playpath1 = playPathArry.firstObject;
   
    NSString *playPath = [playpath1 stringByAppendingPathComponent:[NSString stringWithFormat:@"TempPath1/%lu.m4a",(long)button.tag]];
    
    
    
    NSURL *url = [NSURL fileURLWithPath:playPath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player prepareToPlay];
    [_player play];
    
}

#pragma mark - #pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    
    //选中cell的动画
    
    CDTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    CDContactsModal *modle1 = self.contactsArray[indexPath.row];
    
    
    _cellY = cell.frame.origin.y;
    _contentOffsetY = self.tableView.contentOffset.y + 70;
    
    UIBlurEffect *blurEffect1= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
     UIVisualEffectView  *callView = [[UIVisualEffectView alloc] initWithEffect:blurEffect1];
    callView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64+34, self.view.bounds.size.width, 66);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 1 , 64, 64)];
    imageView.image = modle1.icon;
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    nameLable.backgroundColor = [UIColor whiteColor];
    nameLable.textAlignment =  NSTextAlignmentCenter;
    nameLable.textColor = [UIColor redColor];
    nameLable.text = @"正在呼叫...";
    
    UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, self.view.bounds.size.width, 30)];

    NSString *number = [NSString stringWithFormat:@"%@:%@",modle1.name,modle1.phoneNumber];
    
    numberLable.text = number;
    
    UIBlurEffect *blurEffect2= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView  *callView2 = [[UIVisualEffectView alloc] initWithEffect:blurEffect2];
    callView2.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64, self.view.bounds.size.width, cell.bounds.size.height);
    
    
    [self.view addSubview:callView2];
    [callView addSubview:nameLable];
    [callView addSubview:numberLable];
    [callView addSubview:imageView];
    
    [self.view addSubview:callView];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        callView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64+34+10, self.view.bounds.size.width, 66);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            callView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64+34, self.view.bounds.size.width, 66);
        } completion:^(BOOL finished) {
        
            [UIView animateWithDuration:0.1 animations:^{
                callView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64+34 +10, self.view.bounds.size.width, 66);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    callView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64+34, self.view.bounds.size.width, 66);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        callView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64+34+10, self.view.bounds.size.width, 66);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            callView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64+34, self.view.bounds.size.width, 66);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.1 animations:^{
                                callView.frame = CGRectMake(0, _cellY-_contentOffsetY +6 +64+34+10, self.view.bounds.size.width, 66);
                            } completion:^(BOOL finished) {
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
    CDContactsModal *modle = self.contactsArray[indexPath.row];
    
    NSString *urlString = [NSString stringWithFormat:@"tel:%@",modle.phoneNumber];
    NSURL *url = [NSURL URLWithString:urlString];
    //不弹出提示框 直接拨打电话
    [[UIApplication sharedApplication] openURL:url];
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    
}
#pragma mark - CDSetViewDelegate
-(void)setViewSetButtonClickLetSteControllerShow
{
    CDSetController *setController = [[CDSetController alloc] init];
    
    [self presentViewController:setController animated:YES completion:^{
        setController.viewController = self;
        
    }];
}


-(void)setViewShouUIScrollViewA
{
    self.type = Type_A;
    [self setViewShouUIScrollView];
    [scrollViewController collectionAnimationAa];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.setView.frame = CGRectMake(0, -37, [UIScreen mainScreen].bounds.size.width, 101);
    }];
    
}

-(void)setViewShouUIScrollViewB
{
    self.type = Type_B;
    
    [self setViewShouUIScrollView];
    [scrollViewController collectionAnimationBb];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.setView.frame = CGRectMake(0, -37, [UIScreen mainScreen].bounds.size.width, 101);
    }];
}


-(void)setViewShouUIScrollView
{

    
   
    if (_scrollViewController1 == nil) {//防止重复添加scrollView
        
        scrollViewController = [[CDScrollViewController alloc] init];
        
            _scrollViewController1 = scrollViewController;
        
        
        scrollViewController.collectionViewType = self.type;//或取是buttonA，还是buttonB
        
        scrollViewController.view.frame = CGRectMake(-self.view.bounds.size.width, 0,self.view.bounds.size.width, self.view.bounds.size.height);
        
        scrollViewController.contactsModles = self.contactsArray;
        
            [self.view addSubview: scrollViewController.view];//关键
        
            [scrollViewController.view addSubview:self.setView];
            [self setViewShowButton:nil];
        
       self.tableViewConstraint.constant = self.view.bounds.size.width;
        
            [UIView animateWithDuration:0.3 animations:^{
                scrollViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                
                [self.view layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                
                
            }];

    }
    
}



-(void)setViewShouUIScrollViewC
{
    
    self.tableViewConstraint.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        scrollViewController.view.frame = CGRectMake(-self.view.bounds.size.width, 0,self.view.bounds.size.width, self.view.bounds.size.height);
         [self setViewShowButton:nil];
         [self.view layoutIfNeeded];//自动布局做动画
        
    } completion:^(BOOL finished) {
        [scrollViewController.view removeFromSuperview];//有添加久有移除；
        _scrollViewController1 = nil;
        [self.view addSubview:self.setView];
        
        NSLog(@"%s11111",__func__);
        
        
        
    }];
    
    
    
}




@end
