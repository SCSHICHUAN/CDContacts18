//
//  CDFlowLayoutOne.m
//  CDContacts
//
//  Created by 蓝科 on 16/6/10.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDFlowLayoutOne.h"
#define kItemW 250
#define kItemH 270
#define kMaring 10

@implementation CDFlowLayoutOne

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width*0.5;
    CGRect visibleFream = self.collectionView.bounds;
    
    NSArray *arry = [self layoutAttributesForElementsInRect:visibleFream];
    CGFloat ajustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attributes in arry) {
        if (ABS(attributes.center.x - centerX)<ABS(ajustOffsetX)) {
            ajustOffsetX = attributes.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + ajustOffsetX, proposedContentOffset.y);
    
}

-(void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake(kItemW, kItemH);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置section的内边距
    CGFloat insetRL = (self.collectionView.bounds.size.width-kItemW)*0.5;
    CGFloat insetTB = (self.collectionView.bounds.size.height-kItemH)*0.5;
    self.sectionInset = UIEdgeInsetsMake(insetTB, insetRL, insetTB, insetRL);
    //最小距离50
    self.minimumLineSpacing = 6;
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //中心点的x
    CGFloat centerX = self.collectionView.contentOffset.x+self.collectionView.bounds.size.width*0.5;
    //可见框的frame
    CGRect visibleFrame = self.collectionView.bounds;
    visibleFrame.origin.x = self.collectionView.contentOffset.x;
    
    for (UICollectionViewLayoutAttributes *attritutes in array) {
        
        //判断item是否为显示的item 如果是正在显示的item才进行缩放
        if (CGRectIntersectsRect(attritutes.frame, visibleFrame)) {
            
            //item的x
            CGFloat itemX = attritutes.center.x;
            CGFloat AB =  [UIScreen mainScreen].bounds.size.width*0.5 - kItemW*0.5;
            CGFloat  ab = 1.1-1.0;
            
            //计算每一个item的缩放比例
            CGFloat scale = -(ab/AB)*(ABS(centerX-itemX))+1.1;
            
            //设置item的attritutes的transform3D进行缩放
            [UIView animateWithDuration:0.2 animations:^{
                attritutes.transform3D = CATransform3DMakeScale(scale, scale, 1);
            }];
            
            
        }
        
    }
    return array;
}










@end
