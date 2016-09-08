//
//  CDScrollViewController.h
//  CDContacts
//
//  Created by 蓝科 on 16/6/9.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

typedef enum :NSInteger{
    Type_A,
    Type_B
}CDType;


@interface CDScrollViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *contactsModles;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)CDType collectionViewType;

-(void)collectionAnimationAa;
-(void)collectionAnimationBb;


@end
