//
//  Constant.h
//  redbull
//
//  Created by Xin Qin on 11/27/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#define HTML5_APP_URL   @"http://www.redbullclub.cn/index.php?s=M"

#define INDEX_PAGE      @"http://www.redbullclub.cn/index.php?s=IOS"
#define ASK_PAGE        @"http://www.redbullclub.cn/index.php?s=IOS/vote"
#define EXCHANGE_PAGE   @"http://www.redbullclub.cn/index.php?s=IOS/shop"
#define EXCHANGE_DETAIL_PAGE   @"http://www.redbullclub.cn/index.php?s=IOS/detail"
#define TURNTABLE_PAGE  @"http://www.redbullclub.cn/index.php?s=IOS/event"
#define LOGIN_POSTPATH  @"http://www.redbullclub.cn/index.php?s=User/doLoginForIos" //登陆postPath

#define INDEX_PAGE_INDEX  0
#define ASK_PAGE_INDEX 1
#define EXCHANGE_PAGE_INDEX 2
#define EXCHANGE_DETAIL_PAGE_INDEX 2
#define TURNTABLE_PAGE_INDEX 3

#define kMenuFullWidth                  320.0f
#define kMenuDisplayedWidth             240.0f
#define kMenuOverlayWidth (self.view.bounds.size.width - kMenuDisplayedWidth)
#define kMenuBounceOffset               10.0f
#define kMenuBounceDuration             .3f
#define kMenuSlideDuration              .3f

#define NAVIGATIONBAR_HEIGHT            44.f

#define TITLE_NAVGATIONBAR      @"红牛能量部落"

#define PI 3.14159265358979323846

#define PROFILE_URL                 @"http://www.redbullclub.cn/index.php?s=IOS/profile"
#define PASSWORD_URL                @"http://www.redbullclub.cn/index.php?s=IOS/password"
#define ADDRESS_URL                 @"http://www.redbullclub.cn/index.php?s=IOS/address"
#define SCORE_URL                   @"http://www.redbullclub.cn/index.php?s=IOS/score"
#define PRESENT_URL                 @"http://www.redbullclub.cn/index.php?s=IOS/present"
//#define SIGNOUT_URL                 @""

#define PROFILE_NAV                 @"编辑资料"
#define PASSWORD_NAV                @"修改密码"
#define ADDRESS_NAV                 @"收货地址管理"
#define SCORE_NAV                   @"我的能量值"
#define PRESENT_NAV                 @"已兑换礼品"


@interface Constant : NSObject

@end
