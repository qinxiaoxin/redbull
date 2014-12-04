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
#define TURNTABLE_PAGE  @"http://www.redbullclub.cn/index.php?s=IOS/event"
#define LOGIN_POSTPATH  @"http://www.redbullclub.cn/index.php?s=User/doLoginForIos" //登陆postPath

#define kMenuFullWidth                  320.0f
#define kMenuDisplayedWidth             240.0f
#define kMenuOverlayWidth (self.view.bounds.size.width - kMenuDisplayedWidth)
#define kMenuBounceOffset               10.0f
#define kMenuBounceDuration             .3f
#define kMenuSlideDuration              .3f

#define NAVIGATIONBAR_HEIGHT            44.f

#define TITLE_NAVGATIONBAR      @"红牛能量部落"

#define PI 3.14159265358979323846

@interface Constant : NSObject

@end
