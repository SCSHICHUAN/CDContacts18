//
//  CDFlowLayout.m
//  CDContacts
//
//  Created by 蓝科 on 16/6/10.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDFlowLayout.h"
#define kItemW 80.0
#define KItemH 100.0

@implementation CDFlowLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake(kItemW, KItemH);
    self.collectionView.contentInset = UIEdgeInsetsMake(66, 10, 10, 10);
    
    
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    return array;
}








@end
