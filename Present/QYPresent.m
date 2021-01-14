//
//  QYPresent.m
//  QYTextComplements
//
//  Created by leo on 2021/1/14.
//

#import "QYPresent.h"
@implementation QYPresent
- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(textFieldTextDidChange:)
                                                         name:UITextFieldTextDidChangeNotification
                                                       object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - notice
- (void)textFieldTextDidChange:(NSNotification*)notice {
    if (self.textFieldTextDidChange) {
        self.textFieldTextDidChange();
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TEXT_FEILD_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:keyQYTableCellIdentifier];
    if (!cell) {
        cell = [[QYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:keyQYTableCellIdentifier];
    }
    QYTableViewCell *tmpCell = (QYTableViewCell*)cell;
    [tmpCell bindData:[self.arrayDataSource objectAtIndex:indexPath.row] indexPath:indexPath];
    return cell;
}
#pragma mrek - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.didSelectRowAtIndexPath) {
            self.didSelectRowAtIndexPath(indexPath);
        }
    });
}

@end
