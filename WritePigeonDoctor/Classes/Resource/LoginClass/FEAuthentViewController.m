//
//  FEAuthentViewController.m
//  LoginWithDoctor
//
//  Created by zhongyu on 16/8/17.
//  Copyright © 2016年 Fergus. All rights reserved.
//

#import "FEAuthentViewController.h"
#import "UIColor+Wonderful.h"
#import "Masonry.h"
#import "FEImageViewController.h"
#import "FEUser.h"
@interface FEAuthentViewController ()<UITableViewDelegate,UITableViewDataSource,FEButtonCellDelegate,FETextFiledCellDelegate,FETextViewCellDelegate,UIPickerViewDelegate,UIPickerViewDataSource,RWRequsetDelegate>

{
    BOOL isAppellation;
}
@property (strong, nonatomic)RWRequsetManager *requestManager;
@end

static NSString * const textFieldCell=@"textFieldCell";

static NSString *const buttonCell = @"buttonCell";

static NSString *const TextViewCell=@"textViewCell";

@implementation FEAuthentViewController
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
  
    if (_requestManager && _requestManager.delegate == nil)
    {
        _requestManager.delegate = self;
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     _requestManager.delegate = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _requestManager=[[RWRequsetManager alloc]init];
    [self.viewList addGestureRecognizer:self.tap];
    UIView * headView=[self createHeaderView:@"①基本信息审核(2)"];
    headView.frame=CGRectMake(0, 0, self.viewList.frame.size.width, self.viewList.frame.size.height/16);
    self.viewList.delegate=self;
    self.viewList.dataSource=self;
    self.viewList.tableHeaderView=headView;
    isAppellation=YES;
}

-(void)changeViewFrame
{
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.height/20);
        make.top.equalTo(self.view.mas_top).offset(55);
        
    }];
    [self.viewList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(self.view.frame.size.height/20);
        make.top.equalTo(self.view.mas_top).offset(60);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(section==0)
    {
        return self.viewList.frame.size.height/20;
    }
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *backView = [[UIView alloc]init];
        
        backView.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        
        titleLabel.text = @"以下信息仅作为认证使用，不会公开";
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        titleLabel.font = [UIFont systemFontOfSize:13];
        
        titleLabel.textColor = [UIColor gainsboroColor];
        
        [backView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(backView.mas_left).offset(20);
            make.right.equalTo(backView.mas_right).offset(-20);
            make.top.equalTo(backView.mas_top).offset(3);
            make.bottom.equalTo(backView.mas_bottom).offset(-3);
        }];
        
        return backView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==4) {
        return self.viewList.frame.size.height/4.5;
    }
    if (indexPath.section==6||indexPath.section==7) {
        return self.viewList.frame.size.height/9.5;
    }
    return self.viewList.frame.size.height/10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        
        cell.delegate = self;
        
        if ([FEUser shareDataModle].officeType==OfficeTypeWithDoctor) {
            cell.placeholder = @"请输入您所在的医院(必填)";
        }else
        {
            cell.placeholder = @"请输入您工作的地址(必填)";
        }
        
        return cell;
    }
    else if (indexPath.section==1)
    {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        cell.textField.userInteractionEnabled=NO;
        cell.delegate = self;
    
        cell.placeholder = @"请选择您的科室(必选)";
        
        UIButton * button=[[UIButton alloc]init];
        
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(chickDepartment) forControlEvents:(UIControlEventTouchUpInside)];
        
        [cell addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.size.equalTo(cell);
        }];
        return cell;
    }
    else if (indexPath.section==2)
    {
        FETextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCell forIndexPath:indexPath];
        cell.textField.userInteractionEnabled=NO;
        cell.delegate = self;
        cell.placeholder = @"请选择您的职称(必选)";
        UIButton * button=[[UIButton alloc]init];
        
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(chickAppellation) forControlEvents:(UIControlEventTouchUpInside)];
        
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
        cell.textField.keyboardType=UIKeyboardTypeDecimalPad;
        cell.placeholder = @"联系电话(选填如：科室电话)";
        
        return cell;
    }
    else if (indexPath.section==4)
    {
        FETextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextViewCell forIndexPath:indexPath];
        cell.delegate = self;
        cell.placeholderLabel.text=@"擅长及工作信息(选填)";
        return cell;
    }
    else if (indexPath.section==5)
    {
        FEButtonCell * cell=[tableView dequeueReusableCellWithIdentifier:buttonCell forIndexPath:indexPath];
        cell.delegate=self;
        [cell setTitle:@"上一步"];
        cell.button.tag=99999;
        return cell;
    }
    else if (indexPath.section==6)
    {
        FEButtonCell * cell=[tableView dequeueReusableCellWithIdentifier:buttonCell forIndexPath:indexPath];
        cell.button.tag=99990;
        cell.delegate=self;
        [cell setTitle:@"下一步"];
        return cell;
    }
    return nil;

}
//下一步跳转
-(void)button:(UIButton *)button ClickWithTitle:(NSString *)title
{
    if (button.tag==99999)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [self chickAuthent];
    }
}
-(void)textFiledCell:(FETextFiledCell *)cell DidBeginEditing:(NSString *)placeholder{
    
    self.facePlaceHolder = placeholder;
    
}

#pragma mark  选择科室
-(void)chickDepartment
{
    
    NSMutableArray * chickofficeArr;
    [self.view endEditing:YES];
     if ([FEUser shareDataModle].officeType==OfficeTypeWithDoctor) {
//    NSArray * chickofficeArr=[RWRequsetManager getOffice];
         chickofficeArr=[NSMutableArray arrayWithArray:[RWRequsetManager getOffice]];
     }else
     {
         chickofficeArr=[NSMutableArray arrayWithObjects:@"执业护理", nil];
     }
    isAppellation=NO;
    [self chickPickerWithObject:@"选择" andArray:chickofficeArr];
         
}

-(void)chickAppellation

{
       NSMutableArray * chickofficeArr;
    [self.view endEditing:YES];
     if ([FEUser shareDataModle].officeType==OfficeTypeWithDoctor) {

         chickofficeArr=[NSMutableArray arrayWithObjects:@"主任医师",@"副主任医师",@"主治医师",@"住院医师", nil];
         
     }else
     {
         chickofficeArr=[NSMutableArray arrayWithObjects:@"护士",@"护师",@"主管护师",@"副主任护师",@"主任护师",nil];
     }
    isAppellation=YES;
    [self chickPickerWithObject:@"选择职称" andArray:chickofficeArr];
    
    
}


-(void)placeholderLabel:(UILabel *)label andTextView:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        
        [label setHidden:NO];
        
    }else{
        
        [label setHidden:YES];
        
    }

}


//选择器

-(void)chickPickerWithObject:(NSString *)title andArray:(NSArray *)array
{
    
    _chickArr=[[NSArray alloc]init];
    _chickArr=array;
    //刷新数据
    [_chickPicker reloadAllComponents];
    
   

    if (!_alert)
    {
        _alert = [UIAlertController alertControllerWithTitle:title message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        
        _chickPicker=[[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,15,self.view.frame.size.width,200)];
        
        _chickPicker.delegate=self;
        
        _chickPicker.dataSource=self;
        
        [_alert.view addSubview:_chickPicker];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          NSInteger row = [_chickPicker selectedRowInComponent:0];
            NSString * name=[_chickArr objectAtIndex:row];
            if (isAppellation) {
                FETextFiledCell * cell=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
                cell.textField.text=name;
            }else
            {   FETextFiledCell *cell=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                cell.textField.text=name;
            }
        }];
        
       
        
        [_alert addAction:cancel];
    }
    
    [self presentViewController:_alert animated:YES completion:nil];
    
    
}

#pragma mark - UIPicker Delegate
//选择器分为几块
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//选择器有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_chickArr count];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * name=_chickArr[row];
    return name;
}

-(void)chickAuthent
{
    FETextFiledCell *hospitalCell=
    [self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    FETextFiledCell * officeCell=
    [self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    FETextFiledCell * appellationCell=
    [self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    FETextFiledCell * phoneCell=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    FETextViewCell * introduceCell=[self.viewList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    
    [FEUser shareDataModle].hospital=hospitalCell.textField.text;
    [FEUser shareDataModle].office=officeCell.textField.text;
    [FEUser shareDataModle].appellation=appellationCell.textField.text;
    [FEUser shareDataModle].office_phoneNumber=phoneCell.textField.text;
    [FEUser shareDataModle].introduce=introduceCell.writeText.text;
    
    if ([[FEUser shareDataModle].hospital isEqualToString:@""] || [[FEUser shareDataModle].office isEqualToString:@""]|| [[FEUser shareDataModle].appellation isEqualToString:@""])
        
    {
            [RWSettingsManager promptToViewController:self
                                            Title:@"请填写必填内容"
                                         response:nil];
        return;
    
    }
    FEImageViewController * imageVC=[[FEImageViewController alloc]init];
    
    [self presentViewController:imageVC animated:YES completion:nil];
  
}
-(BOOL)DetectionOfChinese:(NSString *)text
{
    if(text){
        
        for (int i=0; i<text.length; i++) {
            
            NSRange range=NSMakeRange(i,1);
            
            NSString *subString=[text substringWithRange:range];
            
            const char *cString=[subString UTF8String];
            
            if (strlen(cString)==3)
                
            {
    
                return YES;
                
                
            }
        }
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
