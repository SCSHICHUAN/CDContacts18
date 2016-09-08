//
//  CDSynchronizationViewController.m
//  CDContacts
//
//  Created by 蓝科 on 16/6/14.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDSynchronizationViewController.h"
#import "CDSynchronizationTableViewCell.h"
#import "CDSynchronizationModle.h"
#import "UIImageView+WebCache.h"

@interface CDSynchronizationViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

{
    CDSynchronizationTableViewCell *cellH;
    int index;
    int index2;
     NSString *_data;
    
}
- (IBAction)cloud:(UIButton *)sender;
@property(nonatomic,strong)UIVisualEffectView *effectView;
@property(nonatomic,strong)UISearchBar *mySearchBar;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *matchingArray;
@property(nonatomic,strong)NSMutableArray *matchingArray0;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation CDSynchronizationViewController

-(UIVisualEffectView *)effectView
{
    if (_effectView == nil) {
        UIBlurEffect *blurEffect= [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _effectView.frame = CGRectMake(10, 74, self.view.bounds.size.width-20, 0);
        _effectView.alpha = 0.0;
    }
    return _effectView;
}
-(UISearchBar *)mySearchBar
{
    if (_mySearchBar ==nil) {
        _mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _mySearchBar.placeholder = @"请输入你丢失的联系人";
        _mySearchBar.delegate = self;
    }
    return _mySearchBar;
}
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewStylePlain;
    
    }
    return _tableView;
}

-(NSMutableArray *)matchingArray
{
    if (_matchingArray == nil) {
        _matchingArray = [NSMutableArray array];
    }
    return _matchingArray;
}

-(NSMutableArray *)matchingArray0
{
    if (_matchingArray0 == nil) {
        _matchingArray0 = [NSMutableArray array];
    }
    return _matchingArray0;
}

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_1240"]];
    }
    return _imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"s = %@ ",self.synchronizationModleArray);
    self.imageView.frame = CGRectMake(0, 0, 0, 0);
    self.tableView.bounds = self.view.bounds;
    index = 1000000000;
    index2 = 1000000000;
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }


- (IBAction)cloud:(UIButton *)sender {
   
    
    [self.view addSubview: self.imageView];
    [self.view addSubview:self.tableView];
    
    self.navigationController.navigationBar.topItem.titleView = self.mySearchBar;

    
    [UIView animateWithDuration:0.3 animations:^{
        self.mySearchBar.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 0);
        self.imageView.frame = [UIScreen mainScreen].bounds;
        [self.mySearchBar becomeFirstResponder];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.effectView.alpha = 1.0;
        } completion:^(BOOL finished) {

            [self.tableView reloadData];
        }];
        
    }];
    
}


#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       
        return self.matchingArray0.count;
   
    }else if(section == 1){
        
       return self.matchingArray.count;

    }
    
    return 0;
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (section == 0 ) {
        
        if (self.matchingArray0.count > 0) {
            return @"最佳匹配";
        }else if(self.matchingArray0 == 0){
            return @"";
        }
        
    }else if(section == 1){
        
        if (self.matchingArray.count > 0) {
            return @"模糊匹配";
        }else if(self.matchingArray == 0){
            return @"";
        }
    
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    //分组显示
    if (indexPath.section == 1) {
        
       CDSynchronizationTableViewCell *cell = [CDSynchronizationTableViewCell synchronizationTableViewCellWithTableView:tableView];
        
        CDSynchronizationModle *modle = self.matchingArray[indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.synchronizationModle = modle;
        cellH = cell;
        return cellH;
        
    }else if(indexPath.section == 0 ){
       
        
        CDSynchronizationTableViewCell *cell = [CDSynchronizationTableViewCell synchronizationTableViewCellWithTableView:tableView];
        CDSynchronizationModle *modle = self.matchingArray0[indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.synchronizationModle = modle;
        
        cellH = cell;
        
        
        return cellH;
           }
    
     return nil;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == index && indexPath.section == index2) {
        ;
        if (indexPath.section == 0) {
            
                
                CDSynchronizationModle *modleName = self.matchingArray0[indexPath.row];
                NSString *name = modleName.name;
                
                NSDictionary *dict = modleName.dictionaryUrl;
                
                
                NSString *urlStr = dict[name];
            NSURL * url = [NSURL URLWithString:urlStr];
            
                NSLog(@"name = %@ ",name);
                NSLog(@"url = %@ ",url);
        
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-92,10, 80,80)];
            imageView.layer.cornerRadius = imageView.bounds.size.width*0.5;
            imageView.clipsToBounds = YES;
            
            imageView.layer.shadowColor = [UIColor grayColor].CGColor;
            //阴影浓度
            imageView.layer.shadowOpacity = 0.5f;
            //阴影的方向以及大小
            imageView.layer.shadowOffset = CGSizeMake(0, 5);
            
           
            
            NSDictionary *dataDict = [self getUrlWithUrl:url];
            
            
            NSURL *url1 = [NSURL URLWithString:dataDict[@"imageUrl"]];
            
            NSLog(@"url1ddddd = %@ ",url1);
            
            //上网下载头像
            [imageView sd_setImageWithURL:url1];
            
            UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, self.view.bounds.size.width, 40)];
            
            //从html，的Str截取出电话号码
            NSString *number = [NSString stringWithFormat:@"电话：%@",dataDict[@"number"]];
            numberLable.text = number;
            
            [cellH addSubview:numberLable];
            [cellH  addSubview:imageView];
    
        }
        
        if (indexPath.section == 1) {
            
                
                CDSynchronizationModle *modleName = self.matchingArray[indexPath.row];
                NSString *name = modleName.name;
                
                NSDictionary *dict = modleName.dictionaryUrl;
                
                
        
            NSString *urlStr = dict[name];
            NSURL * url = [NSURL URLWithString:urlStr];
            
            NSLog(@"name = %@ ",name);
            NSLog(@"url = %@ ",url);
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-92,10, 80,80)];
            imageView.layer.cornerRadius = imageView.bounds.size.width*0.5;
            imageView.clipsToBounds = YES;
            
            imageView.layer.shadowColor = [UIColor grayColor].CGColor;
            //阴影浓度
            imageView.layer.shadowOpacity = 0.5f;
            //阴影的方向以及大小
           imageView.layer.shadowOffset = CGSizeMake(0, 5);
            
            
            
            NSDictionary *dataDict = [self getUrlWithUrl:url];
            
            NSURL *url1 = [NSURL URLWithString:dataDict[@"imageUrl"]];
            
            NSLog(@"url1ddddd = %@ ",url1);
            
            
            [imageView sd_setImageWithURL:url1];
            
            UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, self.view.bounds.size.width, 40)];
            NSString *number = [NSString stringWithFormat:@"电话：%@",dataDict[@"number"]];
            numberLable.text = number;
            
            [cellH addSubview:numberLable];
            [cellH  addSubview:imageView];

            
            
        }

        
        
        
        
        
        
        return 124;
    }else{
        return 100;
    }
 
}




+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section
{
    return 0;
}

-(void)data
{
    
    [self.tableView reloadInputViews];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.mySearchBar resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellH = nil;
    
    index  = (int)indexPath.row;
    index2 = (int)indexPath.section;
    
    CGRect fream = cellH.frame;
    fream.size.height = 100;
    cellH.frame = fream;
    
    
    [self.tableView reloadData];
    
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *repetitionStr0 = @"";
    NSString *repetitionStr = @"";
    
    [self.matchingArray0 removeAllObjects];
    [self.matchingArray removeAllObjects];//当字符串发生变化就请除所有的匹配，重新开始匹配
    [self.tableView reloadData];
    NSLog(@"earchText = %@ ",searchText);
    for (CDSynchronizationModle *modle in self.synchronizationModleArray) {
       
        for (int i = 0; i < modle.name.length; i++) {
            NSString *rangStr = [modle.name substringWithRange:NSMakeRange (i,1)];//关键
            
            //模糊匹配
            if ([searchText containsString:rangStr]&&(modle.name != repetitionStr)) {
                NSLog(@"已经找到匹配的人 = %@ ",modle.name);
                [self.matchingArray addObject:modle];
                
                
                [self.tableView reloadData];
                repetitionStr =  modle.name;//已经匹配过的就不匹配了，防止重复显示
            
            
            }
        }
            
            
        
    }

   for (CDSynchronizationModle *modle in self.synchronizationModleArray) {
       
       //最佳匹配
       if([searchText isEqualToString:modle.name]&&(modle.name != repetitionStr0)){
           
           [self.matchingArray0 addObject:modle];
           [self.tableView reloadData];
           repetitionStr0 =  modle.name;
       }
       
   }
    
    
    if (searchBar.text.length == 0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.frame = CGRectMake(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            [self.imageView removeFromSuperview];
            [self.tableView removeFromSuperview];
        }];
    }else{
        
        [self.view addSubview:self.imageView];
        [self.view addSubview:self.tableView];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.frame = [UIScreen mainScreen].bounds;;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
}

//访问网页源码
-(NSString *)urlString:(NSString *)value{
    NSURL *url = [NSURL URLWithString:value];
    NSData *data = [NSData dataWithContentsOfURL:url];
    //解决中文乱码,用GBK
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    _data = retStr;
    return retStr;
}

/*
 作用:截取从value1到value2之间的字符串
 str:要处理的字符串
 value1:左边匹配字符串
 value2:右边匹配字符串
 */
-(NSString *)str:(NSString *)str value1:(NSString *)value1 value2:(NSString *)value2{
    //i:左边匹配字符串在str中的下标
    int i;
    //j:右边匹配字符串在str1中的下标
    int j;
    //该类可以通过value1匹配字符串 //- (NSRange)rangeOfString:(NSString *)searchString;
    NSRange range1 = [str rangeOfString:value1];
    //判断range1是否匹配到字符串
    if(range1.length>0){
        //把其转换为NSString
        NSString *result1 = NSStringFromRange(range1);
        i = [self indexByValue:result1];
        //原因:加上匹配字符串的长度从而获得正确的下标
        i = i+(int)value1.length;
    }
    //通过下标，删除下标以前的字符
    NSString *str1 = [str substringFromIndex:i];
    NSRange range2 = [str1 rangeOfString:value2];
    if(range2.length>0){
        NSString *result2 = NSStringFromRange(range2);
        j = [self indexByValue:result2];
    }
    NSString *str2 = [str1 substringToIndex:j];
    
    NSLog(@"str2  = %@ ",str2);
    return str2;
}

//过滤获得的匹配信息的下标
-(int)indexByValue:(NSString *)str{
    //使用NSMutableString类，它可以实现追加
    NSMutableString *value = [[NSMutableString alloc] initWithFormat:@""];
    NSString *colum2 = @"";
    int j = 0;
    //遍历出下标值
    for(int i=1;i<[str length];i++){
        NSString *colum1 = [str substringFromIndex:i];
        [value appendString:colum2];
        colum2 = [colum1 substringToIndex:1];
        if([colum2 isEqualToString:@","]){
            j = [value intValue];
            break;
        }
    }
    
    return j;
}

-(NSDictionary *)getUrlWithUrl:(NSURL *)enterurl
{
    
    
    //解决中文乱码,用GBK
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    //上网请求字符串
    NSString *retStr = [NSString stringWithContentsOfURL:enterurl usedEncoding:&enc error:nil];
    
    NSLog(@"retStr = %@ ",retStr);
    
    
    [self str:retStr value1:@"姓名 ：" value2:@"</title>"];
    
    NSString *number =[self str:retStr value1:@"电话号码：" value2:@"</p>"];
    
    
    NSString *imageUrl1 = @"http://st.lpxj.com/images/";
    
    NSString *imageStr = [self str:retStr value1: imageUrl1 value2:@"_1.image"];

    NSString *imageUrl = [NSString stringWithFormat:@"http://st.lpxj.com/images/%@_1.image",imageStr];
    
    
    NSDictionary *dataDict = @{@"number":number,@"imageUrl":imageUrl};
    return dataDict;
}




@end
