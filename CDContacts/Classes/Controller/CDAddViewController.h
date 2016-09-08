//
//  CDAddViewController.h
//  CDContacts
//
//  Created by 蓝科 on 16/5/26.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "ViewController.h"
@class CDAddViewController,CDContactsModal,CDTableViewCell;

@protocol CDAddViewControllerDelegate <NSObject>

@optional;

-(void)addContactsController:(CDAddViewController *)addVc didAddContacts:(CDContactsModal *)contactsModal;




@end


@interface CDAddViewController : ViewController
@property (nonatomic, weak)id<CDAddViewControllerDelegate> delegate;
@property (nonatomic,assign) int count;
@property (nonatomic,strong)CDTableViewCell *tableViewCell;
@end
