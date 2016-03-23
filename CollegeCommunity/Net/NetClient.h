//
//  NetClient.h
//  CollegeCommunity
//
//  Created by chengfj on 16/3/17.
//  Copyright © 2016年 chengfj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id responseData);
typedef void(^Failure)(NSError * error,NSString * msg);
@interface NetClient : NSObject
+ (void)postMethod:(NSString *)method
          paramars:(NSDictionary *)paramars
           success:(Success)success
           failure:(Failure)failure;
@end
