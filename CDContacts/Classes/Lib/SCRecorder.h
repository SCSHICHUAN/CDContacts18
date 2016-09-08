//
//  SCRecorder.h
//  Recorder
//
//  Created by 蓝科 on 16/5/17.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCRecorder;
@protocol SCRecorderDelegate <NSObject>


-(void)recderMachineStartWorkLetSaveButtonHide;
-(void)recderMachineStopWorkLetSaveButtonShow;

@end


@interface SCRecorder : UIView
-(instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,strong)NSString *tmpPath;//录音存储路径
@property(nonatomic,weak)id<SCRecorderDelegate>delegate;
-(void)show;
-(void)hden;


@end
