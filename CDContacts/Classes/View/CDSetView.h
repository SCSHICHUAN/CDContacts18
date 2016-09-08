//
//  CDSetView.h
//  CDContacts
//
//  Created by 蓝科 on 16/6/7.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDSetView;

@protocol CDSetViewDelegate <NSObject>

-(void)setViewSetButtonClickLetSteControllerShow;
-(void)setViewShouUIScrollViewA;
-(void)setViewShouUIScrollViewB;
-(void)setViewShouUIScrollViewC;
@end



@interface CDSetView : UIView
- (IBAction)buttonA:(UIButton *)sender;
- (IBAction)buttonB:(UIButton *)sender;
- (IBAction)setMore:(UIButton *)sender;
@property(nonatomic,strong)id<CDSetViewDelegate>delegate;


+(CDSetView *)setView;

@end
