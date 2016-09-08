//
//  CDSynchronizationModle.h
//  CDContacts
//
//  Created by 蓝科 on 16/6/11.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDSynchronizationModle : NSObject

@property(nonatomic,strong)NSURL *synchronizationUrl;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSDictionary *dictionaryUrl;

+(instancetype)synchronizationWithDictnoary:(NSDictionary *)dict;
-(instancetype)initSynchronizationDictnoary:(NSDictionary *)dict;



@end
