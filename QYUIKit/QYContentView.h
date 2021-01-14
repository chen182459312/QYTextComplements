//
//  QYContentView.h
//  QYTextComplements
//
//  Created by leo on 2021/1/14.
//

#import <UIKit/UIKit.h>
#import "QYUIDefine.h"

NS_ASSUME_NONNULL_BEGIN
@class QYPresent;
@class QYTextField;
@interface QYContentView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QYTextField *textField;
@property (nonatomic, copy) void(^clearDB)(id sender);
@property (nonatomic, copy) void(^spaceCkick)(void);
- (instancetype)initWithFrame:(CGRect)frame presentDelegate:(QYPresent*)presentDelegate;
@end

NS_ASSUME_NONNULL_END
