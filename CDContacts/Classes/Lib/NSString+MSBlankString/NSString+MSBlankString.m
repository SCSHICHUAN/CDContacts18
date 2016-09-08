//
//  NSString+MSBlankString.m
//  lvpai
//
//  Created by MaShuai on 16/5/14.
//  Copyright © 2016年 司马帅帅. All rights reserved.
//

#import "NSString+MSBlankString.h"

@implementation NSString (MSBlankString)

+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return YES;
    }
    
    return NO;
}

@end
