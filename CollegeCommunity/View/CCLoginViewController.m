//
//  CCLoginViewController.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/14.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "CCLoginViewController.h"
#import "Masonry.h"
#import "UIDefine.h"
#import "Import.h"
#import "LoginViewModel.h"
#import "ReactiveCocoa-umbrella.h"
#import "CCRetrieveViewController.h"
#import "CCRegisterViewController.h"

@interface CCLoginViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIButton * userHeadButton;
@property (nonatomic,strong) UITextField * usernameTextField;
@property (nonatomic,strong) UITextField * passwordTextField;
@property (nonatomic,strong) UIButton * loginButton;
@property (nonatomic,strong) LoginViewModel * viewModel;
@property (nonatomic,strong) UIButton * forgetPasswordButton;//忘记密码按钮
@property (nonatomic,strong) UIButton * registerButton;//注册按钮
@end

@implementation CCLoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[LoginViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    [self addSubViews];
    [self bindContraints];
    [self bindViewModel];
}

- (void)bindViewModel {

    RAC(self.viewModel,account)  = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel,password) = self.passwordTextField.rac_textSignal;
    self.loginButton.rac_command = self.viewModel.loginButtonCommand;
    
    @weakify(self);
    [self.viewModel.loginValidSingal subscribeNext:^(id x) {
        @strongify(self);
        [self.loginButton setBackgroundColor:[x boolValue]?[UIColor buttonBackgroundColor]:[UIColor grayColor]];
    }];

    [self.viewModel.loginExecSingal subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}

- (void)bindContraints {
    [self.userHeadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(60);
        make.width.equalTo(@90);
        make.height.equalTo(@90);
    }];
}

- (void)addSubViews {
    
    UIVisualEffectView * backgroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [backgroundView setBackgroundColor:[UIColor clearColor]];
    [backgroundView.layer setContents:(__bridge id)[UIImage imageNamed:@"login_background_image.png"].CGImage];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
    }];
    
    self.userHeadButton = ({
        UIButton * userHeadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [userHeadButton setBackgroundColor:[UIColor orangeColor]];
        [userHeadButton.layer setCornerRadius:45];
        [userHeadButton.layer setMasksToBounds:YES];
        [userHeadButton setImage:[UIImage imageNamed:@"default_logo.png"] forState:UIControlStateNormal];
        [userHeadButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [userHeadButton.layer setBorderWidth:2];
        userHeadButton;
    });
    [self.view addSubview:self.userHeadButton];
    
    UIView * inputBackgroundView = [[UIView alloc] init];
    [inputBackgroundView setBackgroundColor:COLOR_RGBA(255, 255, 255, 0.90)];
    [self.view addSubview:inputBackgroundView];
    [inputBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userHeadButton.mas_bottom).with.offset(30);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@80);
    }];
    
    UIView * topline = [[UIView alloc] init];
    [topline setBackgroundColor:[UIColor lineColor]];
    [inputBackgroundView addSubview:topline];
    [topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputBackgroundView).with.offset(0);
        make.width.equalTo(inputBackgroundView.mas_width);
        make.height.equalTo(@0.7);
    }];
    
    self.usernameTextField = ({
        UITextField * t = [[UITextField alloc] init];
        [t setPlaceholder:@"请输入您的手机号"];
        [t setTextAlignment:NSTextAlignmentCenter];
        [t setFont:[UIFont systemFontOfSize:16]];
        [t setKeyboardType:UIKeyboardTypeNumberPad];
        [t setClearButtonMode:UITextFieldViewModeWhileEditing];
        [[t rac_signalForSelector:@selector(textFieldShouldClear:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(id x) {
            
        }];
         t;
    });
    [inputBackgroundView addSubview:self.usernameTextField];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(inputBackgroundView.mas_height).multipliedBy(0.5);
        make.top.equalTo(inputBackgroundView).with.offset(0);
        make.left.equalTo(inputBackgroundView).with.offset(10);
        make.right.equalTo(inputBackgroundView).with.offset(-10);
    }];
    
    UIView * middleline = [[UIView alloc] init];
    [middleline setBackgroundColor:[UIColor lineColor]];
    [inputBackgroundView addSubview:middleline];
    [middleline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(topline.mas_height);
        make.width.equalTo(topline.mas_width);
        make.left.equalTo(topline.mas_left);
        make.centerY.equalTo(inputBackgroundView.mas_centerY);
    }];
    
    //密码框
    self.passwordTextField = ({
        UITextField * t = [[UITextField alloc] init];
        [t setPlaceholder:@"请输入密码"];
        [t setTextAlignment:NSTextAlignmentCenter];
        [t setFont:[UIFont systemFontOfSize:16]];
        [t setSecureTextEntry:YES];
         t;
    });
    [inputBackgroundView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameTextField.mas_left);
        make.width.equalTo(self.usernameTextField.mas_width);
        make.height.equalTo(self.usernameTextField.mas_height);
        make.top.equalTo(self.usernameTextField.mas_bottom);
    }];
    
    //登录按钮
    self.loginButton = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:self.viewModel.valid?[UIColor buttonBackgroundColor]:[UIColor grayColor]];
        [btn.layer setCornerRadius:5];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        @weakify(self);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.view endEditing:YES];
        }];
        btn;
    });
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputBackgroundView.mas_bottom).with.offset(30);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.height.equalTo(@40);
    }];
 
    //忘记密码按钮
    self.forgetPasswordButton = ({
        UILabel * label = [[UILabel alloc] init];
        [label setText:@"忘记密码?"];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(10);
            make.bottom.equalTo(self.view).with.offset(-10);
        }];
        [self.view addSubview:label];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button;
    });
    [self.view addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.bottom.equalTo(self.view).with.offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    @weakify(self);
    [[self.forgetPasswordButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController pushViewController:[[CCRetrieveViewController alloc] init] animated:YES];
    }];
    
    //注册按钮
    self.registerButton = ({
        UILabel * label = [[UILabel alloc] init];
        [label setText:@"注册"];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).with.offset(-10);
            make.bottom.equalTo(self.view).with.offset(-10);
        }];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button;
    });
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    [[self.registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController pushViewController:[[CCRegisterViewController alloc] init] animated:YES];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
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
