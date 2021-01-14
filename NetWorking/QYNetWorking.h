//
//  QYNetWorking.h
//  QYTextComplements
//
//  Created by leo on 2021/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYNetWorking : NSObject
- (BOOL)reachabilityEnable;
- (void)post:(NSString*)api
       param:(NSDictionary*)param
     success:(void(^)(id responseObj))success
      failed:(void(^)(NSError*error))failed;
@end

NS_ASSUME_NONNULL_END
