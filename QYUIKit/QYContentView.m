//
//  QYContentView.m
//  QYTextComplements
//
//  Created by leo on 2021/1/14.
//

#import "QYContentView.h"
#import "QYPresent.h"
#import "QYTextField.h"
#import "QYTableViewCell.h"
@interface QYContentView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) QYPresent *present;
@end

@implementation QYContentView

- (instancetype)initWithFrame:(CGRect)frame presentDelegate:(QYPresent*)presentDelegate{
    if (self = [super initWithFrame:frame]) {
        self.present = presentDelegate;
        [self addSubview:self.textField];
        self.textField.frame = CGRectMake(20, POINT_Y, SCREEN_WIDTH - 2*SPACING , TEXT_FEILD_H);
        self.textField.backgroundColor = [UIColor lightGrayColor];
        self.textField.selected = NO;

        [self addSubview:self.button];
        self.button.frame = CGRectMake(self.textField.frame.origin.x+self.textField.frame.size.width+2, self.textField.frame.origin.y, 120, TEXT_FEILD_H);
        [self.button addTarget:self action:@selector(clearDB:) forControlEvents:UIControlEventTouchUpInside];
        [self.button setTitle:@"Clear DB" forState:UIControlStateNormal];
        self.button.backgroundColor = [UIColor lightGrayColor];

        [self addSubview:self.tableView];
        self.tableView.delegate = self.present;
        self.tableView.dataSource = self.present;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [self.tableView registerClass:[QYTableViewCell class] forCellReuseIdentifier:keyQYTableCellIdentifier];
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.frame = CGRectMake(20, POINT_Y+TEXT_FEILD_H+2, SCREEN_WIDTH - 2*SPACING , TABLEVIEW_HEIGHT);
        self.tableView.hidden = YES;
        self.tableView.backgroundColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIButton*)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"Search" forState:UIControlStateNormal];
    }
    return _button;
}

- (UITableView*)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor grayColor];
    }
    return _tableView;
}

- (UITextField*)textField {
    if (!_textField) {
        _textField = [[QYTextField alloc] init];
        _textField.tag = 7788;
    }
    return _textField;
}

- (void)clearDB:(id)sender {
    if (self.clearDB) {
        self.clearDB(sender);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches  anyObject] locationInView:self];
    point = [self.tableView.layer convertPoint:point fromLayer:self.layer];
    if( ![self.tableView.layer containsPoint:point]){
        if (self.spaceCkick) {
            self.spaceCkick();
        }
    }
}
@end
