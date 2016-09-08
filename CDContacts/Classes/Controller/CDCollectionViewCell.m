//
//  CDCollectionViewCell.m
//  CDContacts
//
//  Created by 蓝科 on 16/6/10.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDCollectionViewCell.h"
#import "CDContactsModal.h"
@interface CDCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headimageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;


@end



@implementation CDCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setContanctModles:(CDContactsModal *)contanctModles
{
    _contanctModles = contanctModles;
    [self loadData];
}

-(void)loadData
{
    self.headimageView.image = self.contanctModles.icon;
    self.nameLable.text = self.contanctModles.name;
    
    
}



@end
