//
//  CDRecordView.h
//  CDContacts
//
//  Created by 蓝科 on 16/5/31.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SCRecorder;
@class CDRecordView;
@protocol CDRecordViewDelegate <NSObject>

-(void)recorderMachineStart;
-(void)saveButonClickLetReViewMoveSuperView;

@end

@interface CDRecordView : UIView

+(instancetype)recordViewAndFream:(CGRect)fream;
- (IBAction)playRecordButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButtonOutlet;
@property (weak, nonatomic) IBOutlet UILabel *recordViewReadLable;
@property(nonatomic,weak)id<CDRecordViewDelegate>delegate;
- (IBAction)saveButton:(UIButton *)sender;
@property(nonatomic,strong)UIVisualEffectView *effectView;
@property (weak, nonatomic) IBOutlet UIButton *saveButtonOutlet;
@property (weak, nonatomic) IBOutlet UILabel *saveLable;
@end
