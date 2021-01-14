//
//  QYDataManager.h
//  QYTextComplements
//
//  Created by leo on 2021/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYDataManager : NSObject
@property (nonatomic, strong) dispatch_queue_t delegateQueue;
- (instancetype)initWithDelegateQueue:(nullable dispatch_queue_t)queue;
- (void)insert:(NSString*)title complete:(void(^)(BOOL flg))complete;
- (void)dimQuery:(NSString*)condition complete:(void(^)(NSArray<NSString*> *titles))complete;
- (void)clearDB:(void(^)(BOOL flg))complete;
@end

NS_ASSUME_NONNULL_END
