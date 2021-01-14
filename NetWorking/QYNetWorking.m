//
//  QYNetWorking.m
//  QYTextComplements
//
//  Created by leo on 2021/1/10.
//

#import "QYNetWorking.h"
#import <AFNetworking/AFNetworking.h>
#import "QYUIDefine.h"

static AFNetworkReachabilityStatus reachabilityStatus;
@interface QYNetWorking()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation QYNetWorking
#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfig];
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain", @"text/html", nil];
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        reachabilityStatus = status;
    }];
    [reachability startMonitoring];
}

#pragma mark - API
- (BOOL)reachabilityEnable {
    if (AFNetworkReachabilityStatusReachableViaWWAN == reachabilityStatus ||
        AFNetworkReachabilityStatusReachableViaWiFi == reachabilityStatus) {
        return YES;
    }
    return NO;
}
- (void)post:(NSString*)api
       param:(NSDictionary*)param
     success:(void(^)(id responseObj))success
      failed:(void(^)(NSError*error))failed {
    NSString *strURL = [NSString stringWithFormat:@"%@/%@", QYBaseURL, api];
    strURL = QYBaseURL;//remove api just for test.
    param = nil;
    [self.sessionManager POST:strURL parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}


@end
