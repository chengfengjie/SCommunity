//
//  RegisterViewModel.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/23.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "RegisterViewModel.h"
#import <SMS_SDK/SMSSDK.h>
#import "NetClient+RegisterAccount.h"

@interface RegisterViewModel ()
@property (nonatomic,assign) NSInteger timeInteral;
@property (nonatomic,strong) NSTimer * timer;
@end

@implementation RegisterViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.getAuthorizedButtonTitleText = @"获取验证码";
        self.timeInteral = 0;
        self.getAuthorizedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            if (self.timeInteral > 0) {
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendCompleted];
                    return [RACDisposable disposableWithBlock:^{}];
                }];
            }
            else if (![self.phone isPhoneNumber]) {
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendError:[NSError errorWithMsg:@"请输入11位的手机号码"]];
                    return [RACDisposable disposableWithBlock:^{}];
                }];
            }
            return [self exeGetAuthorized];
        }];
        
        self.registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            if (![self.phone isPhoneNumber]) {
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendError:[NSError errorWithMsg:@"请输入11位的手机号码"]];
                    return [RACDisposable disposableWithBlock:^{}];
                }];
            }
            if (self.authorizedCode.length < 4 || self.authorizedCode.length > 6) {
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendError:[NSError errorWithMsg:@"请输入4位的验证码"]];
                    return [RACDisposable disposableWithBlock:^{}];
                }];
            }
            if (self.password.length < 6) {
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendError:[NSError errorWithMsg:@"请输入至少6位的密码"]];
                    return [RACDisposable disposableWithBlock:^{}];
                }];
            }
            return [self registerAccountSingal];
        }];
    }
    return self;
}

- (RACSignal *)exeGetAuthorized {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@{@"state":@"start"}];
        [NetClient phoneExist:self.phone success:^(id responseData) {
            NSInteger phoneExist = [[[responseData objectForKey:@"data"] objectForKey:@"exist"] integerValue];
            if (phoneExist == 1) {
                [subscriber sendError:[NSError errorWithMsg:@"手机号码已经注册\n请直接登录"]];
            }
            else {
                [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phone zone:@"86" customIdentifier:nil result:^(NSError *error) {
                    if (!error) {
                        [subscriber sendNext:@{@"state":@"sendSuccess"}];
                        [self startTimer:subscriber];
                    }
                    else {
                        [subscriber sendError:[NSError errorWithMsg:error.userInfo[@"getVerificationCode"]]];
                    }
                }];
            }
        } failure:^(NSError *error, NSString *msg) {
            [subscriber sendError:[NSError errorWithMsg:@"验证码发送失败,请重新发送"]];
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

- (RACSignal *)registerAccountSingal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@{@"state":@"start"}];
        [SMSSDK commitVerificationCode:self.authorizedCode phoneNumber:self.phone zone:@"86" result:^(NSError *error) {
            if (!error) {
                [NetClient registerAccountWithPhone:self.phone password:self.password success:^(id responseData) {
                    [subscriber sendNext:@{@"state":@"success",@"data":responseData}];
                    [subscriber sendCompleted];
                } failure:^(NSError *error, NSString *msg) {
                    [subscriber sendError:[NSError errorWithMsg:msg]];
                }];
            }
            else {
                [subscriber sendError:[NSError errorWithMsg:@"验证码错误"]];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (void)startTimer:(id<RACSubscriber>)subcriber {
    self.timeInteral = 60;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(reduceTimeInteral) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [RACObserve(self, timeInteral) subscribeNext:^(id x) {
        if ([x integerValue] <= 0) {
            [subcriber sendCompleted];
            self.getAuthorizedButtonTitleText = @"获取验证码";
        }
        else {
            self.getAuthorizedButtonTitleText = [NSString stringWithFormat:@"%@秒后重新获取",x];
        }
    }];
}

- (void)reduceTimeInteral {
    if (self.timeInteral < 1) {
        self.timeInteral = 0;
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    self.timeInteral = self.timeInteral-1;
}

@end
