//
//  CDSynchronizationTableViewCell.h
//  CDContacts
//
//  Created by 蓝科 on 16/6/14.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDSynchronizationModle;


@interface CDSynchronizationTableViewCell : UITableViewCell

+(CDSynchronizationTableViewCell *)synchronizationTableViewCellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)CDSynchronizationModle *synchronizationModle;

@end
