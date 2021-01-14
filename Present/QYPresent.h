//
//  QYPresent.h
//  QYTextComplements
//
//  Created by leo on 2021/1/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QYTableViewCell.h"
#import "QYUIDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface QYPresent : NSObject<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *arrayDataSource;;
@property (nonatomic, copy) void(^textFieldTextDidChange)(void);
@property (nonatomic, copy) void(^didSelectRowAtIndexPath)(NSIndexPath*indexPath);
@end

NS_ASSUME_NONNULL_END
