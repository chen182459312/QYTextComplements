//
//  QYDataSource.h
//  QYTextComplements
//
//  Created by leo on 2021/1/12.
//

#import <Foundation/Foundation.h>
#import "QYDataManager.h"
#import "QYNetWorking.h"
NS_ASSUME_NONNULL_BEGIN

@interface QYDataSource : NSObject
- (void)search:(NSString*)text complete:(void(^)(NSArray<NSAttributedString*>*))complete;
- (void)clearDB;
@end

NS_ASSUME_NONNULL_END
