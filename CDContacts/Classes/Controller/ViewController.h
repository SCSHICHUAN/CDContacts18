//
//  ViewController.h
//  CDContacts
//
//  Created by 蓝科 on 16/5/26.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDTableViewCell;
@class CDSetView;
@class CDScrollViewController;
@interface ViewController : UIViewController

@property (nonatomic, strong)NSMutableArray *contactsArray;
@property(nonatomic,strong)CDTableViewCell *cell;
@property(nonatomic,strong)CDSetView *setView;
- (IBAction)setViewShowButton:(UIBarButtonItem *)sender;
@end

