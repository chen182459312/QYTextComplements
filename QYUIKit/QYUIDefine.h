//
//  QYUIDefine.h
//  QYTextComplements
//
//  Created by leo on 2021/1/14.
//

#ifndef QYUIDefine_h
#define QYUIDefine_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SPACING 80
#define POINT_Y 100
#define TEXT_FEILD_H 44
#define MAX_TABLE_HEIGHT (SCREEN_HEIGHT - POINT_Y - TEXT_FEILD_H - SPACING*2)
#define TABLEVIEW_HEIGHT (SCREEN_HEIGHT - POINT_Y - TEXT_FEILD_H - SPACING)

static NSString *keyQYTableCellIdentifier = @"QYTableCellIdentifier";
#define QYBaseURL @"https://www.baidu.com"

#endif /* QYUIDefine_h */
