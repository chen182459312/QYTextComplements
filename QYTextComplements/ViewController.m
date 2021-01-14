//
//  ViewController.m
//  QYTextComplements
//
//  Created by leo on 2021/1/10.
//

#import "ViewController.h"
#import "QYDataSource.h"
#import "QYTextField.h"
#import "QYPresent.h"
#import "QYContentView.h"

@interface ViewController ()
@property (nonatomic, strong) QYDataSource *dataSource;
@property (nonatomic, strong) QYPresent *present;
@property (nonatomic, strong) QYContentView *contentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    __weak __typeof(self) weakSelf = self;
    self.present.textFieldTextDidChange = ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf textFieldTextDidChangeOption];
    };
    self.present.didSelectRowAtIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
        __strong typeof(self) strongSelf = weakSelf;
        NSAttributedString *title = [strongSelf.present.arrayDataSource objectAtIndex:indexPath.row];
        strongSelf.contentView.textField.text = [title string];
        strongSelf.contentView.tableView.hidden = YES;
    };
    self.contentView.clearDB = ^(id  _Nonnull sender) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.dataSource clearDB];
    };
    self.contentView.spaceCkick = ^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.contentView.tableView.hidden = YES;
    };
}

- (QYContentView*)contentView {
    if (!_contentView) {
        _contentView = [[QYContentView alloc] initWithFrame:self.view.bounds presentDelegate:self.present];
    }
    return _contentView;
}

- (QYPresent*)present {
    if (nil == _present) {
        _present = [[QYPresent alloc] init];
    }
    return _present;;
}

- (QYDataSource*)dataSource {
    if (!_dataSource) {
        _dataSource = [[QYDataSource alloc] init];
    }
    return _dataSource;
}

#pragma mark - private
- (void)textFieldTextDidChangeOption {
    if ([self.contentView.textField.text length]>0) {
        __weak __typeof(self) weakSelf = self;
        [self.dataSource search:self.contentView.textField.text complete:^(NSArray<NSAttributedString *> *array) {
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.present.arrayDataSource = [NSMutableArray arrayWithArray:array];
            if (strongSelf.present.arrayDataSource.count>0) {
                CGRect rect = strongSelf.contentView.tableView.frame;
                if (MAX_TABLE_HEIGHT > strongSelf.present.arrayDataSource.count * TEXT_FEILD_H ) {
                    [strongSelf.contentView.tableView reloadData];
                    strongSelf.contentView.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, strongSelf.present.arrayDataSource.count * TEXT_FEILD_H );
                } else {
                    [strongSelf.contentView.tableView reloadData];
                    strongSelf.contentView.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, MAX_TABLE_HEIGHT);
                }
                strongSelf.contentView.tableView.hidden = NO;
                [strongSelf.contentView.tableView reloadData];

            } else {
                strongSelf.contentView.tableView.hidden = YES;
            }
        }];
    } else {
        self.present.arrayDataSource = [NSMutableArray array];
        [self.contentView.tableView reloadData];
        self.contentView.tableView.hidden = YES;
    }
}

@end
