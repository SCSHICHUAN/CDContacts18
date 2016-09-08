//
//  CDAddViewController.m
//  CDContacts
//
//  Created by 蓝科 on 16/5/26.
//  Copyright © 2016年 CDCONTANS. All rights reserved.
//

#import "CDAddViewController.h"
#import "YDAuthorTool.h"
#import "CDContactsModal.h"
#import "CDEditIconController.h"
#import "CDEditIconRenderView.h"
#import "CDRecordView.h"
#import "SCRecorder.h"
#import "NSString+MSBlankString.h"
#import "ViewController.h"
#import "CDTableViewCell.h"
#import "AFNetworking.h"
#import "CDSynchronizationModle.h"
#import "CDSynchronizationViewController.h"

#define kSynchronizationPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"synchronization.data"]

@interface CDAddViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,CDEditIconControllerDelegate,CDRecordViewDelegate,SCRecorderDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    CDEditIconController * _editIcon;
    NSData *_voiceData;
    NSNumber *_save;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scroliView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

- (IBAction)recordButton;
@property(nonatomic,strong)SCRecorder *recorderMachine;
- (IBAction)synchronization:(UISegmentedControl *)sender;

@property(nonatomic,strong)CDRecordView *recView;
@property (weak, nonatomic) IBOutlet UIButton *redordButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *addButtonOutlet;

@property (weak, nonatomic) IBOutlet UIImageView *heardImageView;
@property (weak, nonatomic) IBOutlet UITextField *peopleName;
@property (weak, nonatomic) IBOutlet UITextField *tellPhoneNumber;

@property(nonatomic,strong)NSMutableArray *synchronizationModleArry;

@end

@implementation CDAddViewController

#pragma  mark - 懒🏠载

-(CDRecordView *)recView
{
    if (!_recView) {
        _recView = [CDRecordView recordViewAndFream:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*0.43)];
        _recView.delegate = self;
    }
    return _recView;
}

-(SCRecorder *)recorderMachine
{
    if (!_recorderMachine) {
        _recorderMachine = [[SCRecorder alloc] initWithFrame:self.recView.frame];
        _recorderMachine.backgroundColor = [UIColor clearColor];
        _recorderMachine.delegate = self;
        
    }
    return _recorderMachine;
}

-(NSMutableArray *)synchronizationModleArry
{
    if (_synchronizationModleArry == nil) {
        
        _synchronizationModleArry = [NSKeyedUnarchiver unarchiveObjectWithFile:kSynchronizationPath];
       
        if (_synchronizationModleArry == nil) {
             _synchronizationModleArry = [NSMutableArray array];
        }
       
    }
    return _synchronizationModleArry;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scroliView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+240);
    self.scroliView.contentInset =UIEdgeInsetsMake(-64, 0, 0, 0);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    
    self.imageView.layer.cornerRadius = self.imageView.bounds.size.width*0.5;
    _save = [NSNumber numberWithInt:1];
  [self.imageView addGestureRecognizer:tapGesture];
   

    
    
    
}

-(void)tap
{
    NSLog(@"%s",__func__);
    [YDAuthorTool authorToolAccessLibrarySuccess:^{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    } fail:^{
        NSLog(@"失败");
        //        [self showAlertWithTypeName:@"相册"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(long )recoderName
{
   
    NSDate  *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
    NSString *dateStr = [formatter stringFromDate:date];
    NSArray *dateArry = [dateStr componentsSeparatedByString:@"-"];
    

    
    long  year  = [[dateArry[0] substringWithRange:NSMakeRange(0, 4)] intValue];
    long month   = [dateArry[1] floatValue];
    long day     = [dateArry[2] floatValue];
    long hour    = [dateArry[3] floatValue];
    long minute  = [dateArry[4] floatValue];
    long second  = [dateArry[5] floatValue];
    
    
    
    
     // 2016 06 19 11 52 52
    
    long recoderName = year*10000000000 + month*100000000+ day*1000000 + hour*10000 +minute*100 + second;

    
    
    return  recoderName;
    
}

- (IBAction)AddBtnClick:(UIButton *)sender {
    
    
    
    
    //把录制好的录音写入新的路径
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *writePath = array.firstObject;
    writePath = [writePath stringByAppendingPathComponent:@"TempPath1"];
    
    NSLog(@"writePath = %@ ",writePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:writePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:writePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    long  recoderName = [self recoderName] ;
    NSLog(@"recoderName = %lu ",recoderName);
    
    //写入数据
    writePath = [writePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu.m4a",recoderName]];
    [_voiceData writeToFile:writePath atomically:YES];
    
    NSLog(@"NSHomeDirectory = %@ ",NSHomeDirectory());
    NSLog(@"将要生成的Button = %ld ",recoderName);

    NSLog(@"_voiceData = %@ ",_voiceData);
    //生成button保存入model（保存的是tag就可以区别button了）
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (_voiceData) {
        playButton.tag = recoderName;
    }
    
    
    
    
    
   //封装ContactModal对象 将添加的信息转化为字典封装成ContactModal对象
    NSDictionary *dict = @{@"icon":self.imageView.image,
                           @"name":self.nameField.text,
                           @"phoneNumber":self.phoneNumberField.text,
                           @"playButton":playButton,
                           @"saveVoice":_save};
    
    CDContactsModal *contactsModal = [CDContactsModal contactsModalWithDictionary:dict];
    
    
    
    //通过代理将添加的信息反传到联系人列表
    if ([self.delegate respondsToSelector:@selector(addContactsController:didAddContacts:)]) {
        [self.delegate addContactsController:self didAddContacts:contactsModal];
    }
    
    //返回联系人列表
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)recordButton {
    
   
    [UIView animateWithDuration:0.25 animations:^{
       ;
        [self.view addSubview:self.recView];
        
        
        //判断联系的姓名是否为空
        if ([NSString isBlankString:self.nameField.text] ) {
         self.recView.recordViewReadLable.text = @"请读出联系人名字。";
        }else{//提示用户读出名字
            self.recView.recordViewReadLable.text = [NSString stringWithFormat:@"请读出 “%@” 。",self.nameField.text];
        }
    } completion:^(BOOL finished) {
        
       
    }];
}
#pragma mark-CDRecordViewDelegate
-(void)recorderMachineStart
{
    NSLog(@"%s",__func__);
    //判断联系的姓名是否为空
    if ([NSString isBlankString:self.nameField.text] ) {
        self.recView.recordViewReadLable.text = @"请读出联系人名字。";
    }else{//提示用户读出名字
        self.recView.recordViewReadLable.text = [NSString stringWithFormat:@"请读出 “%@” 。",self.nameField.text];
    }
    
      [self.recView addSubview:self.recorderMachine];
      [self.recorderMachine show];
}

-(void)saveButonClickLetReViewMoveSuperView
{
    _save = [NSNumber numberWithInt:0];//让playButton显示
    
    [self.recView removeFromSuperview];
    
    //获取用户录制好的录音
    if (self.recorderMachine.tmpPath) {
        NSString *path = self.recorderMachine.tmpPath;
        _voiceData = [NSData dataWithContentsOfFile:path];
        self.redordButtonOutlet.tag = self.count+1;
    }
    
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //拿到相册图片
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    NSLog(@"image%@",image);
    
    

    
    //传值给CDEditIconController 进行编辑
    _editIcon = [[CDEditIconController alloc] init];
    _editIcon.image = image;
    _editIcon.delegate = self;

    
    
    [self.navigationController pushViewController:_editIcon animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - CDEditIconControllerDelegate
-(void)creatHeadEditIconController:(CDEditIconController *)conVc andHead:(UIImage *)image
{
    NSLog(@"%s",__func__);
    
    //给增加叶到imageView赋值
    self.imageView.image = image;
    
}

-(void)albumButtonClick
{
    
    [self tap];
    [_editIcon.navigationController popViewControllerAnimated:YES];
   
}

#pragma mark-SCRecorderDelegate
-(void)recderMachineStopWorkLetSaveButtonShow
{
    NSLog(@"%s",__func__);
  [self.recView.effectView addSubview:self.recView.saveButtonOutlet];
    [self.recView.effectView addSubview:self.recView.saveLable];
    self.recView.saveButtonOutlet.hidden = NO;
    self.recView.saveLable.hidden = NO;
}
-(void)recderMachineStartWorkLetSaveButtonHide
{
    NSLog(@"%s",__func__);
    self.recView.saveButtonOutlet.hidden = YES;
    self.recView.saveLable.hidden = YES;
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   
    [self.recView removeFromSuperview];
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSLog(@"string = %@ ",string);
//    
//    if (self.phoneNumberField.text.length > 1) {
//        self.addButtonOutlet.enabled = YES;
//    }else{
//        self.addButtonOutlet.enabled = NO;
//    }
    return YES;
}
- (IBAction)synchronization:(UISegmentedControl *)sender {

   NSLog(@"%s %ld",__func__,(long)sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex == 0) {
        sender.selectedSegmentIndex = 0;
        
      NSString *name = [NSString stringWithFormat:@"姓名 ：%@",self.nameField.text];
      if (name.length>0) {
        //1.获取接口和参数字典
        NSString *urlString = @"http://www.lpxj.com/api.php?op=share_uploadPhotos";
        //图片数量
        NSString *imageCount = @"1";
        
        NSDictionary *parameters = @{@"platform":@"ios",
                                     @"pageCount":imageCount,
                                     @"userId":@"6794",
                                     @"title":name};
        
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
        
        UIImage *image = self.heardImageView.image;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
        
       [formData appendPartWithFileData:imageData name:@"image1" fileName:@"image" mimeType:@"image/jpg"];
        
        NSString *numberStr = [NSString stringWithFormat:@"电话号码：%@",self.tellPhoneNumber.text];
       
        NSData *numberData = [numberStr dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:numberData name:@"text1"];
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"responseObject = %@ ",responseObject[@"url"]);
        
        
        CDSynchronizationModle *modle = [CDSynchronizationModle synchronizationWithDictnoary:
    
     @{@"synchronizationUrl":responseObject[@"url"],
                     @"name":self.nameField.text,
            @"dictionaryUrl":@{[NSString stringWithFormat:@"%@",self.nameField.text]:responseObject[@"url"]}}];
        
        [self.synchronizationModleArry addObject:modle];
        [NSKeyedArchiver archiveRootObject:self.synchronizationModleArry toFile:kSynchronizationPath];
        
        NSLog(@"s = %@ ",self.synchronizationModleArry);
        
        sender.selectedSegmentIndex = 1;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@ ",error);
    }];
    
    
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            
            //设置上传进度
            
            
            NSLog(@"totalBytesWritten = %lld ",totalBytesWritten);
            
        }];
    
    }
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CDSynchronizationViewController *syVC = segue.destinationViewController;
    syVC.synchronizationModleArray = self.synchronizationModleArry;
}






@end
