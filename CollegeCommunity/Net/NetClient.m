//
//  NetClient.m
//  CollegeCommunity
//
//  Created by chengfj on 16/3/17.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import "NetClient.h"
#import "AFHTTPSessionManager.h"

NSString *const kAPIHost = @"http://10.1.0.71/project/CollegeCommunity/app.php/Home/";
NSString *const kAPPSecrpt = @"chengfj2014141441324324";

@implementation NetClient
+ (void)postMethod:(NSString *)method paramars:(NSDictionary *)paramars success:(Success)success failure:(Failure)failure {
    NSString * url = [NSString stringWithFormat:@"%@/%@",kAPIHost,method];
    NSDictionary * signParamars = [self signParamars:paramars];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:signParamars progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 1000) {
            success(responseObject);
        }
        else if(code == 1005){
            NSLog(@"账号在别的地方登陆");
        }
        else {
            failure([NSError errorWithDomain:@"" code:0 userInfo:responseObject],[responseObject objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error,@"服务器连接失败");
    }];
}

+ (NSDictionary *)signParamars:(NSDictionary *)paramars {
    NSMutableDictionary * muParamars = [paramars mutableCopy];
    if (muParamars == nil) {
        muParamars = [NSMutableDictionary dictionary];
    }
    [muParamars setObject:kAPPSecrpt forKey:@"sign"];
    return muParamars;
}
@end
