//
//  YDAuthorTool.h
//  相册和相机
//
//  Created by 蓝科 on 16/4/21.
//  Copyright © 2016年 符玉达. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockType)();

@interface YDAuthorTool : NSObject


+(void)authorToolAccessCrameSuccess:(BlockType)successBlock fail:(BlockType)failBlock;


+(void)authorToolAccessLibrarySuccess:(BlockType)successBlock fail:(BlockType)failBlock;

@end
