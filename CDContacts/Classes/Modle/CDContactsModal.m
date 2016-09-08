//
//  CDContactsModal.m
//  CDContacts
//
//  Created by 蓝科 on 16/5/26.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDContactsModal.h"

@implementation CDContactsModal

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)contactsModalWithDictionary:(NSDictionary *)dict
{
    return [[CDContactsModal alloc] initWithDictionary:dict];
    
}

//编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"NameKey"];
    [aCoder encodeObject:self.phoneNumber forKey:@"NumberKey"];
    [aCoder encodeObject:self.icon forKey:@"IconKey"];
    [aCoder encodeObject:self.playButton forKey:@"playButton"];
}

//解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"NameKey"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"NumberKey"];
        self.icon = [aDecoder decodeObjectForKey:@"IconKey"];
        self.playButton = [aDecoder decodeObjectForKey:@"playButton"];
    }
    return self;
}



@end
