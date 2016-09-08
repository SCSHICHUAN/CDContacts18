//
//  SCRecorder.m
//  Recorder
//
//  Created by 蓝科 on 16/5/17.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import "SCRecorder.h"
#import <AVFoundation/AVFoundation.h>

#define kColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]
#define kLightGreenColor [UIColor colorWithRed:83.0/255.0f green:181.0/255.0f blue:70.0/255.0f alpha:1.0f]
#define kLightRedColor [UIColor colorWithRed:239.0/255.0f green:86.0/255.0f blue:70.0/255.0f alpha:1.0f]
#define kDuration 0.25
#define kCount 5


@interface SCRecorder ()
{
    float _power;
    UIView *_view;

}


@property(nonatomic,strong)AVAudioRecorder *audioRecorder;

@property(nonatomic,strong)NSDictionary *recoderSetting;
@property (nonatomic, strong) NSTimer *timer;
//倒计时标签
@property (nonatomic, strong) UILabel *countLabel;
//剩余语音时间
@property (nonatomic, assign) CGFloat lastTime;


@end


@implementation SCRecorder

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

    }
    return self;
}





#pragma mark - 懒加载
- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.bounds.size.width, 80)];
        _countLabel.font = [UIFont boldSystemFontOfSize:80];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.text = [NSString stringWithFormat:@"%d",kCount];
        _countLabel.textColor = kLightGreenColor;
    }
    return _countLabel;
}





-(NSString *)tmpPath
{
    if (_tmpPath == nil) {
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = array.firstObject;
        _tmpPath = [path stringByAppendingPathComponent:@"TempPath"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:_tmpPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        _tmpPath = [_tmpPath stringByAppendingPathComponent:@"tempAudio.m4a"];
    }
    return _tmpPath;
    
}
-(NSDictionary *)recoderSetting
{
        if (_recoderSetting == nil) {
            _recoderSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                               [NSNumber numberWithFloat:22050.0], AVSampleRateKey,
                               [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                               [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                               [NSNumber numberWithInt:AVAudioQualityMin], AVSampleRateConverterAudioQualityKey,
                               [NSNumber numberWithInt:8], AVLinearPCMBitDepthKey,
                               [NSNumber numberWithInt:8],
                               AVEncoderBitDepthHintKey,
                               nil];
        }
        return _recoderSetting;
    }

-(AVAudioRecorder *)audioRecorder
{
    if (_audioRecorder == nil) {
        NSURL *url = [NSURL fileURLWithPath:self.tmpPath];
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:self.recoderSetting error:nil];
       _audioRecorder.meteringEnabled = YES;
    }
    return _audioRecorder;
}

-(void)systemVersion
{
#pragma mark - #warning 7.0以上真机测试需要添加的
    
    //真机测试解决无法录音
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        //7.0第一次运行会提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(session == nil)
            NSLog(@"Error creating session: %@", [sessionError description]);
        else
            [session setActive:YES error:nil];
    }
    
}


-(void)show
{
    if ([self.delegate respondsToSelector:@selector(recderMachineStartWorkLetSaveButtonHide)]) {
        [self.delegate recderMachineStartWorkLetSaveButtonHide];
    }
    
    //开始录音时 剩余的录音时长为30
    self.lastTime = kCount;
    
   
    _view = [[UIView alloc]initWithFrame:CGRectMake(80, 239, 0, 4)];
    _view.backgroundColor = [UIColor greenColor];
    [UIView animateWithDuration:5.0 animations:^{
        _view.frame = CGRectMake(80, 239,(int)self.lastTime*35, 4);
    } completion:nil];
    
    
    
    [self addSubview:_view];
    
    NSLog(@"NSHomeDirectory = %@ ",NSHomeDirectory());
     [self systemVersion];
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
       
    } completion:^(BOOL finished) {
        [self.audioRecorder prepareToRecord];
        [self.audioRecorder record];
        
        //启动定时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(listenAveragePower) userInfo:nil repeats:YES];
        
    }];
    
}




-(void)hden
{
   
    if ([self.delegate respondsToSelector:@selector(recderMachineStopWorkLetSaveButtonShow)]) {
        [self.delegate recderMachineStopWorkLetSaveButtonShow];
    }
    
    _view.frame = CGRectMake(80, 130,0, 20);
    
     self.lastTime = kCount;
     [self.timer invalidate];
    
    
    
    [self.audioRecorder stop];
    //关闭定时器
    [self.timer invalidate];
    
    self.backgroundColor =kColor;
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.backgroundColor = [UIColor clearColor];
                     } completion:^(BOOL finished) {
                        
                         [self removeFromSuperview];
                     }];
    }
    
//}

//监听录音的平均功率
- (void)listenAveragePower
{
    //每次调用减去0.1秒
    self.lastTime -= 0.1;
    //如果剩余描述<=10 则标签显示为红色
    if ((int)self.lastTime<=10) {
        self.countLabel.textColor = kLightRedColor;
    }
    //设置标签显示内容
    self.countLabel.text = [NSString stringWithFormat:@"%d",(int)self.lastTime];
    if ((int)self.lastTime==0) {
        [self hden];
    }

    
    
    [self.audioRecorder updateMeters];
    //获取录音的平均功率
    CGFloat averagePower = [self.audioRecorder averagePowerForChannel:0];
//    NSLog(@"averagePower = %f",averagePower);
   
    if (averagePower<= - 50.543) {
        _power = 0.0;
    } else if ( - 50.543 <averagePower && averagePower<= - 46.686) {
        _power = 0.1;
    } else if ( - 46.686 <averagePower && averagePower<= - 42.829) {
        _power = 0.2;
    } else if ( - 42.829 <averagePower && averagePower<= - 38.982) {
        _power = 0.3;
    } else if ( - 38.982 <averagePower && averagePower<= - 35.135) {
        _power = 0.4;
    } else if ( - 35.135 <averagePower && averagePower<= - 31.288) {
        _power = 0.5;
    } else if ( - 31.288 <averagePower && averagePower<= - 27.441) {
        _power = 0.55;
    } else if ( - 27.441 <averagePower && averagePower<= - 23.594) {
        _power = 0.6;
    } else if ( - 23.594 <averagePower && averagePower<= - 19.747) {
        _power = 0.65;
    } else if ( - 19.747 <averagePower && averagePower<= - 15.900) {
        _power = 0.7;
    } else if ( - 15.900 <averagePower && averagePower<= - 12.053) {
        _power = 0.75;
    } else if ( - 12.053 <averagePower && averagePower<= - 8.206) {
        _power = 0.8;
    } else if ( - 8.206 <averagePower && averagePower<= - 4.359) {
        _power = 0.85;
    } else if ( - 4.359 <averagePower && averagePower<= 0) {
        _power = 0.9;
    } else {
        _power = 1.0;
    }
   

    [self setNeedsDisplay];
    
    
    
}

-(void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(80, 150)];
    [path addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width-80, 150) controlPoint:CGPointMake(160,(-250*_power+150))];
    [[UIColor greenColor] setStroke];
    [path setLineWidth:2];
    [path setLineCapStyle:kCGLineCapRound];
    [path stroke];
    
    [path moveToPoint:CGPointMake(80, 150)];
    [path addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width-80, 150) controlPoint:CGPointMake(160,(-130*_power+150))];
    [[UIColor greenColor] setStroke];
    [path setLineWidth:2];
    [path setLineCapStyle:kCGLineCapRound];
    [path stroke];
    
    
    
    
    [path moveToPoint:CGPointMake(80, 150)];
    [path addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width-80, 150) controlPoint:CGPointMake(160,(130*_power+150))];
    [[UIColor greenColor] setStroke];
    [path setLineWidth:2];
    [path setLineCapStyle:kCGLineCapRound];
    [path stroke];
    
    
    
    [path moveToPoint:CGPointMake(80, 150)];
    [path addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width-80, 150) controlPoint:CGPointMake(160,(250*_power+150))];
    [[UIColor greenColor] setStroke];
    [path setLineWidth:2];
    [path setLineCapStyle:kCGLineCapRound];
    [path stroke];
}






@end
