//
//  CCRegisterViewController.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/23.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "CCRegisterViewController.h"

@interface CCRegisterViewController ()
@property (nonatomic,strong) UITextField * phoneTextField;
@property (nonatomic,strong) UIButton * getAuthorizedCodeButton;
@property (nonatomic,strong) UITextField * passwordTextField;
@end

@implementation CCRegisterViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"注册";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREN_width, 10)]];
    
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
        [button setFrame:CGRectMake(SCREN_width-100, 0, 100, CELL_HEIGHT_1)];
        [button setBackgroundColor:[StyleConfiguration buttonBgColor]];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT(16)];
        button;
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
