//
//  QYTableViewCell.m
//  QYTextComplements
//
//  Created by leo on 2021/1/12.
//

#import "QYTableViewCell.h"

@interface QYTableViewCell()
@property (nonatomic, strong) UILabel*lable;
@end

@implementation QYTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _lable = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_lable];
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)bindData:(NSAttributedString*)txt indexPath:(NSIndexPath*)indexPath {
    self.lable.attributedText = txt;
    [self setNeedsDisplay];
}

@end
