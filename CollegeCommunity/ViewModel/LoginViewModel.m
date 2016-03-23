//
//  LoginViewModel.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/15.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
         self.loginValidSingal   = [RACSubject subject];
         self.loginExecSingal    = [RACSubject subject];
        
        [self bindSingal];
    }
    return self;
}

- (RACCommand *)loginButtonCommand {
    if (_loginButtonCommand == nil) {
        _loginButtonCommand = [[RACCommand alloc] initWithEnabled:[self validCondition] signalBlock:^RACSignal *(id input) {
            return [RACSignal empty];
        }];
    }
    return _loginButtonCommand;
}

- (RACSignal *)validCondition {
    @weakify(self);
    return [RACObserve(self, valid) map:^id(id value) {
        @strongify(self);
        return @(self.valid);
    }];
}

- (void)bindSingal {
    @weakify(self);
    [RACObserve(self, account) subscribeNext:^(id x) {
        @strongify(self);
        [self validLoginParamars];
    }];
    [RACObserve(self, password) subscribeNext:^(id x) {
        @strongify(self);
        [self validLoginParamars];
    }];
    [self validLoginParamars];
    [RACObserve(self, valid) subscribeNext:^(id x) {
        @strongify(self);
        [self.loginValidSingal sendNext:@(self.valid)];
    }];
}

- (void)validLoginParamars {
    (self.account.length == 11 && self.password.length >= 6)?(self.valid=YES):(self.valid=NO);
}

@end
