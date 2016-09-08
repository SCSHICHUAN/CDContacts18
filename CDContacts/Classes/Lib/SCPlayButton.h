//
//  SCPlayButton.h
//  Recorder
//
//  Created by 蓝科 on 16/5/18.
//  Copyright © 2016年 SHICHUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPlayButton : UIButton

@property (nonatomic, assign) NSTimeInterval duration;

- (void)startAnimating;
- (void)stopAnimating;

@end
