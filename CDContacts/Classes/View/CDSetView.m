//
//  CDSetView.m
//  CDContacts
//
//  Created by 蓝科 on 16/6/7.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDSetView.h"







@interface CDSetView ()
@end



@implementation CDSetView


- (IBAction)buttonA:(UIButton *)sender {
    NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(setViewShouUIScrollViewA)]) {
        [self.delegate setViewShouUIScrollViewA];
    }
}

- (IBAction)buttonB:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(setViewShouUIScrollViewB)]) {
        [self.delegate setViewShouUIScrollViewB];
    }
}

- (IBAction)buttonC:(UIButton *)sender {
    NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(setViewShouUIScrollViewC)]) {
        [self.delegate setViewShouUIScrollViewC];
    }
}

- (IBAction)setMore:(UIButton *)sender {
     NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(setViewSetButtonClickLetSteControllerShow)]) {
        [self.delegate setViewSetButtonClickLetSteControllerShow];
    }
}


+(CDSetView *)setView
{
    CDSetView *view = [[NSBundle mainBundle] loadNibNamed:@"CDSetView" owner:nil options:nil].firstObject;
   
    
    
    return view;


}

@end
