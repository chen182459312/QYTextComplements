//
//  QYTableViewCell.h
//  QYTextComplements
//
//  Created by leo on 2021/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYTableViewCell : UITableViewCell
- (void)bindData:(NSAttributedString*)txt indexPath:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
