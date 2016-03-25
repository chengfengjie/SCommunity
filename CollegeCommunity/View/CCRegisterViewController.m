//
//  CCRegisterViewController.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/23.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "CCRegisterViewController.h"
#import "RegisterViewModel.h"

@interface CCRegisterViewController ()
@property (nonatomic,strong) UITextField * phoneTextField;
@property (nonatomic,strong) UIButton * getAuthorizedCodeButton;
@property (nonatomic,strong) UITextField * authorizedTextField;
@property (nonatomic,strong) UITextField * passwordTextField;
@property (nonatomic,strong) UIButton * registerButton;
@property (nonatomic,strong) RegisterViewModel * viewModel;
@end

@implementation CCRegisterViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"注册";
        self.viewModel = [[RegisterViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREN_width, 10)]];
    [self setupSubviews];
    [self bindViewModel];
}

- (void)bindViewModel {
    RAC(self.viewModel,phone) = self.phoneTextField.rac_textSignal;
    RAC(self.viewModel,password) = self.passwordTextField.rac_textSignal;
    
    @weakify(self);
    [[self.getAuthorizedCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.view endEditing:YES];
        [self.viewModel.getAuthorizedCommand execute:nil];
    }];
    
    [self.viewModel.getAuthorizedCommand.errors subscribeNext:^(NSError * x) {
        [SVProgressHUD showErrorWithStatus:x.userInfo[@"msg"]];
    }];
    
    [self.viewModel.getAuthorizedCommand.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(NSDictionary * x) {
            self.phoneTextField.enabled = NO;
            if ([x[@"state"] isEqualToString:@"start"]) {
                [SVProgressHUD showWithStatus:@"发送中..."];
            }
            if ([x[@"state"] isEqualToString:@"sendSuccess"]) {
                [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                self.getAuthorizedCodeButton.backgroundColor = [UIColor grayColor];
            }
        } completed:^{
            self.phoneTextField.enabled = YES;
            self.getAuthorizedCodeButton.backgroundColor = [StyleConfiguration buttonBgColor];
        }];
    }];
    
    [RACObserve(self.viewModel, getAuthorizedButtonTitleText) subscribeNext:^(id x) {
        @strongify(self);
        [self.getAuthorizedCodeButton setTitle:x forState:UIControlStateNormal];
    }];
    
    
}

- (void)setupSubviews {
    self.phoneTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREN_width-114, CELL_HEIGHT_1)];
        [textField setPlaceholder:@"请输入您的手机号码"];
        [textField setTextAlignment:NSTextAlignmentRight];
        [textField setTextColor:TEXT_COLOR3];
        [textField setFont:FONT(16)];
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        textField;
    });
    
    self.getAuthorizedCodeButton = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(SCREN_width-120, 0, 120, CELL_HEIGHT_1)];
        [button setBackgroundColor:[StyleConfiguration buttonBgColor]];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT(16)];
        button;
    });
    
    self.authorizedTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(SCREN_width-200, 0, 70, CELL_HEIGHT_1)];
        [textField setPlaceholder:@"验证码"];
        [textField setFont:self.phoneTextField.font];
        [textField setTextColor:TEXT_COLOR3];
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        [textField setTextAlignment:NSTextAlignmentRight];
        textField;
    });
    
    self.passwordTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:self.phoneTextField.frame];
        [textField setSecureTextEntry:YES];
        [textField setPlaceholder:@"请输入密码"];
        [textField setFont:FONT(16)];
        [textField setTextColor:TEXT_COLOR3];
        [textField setTextAlignment:NSTextAlignmentRight];
        textField;
    });
    
    self.registerButton = ({
        UIView * tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREN_width, 60)];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(10, 20, SCREN_width-20, 40)];
        [button.layer setCornerRadius:5];
        [button setTitle:@"注册" forState:UIControlStateNormal];
        [button setBackgroundColor:[StyleConfiguration buttonBgColor]];
        [tableFooter addSubview:button];
        [self.tableView setTableFooterView:tableFooter];
        button;
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCBaseTableViewCell * cell = [[CCBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setBottomLineColor:LINEColor height:LINEHeight];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"手机号码";
            [cell setTopLineColor:LINEColor height:LINEHeight];
            [cell.contentView addSubview:self.phoneTextField];
        }
            break;
        case 1:{
            cell.textLabel.text = @"验证码";
            [cell.contentView addSubview:self.getAuthorizedCodeButton];
            [cell.contentView addSubview:self.authorizedTextField];
        }
            break;
        case 2:{
            cell.textLabel.text = @"密码";
            [cell.contentView addSubview:self.passwordTextField];
        }
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
