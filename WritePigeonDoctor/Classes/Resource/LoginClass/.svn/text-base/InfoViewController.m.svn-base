//
//  InfoViewController.m
//  WritePigeonDoctor
//
//  Created by zhongyu on 16/8/3.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "InfoViewController.h"
#import "FELoginTableCell.h"
#import "FEAuthentViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVCaptureDevice.h>
#import "FEUser.h"
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "RWMainTabBarController.h"

@implementation RWHeaderView

- (void)didMoveToWindow
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _imageView.backgroundColor=[UIColor whiteColor];
        _imageView.layer.cornerRadius=(self.bounds.size.height - 30) / 2;
        _imageView.clipsToBounds = YES;
        _imageView.layer.borderWidth = 1.5f;
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _imageView.userInteractionEnabled = YES;
        _imageView.image = _image?_image:[UIImage imageNamed:@"user_image"];
    }
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@(self.bounds.size.height-30));
        make.width.equalTo(@(self.bounds.size.height-30));
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
}

@end

@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource,FETextFiledCellDelegate,FEButtonCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,RWRequsetDelegate>

@property(nonatomic,strong)UIView *backview;
@property(nonatomic,strong)RWRequsetManager * requestManager;
@property(nonatomic,strong)RWUser * user;
@end

static NSString * const textFieldCell=@"textFieldCell";
static NSString *const buttonCell = @"buttonCell";

@implementation InfoViewController

@synthesize facePlaceHolder;



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if (_requestManager && _requestManager.delegate == nil)
    {
        
        _requestManager.delegate = self;
    }

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _requestManager.delegate = nil;
    
    [__MAIN_TABBAR__ searchProceedingOrder];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView * headView=[self createHeaderView:@"①基本信息审核(1)"];
    headView.frame=CGRectMake(0, 0, self.viewList.frame.size.width, self.viewList.frame.size.height/16);
    self.viewList.tableHeaderView=headView;
    [self.viewList addGestureRecognizer:self.tap];
    self.viewList.delegate=self;
    self.viewList.dataSource=self;
    [self createBottomView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return self.viewList.frame.size.height/4.5;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
       RWHeaderView * headerView = [[RWHeaderView alloc] init];
        
        if([FEUser shareDataModle].headerImage)
        {
            headerView.image=[FEUser shareDataModle].headerImage;
        }
//        if (_user.header)
//        {
//            headerView.image = [UIImage imageWithData:_user.header];
//        }

        
        headerView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alterHeadPortrait:)];
        singleTap.numberOfTapsRequired = 1;
        [headerView addGestureRecognizer:singleTap];
        
        return headerView;
    }
    return nil;
}

- (void)obtainRequestManager
{
    
    if (!_requestManager)
    {
        _requestManager = [[RWRequsetManager alloc]init];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.viewList.frame.size.height/7.5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        
//        if (_user.name)
//        {
//            cell.textField.text = _user.name;
//        }
        cell.delegate = self;
        
        [cell.textField addTarget:self action:@selector(nameField) forControlEvents:(UIControlEventEditingChanged)];
        
        cell.placeholder = @"请输入姓名";
        return cell;

    }
   else if (indexPath.section==1) {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];

//        if (_user.age)
//        {
//            cell.textField.text = _user.age;
//        }
        cell.delegate = self;
        cell.placeholder = @"请输入年龄";
        cell.textField.keyboardType=UIKeyboardTypeDecimalPad;
        return cell;
    }
    else if (indexPath.section==2)
    {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        
//        if (_user.gender)
//        {
//            cell.textField.text = _user.gender;
//        }
        cell.delegate = self;
        cell.placeholder = @"请选择性别";
        cell.textField.userInteractionEnabled=NO;
        UIButton * button=[[UIButton alloc]init];
        
                button.backgroundColor=[UIColor clearColor];
                [button addTarget:self action:@selector(chickGender) forControlEvents:(UIControlEventTouchUpInside)];
        
                [cell addSubview:button];

                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(cell);
                    make.size.equalTo(cell);
                }];

        return cell;
        
    }
    
    else if (indexPath.section==3)
    {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];

        cell.delegate = self;
        cell.placeholder = @"请选择职业类型";
        cell.textField.userInteractionEnabled=NO;
        UIButton * button=[[UIButton alloc]init];
        
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(chickOffice) forControlEvents:(UIControlEventTouchUpInside)];
        
        [cell addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.size.equalTo(cell);
        }];
        
        return cell;
        
    }

    
    
    else if(indexPath.section==4)
    {
        FEButtonCell *cell=[tableView dequeueReusableCellWithIdentifier:buttonCell forIndexPath:indexPath];
        cell.delegate=self;
        cell.tag=100000;
        [cell setTitle:@"下一步验证"];
        return cell;
    }
    return nil;
}

-(void)nameField
{
     FETextFiledCell * cell=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if(cell.textField.text.length>13)
    {
        cell.textField.text = [cell.textField.text substringToIndex:14];
    }
}
#pragma mark  所有信息输入完成

-(void)button:(UIButton *)button ClickWithTitle:(NSString *)title{
    
    if (button.tag==99999) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self setinfo];
    }
    
}
//选择性别
-(void)chickGender
{
    FETextFiledCell * cell=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别选择" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        cell.textField.text=@"男";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        cell.textField.text=@"女";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
    
}
//选择工作类型
-(void)chickOffice
{
    FETextFiledCell * cell=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"医生" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        cell.textField.text=@"医生";
        
        
        [FEUser shareDataModle].officeType=OfficeTypeWithDoctor;
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"护士" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        cell.textField.text=@"护士";
        
        [FEUser shareDataModle].officeType=OfficeTypeWithNurse;
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
    
}





-(void)textFiledCell:(FETextFiledCell *)cell DidBeginEditing:(NSString *)placeholder
{
    facePlaceHolder = placeholder;
}

-(void)createBottomView{
    
    UIView * bottomView=[[UIView alloc]init];
    
    bottomView.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:bottomView];
    
    UIButton * bottomButton=[[UIButton alloc]init];
    
    bottomButton.backgroundColor=[UIColor clearColor];
    
    bottomButton.titleLabel.font=[UIFont systemFontOfSize:13];
    
//    [bottomButton setTitleColor:__WPD_MAIN_COLOR__ forState:(UIControlStateNormal)];
    
    [bottomButton setTitle:@"跳过完善信息" forState:(UIControlStateNormal)];
    
    [bottomButton addTarget:self action:@selector(jumpMain) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:bottomButton];
    
    __weak typeof (self) weakself =self;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.left.equalTo(weakself.view.mas_left);
        make.height.equalTo(@(50));
        make.top.equalTo(weakself.viewList.mas_bottom).offset(20);
    }];
    
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(bottomView);
        make.left.equalTo(bottomView.mas_left).offset(40);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-10);
        
    }];
    
    
}
-(void)dismissToRootViewController
{
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:^{
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        RWMainTabBarController *mainTab = (RWMainTabBarController *)keyWindow.rootViewController;
        
        [mainTab toRootViewController];
    }];
}
- (void)jumpMain
{
    [self dismissToRootViewController];
}

#pragma mark alterHeadPortrait

-(void)alterHeadPortrait:(UITapGestureRecognizer *)gesture
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        PickerImage.allowsEditing = YES;
        
        PickerImage.delegate = self;
        
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        AVAuthorizationStatus authStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                if (authStatus==AVAuthorizationStatusDenied||authStatus==AVAuthorizationStatusRestricted) {
                    
                    [RWSettingsManager promptToViewController:self Title:@"应用相机权限受限,请在设置中启用" response:nil];
                }
                else
                {
                UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
                
                PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
                PickerImage.allowsEditing = YES;
                PickerImage.delegate = self;
                [self presentViewController:PickerImage animated:YES completion:nil];\
                }
            }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    
    
    [FEUser shareDataModle].headerImage=newPhoto;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.viewList reloadData];
}

-(void)setinfo
{
    [self obtainRequestManager];
    [self.viewList reloadData];
    
    FETextFiledCell *name=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSString * nameStr=name.textField.text;
    
    [FEUser shareDataModle].name=nameStr;


    FETextFiledCell *age=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    NSString * ageStr=age.textField.text;
    
    [FEUser shareDataModle].age=ageStr;
    
    FETextFiledCell *sex=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    
    NSString * sexStr=sex.textField.text;
    
    [FEUser shareDataModle].sex=sexStr;
    
    if(![_requestManager verificationAge:ageStr])
    {
        [RWSettingsManager promptToViewController:self
                                            Title:@"年龄只能为数字"
                                         response:nil];
        return;
    }
    if ([FEUser shareDataModle].name.length>9) {
        [RWSettingsManager promptToViewController:self Title:@"姓名最多可填9位" response:nil];
    }
    

    if([[FEUser shareDataModle].name isEqualToString:@""]||[[FEUser shareDataModle].age isEqualToString:@""]||[[FEUser shareDataModle].sex isEqualToString:@""]||![FEUser shareDataModle].officeType||![FEUser shareDataModle].headerImage)
    {
        [RWSettingsManager promptToViewController:self
                                                     Title:@"请如实填写所有内容和头像"
                                                  response:nil];
        return;
    }
    
    
    SHOWLOADING;
    
    
    
    __weak typeof(self) weakSelf = self;
    
    
    
    [_requestManager setUserHeader:[FEUser shareDataModle].headerImage name:[FEUser shareDataModle].name age:[FEUser shareDataModle].age sex:[FEUser shareDataModle].sex completion:^(BOOL success, NSString *errorReason) {
        DISSMISS;
        if (success)
        {
            
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            
            RWMainTabBarController *mainTab = (RWMainTabBarController *)keyWindow.rootViewController;
            
            [mainTab verifyStatus];
        }else
        {
            [RWSettingsManager promptToViewController:weakSelf Title:errorReason response:nil];
            
        }
        
        
    }];

    
    
    
}


@end
