//
//  QYDataSource.m
//  QYTextComplements
//
//  Created by leo on 2021/1/12.
//
#import <UIKit/UIKit.h>
#import "QYDataSource.h"
#import "QYDataManager.h"
#import "QYNetWorking.h"
#import "QYUIDefine.h"

@interface QYDataSource()
@property (nonatomic, strong) QYDataManager *dataManager;
@property (nonatomic, strong) QYNetWorking *netWorking;
@property (nonatomic, strong) NSMutableArray *arrayDatas;
@end

@implementation QYDataSource
#pragma mark -init
- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (NSMutableArray*)arrayDatas {
    if (!_arrayDatas) {
        _arrayDatas = [NSMutableArray array];
    }
    return _arrayDatas;
}
- (QYNetWorking*)netWorking {
    if (!_netWorking) {
        _netWorking = [[QYNetWorking alloc] init];
    }
    return _netWorking;
}

- (QYDataManager*)dataManager {
    if (!_dataManager) {
        _dataManager = [[QYDataManager alloc] initWithDelegateQueue:nil];
    }
    return _dataManager;
}

#pragma mark - API
- (void)search:(NSString*)text complete:(void(^)(NSArray<NSAttributedString*>*))complete {
    __weak __typeof(self) weakSelf = self;
    [self.netWorking post:QYBaseURL param:@{@"key":@"value"} success:^(id  _Nonnull responseObj) {
        //just simulate to obtain data from net working.
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf insertQuery:text complete:complete];
    } failed:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"net working error, do not inser database");
        [strongSelf.dataManager dimQuery:text complete:^(NSArray<NSString *> * _Nonnull titles) {
            if (complete) {
                NSArray<NSAttributedString*>*arrayAtt = [strongSelf attributedString:text datas:titles];
                complete(arrayAtt);
            }
        }];
    }];
}

#pragma mark - private

- (void)insertQuery:(NSString*)txt complete:(void(^)(NSArray<NSAttributedString*>*))complete {
    if (0 == txt.length) {
        if (complete) {
            complete(nil);
        }
        return;
    }
    __weak __typeof(self) weakSelf = self;
    [self.dataManager insert:txt complete:^(BOOL flg) {
        __strong typeof(self) strongSelf = weakSelf;
        if (flg) {
            [strongSelf.dataManager dimQuery:txt complete:^(NSArray<NSString *> * _Nonnull titles) {
                if (complete) {
                    NSArray<NSAttributedString*>*arrayAtt = [self attributedString:txt datas:titles];
                    complete(arrayAtt);
                }
            }];
        } else {
            if (complete) {
                NSArray<NSAttributedString*>*arrayAtt = [self attributedString:txt datas:@[txt]];
                complete(arrayAtt);
            }
            NSLog(@"insert data base error");
        }
    }];
}

- (void)clearDB {
    [self.dataManager clearDB:nil];
}
#pragma mark - private
- (NSArray<NSAttributedString*>*)attributedString:(NSString*)txt datas:(NSArray<NSString*>*)datas {
    NSMutableArray *attDatas = [NSMutableArray array];
    for (NSString *itme in datas) {
        NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:itme];
        NSRange range = [itme rangeOfString:txt];
        if (NSNotFound!= range.location) {
            [attstring addAttribute: NSForegroundColorAttributeName value:[UIColor systemBlueColor] range:range];
            [attDatas addObject:attstring];
        }
    }
    return attDatas;
}


@end
