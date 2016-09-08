//
//  CDSynchronizationTableViewCell.m
//  CDContacts
//
//  Created by 蓝科 on 16/6/14.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDSynchronizationTableViewCell.h"
#import "CDSynchronizationModle.h"

@interface CDSynchronizationTableViewCell ()

{
    UITableView *tableView;
    UITableViewCell *cell;
 
    
}

@property(nonatomic,strong)UILabel *nameLable;

@property(nonatomic,strong)UIVisualEffectView *effectViewA;


@end


@implementation CDSynchronizationTableViewCell

-(UIVisualEffectView *)effectViewA
{
    if (_effectViewA == nil) {
        UIBlurEffect *blurEffect= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectViewA = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    }
    return _effectViewA;
}

+(CDSynchronizationTableViewCell *)synchronizationTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentfier = @"cellIdentfier";
    
    
    
    
    CDSynchronizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CDSynchronizationTableViewCell" owner:nil options:nil].firstObject;
        
        cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    
        cell.layer.shadowColor = [UIColor grayColor].CGColor;
        //阴影浓度
        cell.layer.shadowOpacity = 0.5f;
        //阴影的方向以及大小
        cell.layer.shadowOffset = CGSizeMake(0, 5);
        
        
        cell.nameLable= [[UILabel alloc] initWithFrame:CGRectMake(35, 0,cell.bounds.size.width , 35)];
        cell.nameLable.font = [UIFont systemFontOfSize:16.0];
        
    
        cell.effectViewA.frame = CGRectMake(5, 5, cell.bounds.size.width-10, cell.bounds.size.height-10);
        cell.effectViewA.layer.cornerRadius = 10.0;
        cell.effectViewA.clipsToBounds = YES;
        
        
        
        UIBlurEffect *blurEffect1= [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView1 = [[UIVisualEffectView alloc] initWithEffect:blurEffect1];
        effectView1.frame = CGRectMake(0, 0, cell.bounds.size.width-10, 35);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud_mini"]];
        imageView.frame = CGRectMake(4, 2, 30, 30);
        
        
        [cell.effectViewA addSubview:effectView1];
        
        
        [effectView1 addSubview:cell.nameLable];
        [effectView1 addSubview:imageView];
        
        [cell addSubview:cell.effectViewA];
    }
    return cell;
}


-(void)setSynchronizationModle:(CDSynchronizationModle *)synchronizationModle
{
    _synchronizationModle = synchronizationModle;
    
    [self data];
}

-(void)data
{
    self.nameLable.text = self.synchronizationModle.name;
    [tableView reloadData];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
