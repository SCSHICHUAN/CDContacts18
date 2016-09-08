//
//  CDTableViewCell.m
//  CDContacts
//
//  Created by 蓝科 on 16/5/26.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDTableViewCell.h"
#import "CDContactsModal.h"
@interface CDTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIView *afsasdfasdfasdfasdfView;


@end

@implementation CDTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (IBAction)playButton:(UIButton *)sender {
        
    NSLog(@"UIButtonTag = %ld ",sender.tag);
    
    if ([self.delegate respondsToSelector:@selector(playButtonClickWithButton:)]) {
        [self.delegate playButtonClickWithButton:self.playButtonOutlet];
    }
    
    
}

+(CDTableViewCell *)TableView:(UITableView *)tableView
{
    static NSString *cellIdentfille = @"cellIdentfille";
    CDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfille];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CDTableViewCell" owner:nil options:nil].firstObject;
        
    }
    
    return cell;
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CDTableViewCell" owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

//重写contactsModal的setter方法
-(void)setContactsModal:(CDContactsModal *)contactsModal
{
    _contactsModal = contactsModal;
    
    self.nameLabel.text = self.contactsModal.name;
    self.iconImageView.image = self.contactsModal.icon;
   
    
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width*0.5;
    self.playButtonOutlet.tag = self.contactsModal.playButton.tag;
    
    //如果没有声音 隐藏播放按钮
    if (self.playButtonOutlet.tag ==0) {
    
        self.playButtonOutlet.hidden = YES;
    }
    
    
    self.iconImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
