//
//  CDContactsModal.h
//  CDContacts
//
//  Created by 蓝科 on 16/5/26.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CDContactsModal : NSObject

@property(nonatomic, copy)NSString *name;//姓名
@property(nonatomic, copy)NSString *phoneNumber;//电话号码
@property(nonatomic, strong)UIImage *icon;//联系人图片
@property(nonatomic,strong)UIButton *playButton;
@property(nonatomic,strong)NSNumber* saveVoice;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)contactsModalWithDictionary:(NSDictionary *)dict;




@end
