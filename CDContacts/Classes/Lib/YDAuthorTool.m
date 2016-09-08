//
//  YDAuthorTool.m
//  相册和相机
//
//  Created by 蓝科 on 16/4/21.
//  Copyright © 2016年 符玉达. All rights reserved.
//

#import "YDAuthorTool.h"
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation YDAuthorTool


+(void)authorToolAccessCrameSuccess:(BlockType)successBlock fail:(BlockType)failBlock
{
  
    //判断设备有没有相册功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //判断相机权限是否打开
        //获取相机的权限状态
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (status==AVAuthorizationStatusDenied||status == AVAuthorizationStatusRestricted) {
            //执行失败的Block
            successBlock();
        }else{
            //执行成功的Block
            failBlock();
        }
        
    }else{
        
        NSLog(@"你的设备没有相机功能！");
    }
    
}

+(void)authorToolAccessLibrarySuccess:(BlockType)successBlock fail:(BlockType)failBlock
{
    //判断设备有没有相册功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        //如果系统版本>=8.0
        if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
            //获取资源库权限  获取系统版本8.0以上相册的权限状态
            PHAuthorizationStatus autoStatus = [PHPhotoLibrary authorizationStatus];
            //如果状态为禁止 或 拒绝 代表相册不可用 提示用户打开权限
            if (autoStatus ==PHAuthorizationStatusDenied||autoStatus == PHAuthorizationStatusRestricted) {
                //失败
                failBlock();
            }else{
                //成功
                successBlock();
            }
            
        }else{
            //获取系统版本4.0-9.0相册的权限状态
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            if (status==ALAuthorizationStatusDenied||
                status==ALAuthorizationStatusRestricted) {
                //执行失败的block
                failBlock();
            } else {
                //执行成功的block
                successBlock();
            }
        }
    }else{
        NSLog(@"你的设备没有相册!");
        
    }

    
    
}
@end
