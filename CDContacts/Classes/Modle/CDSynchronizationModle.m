//
//  CDSynchronizationModle.m
//  CDContacts
//
//  Created by 蓝科 on 16/6/11.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDSynchronizationModle.h"

@interface CDSynchronizationModle ()<NSCoding>

@end

@implementation CDSynchronizationModle

-(instancetype)initSynchronizationDictnoary:(NSDictionary *)dict;{
    
    self = [super init];
    
    if (self) {
        self.synchronizationUrl = dict[@"synchronizationUrl"];
        self.name = dict[@"name"];
        self.dictionaryUrl = dict[@"dictionaryUrl"];
        
    }
    return self;
}

+(instancetype)synchronizationWithDictnoary:(NSDictionary *)dict
{
    return [[CDSynchronizationModle alloc] initSynchronizationDictnoary:dict];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.synchronizationUrl forKey:@"synchronizationUrl"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.dictionaryUrl forKey:@"dictionaryUrl"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.synchronizationUrl = [aDecoder decodeObjectForKey:@"synchronizationUrl"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.dictionaryUrl = [aDecoder decodeObjectForKey:@"dictionaryUrl"];
    }
    return self;
}











@end
