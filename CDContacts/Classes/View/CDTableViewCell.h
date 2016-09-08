//
//  CDTableViewCell.h
//  CDContacts
//
//  Created by 蓝科 on 16/5/26.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDTableViewCell;
@class CDContactsModal;
@class CDTableViewCell;

@protocol CDTableViewCellDelegate <NSObject>

-(void)playButtonClickWithButton:(UIButton *)button;

@end



@interface CDTableViewCell : UITableViewCell

@property (nonatomic, strong)CDContactsModal *contactsModal;
@property (weak, nonatomic) IBOutlet UIButton *playButtonOutlet;
- (IBAction)playButton:(UIButton *)sender;
@property (nonatomic,weak)id<CDTableViewCellDelegate>delegate;
+(CDTableViewCell *)TableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end
