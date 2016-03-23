//
//  LoginViewModel.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/15.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa-umbrella.h"

@interface LoginViewModel : NSObject
@property (nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString * password;
@property (nonatomic,strong) RACCommand * loginButtonCommand;
@property (nonatomic,strong) RACSubject * loginValidSingal;
@property (nonatomic,strong) RACSubject * loginExecSingal;
@property (nonatomic,assign) BOOL valid;
@end
