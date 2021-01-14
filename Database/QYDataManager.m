//
//  QYDataManager.m
//  QYTextComplements
//
//  Created by leo on 2021/1/10.
//

#import "QYDataManager.h"
#include <FMDB/FMDatabase.h>
#include <FMDB/FMDatabaseQueue.h>
#include <FMDB/FMResultSet.h>
#import "NSString+ZZStringMD5.h"

@interface QYDataManager()
@property (nonatomic, strong) FMDatabaseQueue *queueDB;
@property (nonatomic, strong) dispatch_queue_t queueWork;
@end
@implementation QYDataManager

- (instancetype)initWithDelegateQueue:(nullable dispatch_queue_t)queue {
    if (self = [super init]) {
        _delegateQueue = queue;
        [self initDataBase];
    }
    return self;
}
#pragma mark - init
- (dispatch_queue_t)delegateQueue {
    if (!_delegateQueue) {
        _delegateQueue = dispatch_get_main_queue();
    }
    return _delegateQueue;
}

- (void)initDataBase {
    _queueWork = dispatch_queue_create("com.qingyun.db", DISPATCH_QUEUE_CONCURRENT);
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"qydb.sqlite"]];
    NSLog(@"%@",filePath);
    _queueDB = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [_queueDB inDatabase:^(FMDatabase *db) {
        BOOL flg =[db executeUpdate:@"CREATE TABLE IF NOT EXISTS title_table (md5 text PRIMARY KEY, title text)"];
        if (!flg) {
            NSLog(@"创建表失败");
        }
    }];
}
#pragma mark - API
- (void)insert:(NSString*)title complete:(void(^)(BOOL flg))complete {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(self.queueWork, ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.queueDB inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *md5 = [title md5];
            BOOL result = [db executeUpdate:@"INSERT OR IGNORE INTO title_table (md5, title) VALUES(?, ?)", md5,title];
            if (complete) {
                dispatch_async(strongSelf.delegateQueue, ^{
                    complete(result);
                });
            }
        }];
    });
}

- (void)dimQuery:(NSString*)condition complete:(void(^)(NSArray<NSString*> *titles))complete {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(self.queueWork, ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.queueDB inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *sql =[NSString stringWithFormat:@"SELECT * FROM title_table WHERE title LIKE '%%%@%%' ",condition];
            FMResultSet *result = [db executeQuery:sql];
            NSMutableArray *array = [NSMutableArray array];
            while ([result nextWithError:nil]) {
                NSString *title = [result stringForColumn:@"title"];
                [array addObject:title];
            }
            if (complete) {
                dispatch_async(strongSelf.delegateQueue, ^{
                    complete(array);
                });
            }
        }];
    });
}

- (void)clearDB:(void(^)(BOOL))complete {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(self.queueWork, ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.queueDB inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *sql = @"DELETE FROM title_table";
            BOOL flg = [db executeUpdate:sql];
            dispatch_async(strongSelf.delegateQueue, ^{
                if (complete) {
                    complete(flg);
                }
            });
        }];
    });
}

@end

