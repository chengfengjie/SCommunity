//
//  RegisterViewModel.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/23.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"

@interface RegisterViewModel : ViewModel
@property (nonatomic,copy) NSString * phone;
@property (nonatomic,copy) NSString * password;
@property (nonatomic,strong) RACCommand * getAuthorizedCommand;
@property (nonatomic,copy) NSString * getAuthorizedButtonTitleText;
@property (nonatomic,strong) RACCommand * registerCommand;
@end
