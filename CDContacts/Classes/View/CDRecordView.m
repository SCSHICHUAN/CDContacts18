//
//  CDRecordView.m
//  CDContacts
//
//  Created by 蓝科 on 16/5/31.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDRecordView.h"
#import <AVFoundation/AVFoundation.h>
#import "SCRecorder.h"
@interface CDRecordView ()

{
     AVAudioPlayer *_player;//语音播放器
}
@property (weak, nonatomic) IBOutlet UILabel *recViewLable;
@property (weak, nonatomic) IBOutlet UIButton *recordButtonStarOutlet;
- (IBAction)recordButtonStar:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *recordButtonStarLable;



@end


@implementation CDRecordView

-(void)awakeFromNib
{
    self.saveButtonOutlet.hidden = YES;
    self.saveLable.hidden = YES;
}

+(instancetype)recordViewAndFream:(CGRect)fream
{
    CDRecordView *reView = [[NSBundle mainBundle] loadNibNamed:@"CDRecordView" owner:nil options:nil].firstObject;
    reView.frame = fream;
    
    UIBlurEffect *blurEffect= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    reView.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
 
    
    reView.effectView.frame = reView.frame;
    reView.backgroundColor = [UIColor clearColor];
    
    [reView addSubview:reView.effectView];
    [reView.effectView addSubview:reView.recViewLable];
    [reView.effectView addSubview:reView.playButtonOutlet];
    [reView.effectView addSubview:reView.recordButtonStarOutlet];
    [reView.effectView addSubview:reView.recordButtonStarLable];
    [reView.effectView addSubview:reView.recordViewReadLable];
    
    

    return reView;
}

- (IBAction)playRecordButton:(id)sender {
   
    SCRecorder *recorderpath = [[SCRecorder alloc] init];
    
   
    
    NSString *path = recorderpath.tmpPath;
    NSURL *url = [NSURL fileURLWithPath:path];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player prepareToPlay];
    [_player play];
 NSLog(@"url = %@ ",path);
}

- (IBAction)recordButtonStar:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(recorderMachineStart)]) {
        [self.delegate recorderMachineStart];
    }
    
}

- (IBAction)saveButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(saveButonClickLetReViewMoveSuperView)]) {
        [self.delegate saveButonClickLetReViewMoveSuperView];
    }
}






@end
