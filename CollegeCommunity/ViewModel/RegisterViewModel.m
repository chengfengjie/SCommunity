//
//  RegisterViewModel.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/23.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "RegisterViewModel.h"

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
                    [subscriber sendError:[NSError errorWithDomain:@"错误" code:1000 userInfo:@{@"msg":@"手机号码不正确"}]];
                    return [RACDisposable disposableWithBlock:^{}];
                }];
            }
            else {
                return [self exeGetAuthorized];
            }
        }];
        
        self.registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal empty];
        }];
    }
    return self;
}

- (RACSignal *)exeGetAuthorized {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@{@"state":@"start"}];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (true) {
                [subscriber sendNext:@{@"state":@"sendSuccess"}];
                [self startTimer:subscriber];
            }
            else {
                [subscriber sendError:[NSError errorWithDomain:@"" code:1000 userInfo:@{@"msg":@"短信发送失败"}]];
            }
        });
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (void)startTimer:(id<RACSubscriber>)subcriber {
    self.timeInteral = 10;
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
