//
//  LoginViewModel.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/15.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "LoginViewModel.h"
#import "NetClient+Login.h"

@interface LoginViewModel ()
@property (nonatomic,strong) RACSignal * loginValidSingal;
@end

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loginButtonCommand = [[RACCommand alloc] initWithEnabled:self.loginValidSingal signalBlock:^RACSignal *(id input) {
            return [self loginSingal];
        }];
    }
    return self;
}

- (RACSignal *)loginSingal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@{@"state":@"start"}];
        [NetClient loginWithPhone:self.account password:self.password success:^(id responseData) {
            [subscriber sendNext:@{@"state":@"success",@"data":responseData}];
            [subscriber sendCompleted];
        } failure:^(NSError *error, NSString *msg) {
            [subscriber sendError:[NSError errorWithMsg:msg]];
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (RACSignal *)loginValidSingal {
    if (_loginValidSingal) {
        return _loginValidSingal;
    }
    _loginValidSingal = [[RACSignal merge:@[RACObserve(self, account),RACObserve(self, password)]] map:^id(id value) {
        return ([self.account isPhoneNumber] && self.password.length >= 6)?@(YES):@(NO);
    }];
    return _loginValidSingal;
}

@end
