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
#define FORGETPASSWORD_URL  @"http://www.redbullclub.cn/index.php?s=IOS/forgetPassword"
#define HTML5_APP_URL_1 @"http://redbullclub.cn/index.php?s=M"
#define BAIDU_OPEN_API  @"http://openapi.baidu.com/widget/social"
#define SAVE_ADDRESS    @"http://www.redbullclub.cn/index.php?s=User/doSaveAddressForAppIos"

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
#define FORGET_NAV                  @"找回密码"
#define QQLOGIN_NAV                 @"QQ登陆"
#define WEIBOLOGIN_NAV              @"微博登陆"

#define SHARE_WEIBO                 @"http://v.t.sina.com.cn/share/share.php?appkey=&url=http://www.redbullclub.cn/download/RedbullClup.beta1.0.apk&title=能量部落，你的能量超乎你想象。分享内容&source=&sourceUrl=&content=utf-8&pic=http://www.redbullclub.cn/uploads/banner/20141109/165754_487picture.jpg"
#define SHARE_RENREN                @"http://widget.renren.com/dialog/share?resourceUrl=http://www.redbullclub.cn/download/RedbullClup.beta1.0.apk&pic=http://www.redbullclub.cn/uploads/banner/20141109/165754_487picture.jpg&title=能量部落——你的能量超乎你想象&description=能量部落，你的能量超乎你想象。分享内容"
#define SHARE_DOUBAN                @"http://www.douban.com/share/service?image=http://www.redbullclub.cn/uploads/banner/20141109/165754_487picture.jpg&href=http://www.redbullclub.cn/download/RedbullClup.beta1.0.apk&name=能量部落，你的能量超乎你想象。分享内容"
#define SHARE_QQZONE                @"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=http://www.redbullclub.cn/download/RedbullClup.beta1.0.apk&title=能量部落——你的能量超乎你想象&summary=能量部落，你的能量超乎你想象。分享内容&desc=&site=&sourceUrl=&content=utf-8&pics=http://www.redbullclub.cn/uploads/banner/20141109/165754_487picture.jpg"
#define SHARE_KAIXIN                @"http://www.kaixin001.com/login/open_login.php?flag=1&url=%2Frest%2Frecords.php%3Fcontent%3D%25E8%2583%25BD%25E9%2587%258F%25E9%2583%25A8%25E8%2590%25BD%25EF%25BC%258C%25E4%25BD%25A0%25E7%259A%2584%25E8%2583%25BD%25E9%2587%258F%25E8%25B6%2585%25E4%25B9%258E%25E4%25BD%25A0%25E6%2583%25B3%25E8%25B1%25A1%25E3%2580%2582%25E5%2588%2586%25E4%25BA%25AB%25E5%2586%2585%25E5%25AE%25B9%26url%3Dhttp%3A%2F%2Fwww.redbullclub.cn%2Fdownload%2FRedbullClup.beta1.0.apk%26starid%3D0%26aid%3D0%26style%3D11%26pic%3Dhttp%3A%2F%2Fwww.redbullclub.cn%2Fuploads%2Fbanner%2F20141109%2F165754_487picture.jpg"
#define SHARE_TAOBAO                @"https://login.taobao.com/member/login.jhtml?redirect_url=http%3A%2F%2Fshare.jianghu.taobao.com%2Fshare%2FaddShare.htm%3Ftitle%3D%25E8%2583%25BD%25E9%2587%258F%25E9%2583%25A8%25E8%2590%25BD%25E2%2580%2594%25E2%253F%25E4%25BD%25A0%25E7%259A%2584%25E8%2583%25BD%25E9%2587%258F%25E8%25B6%2585%25E4%25B9%258E%25E4%25BD%25A0%25E6%2583%25B3%25E8%25B1%253F%26pic%3Dhttp%253A%252F%252Fwww.redbullclub.cn%252Fuploads%252Fbanner%252F20141109%252F165754_487picture.jpg%26url%3Dhttp%253A%252F%252Fwww.redbullclub.cn%252Fdownload%252FRedbullClup.beta1.0.apk%26content%3D%25E8%2583%25BD%25E9%2587%258F%25E9%2583%25A8%25E8%2590%25BD%25EF%25BC%258C%25E4%25BD%25A0%25E7%259A%2584%25E8%2583%25BD%25E9%2587%258F%25E8%25B6%2585%25E4%25B9%258E%25E4%25BD%25A0%25E6%2583%25B3%25E8%25B1%25A1%25E3%2580%2582%25E5%2588%2586%25E4%25BA%25AB%25E5%2586%2585%25E5%25AE%253F"
#define SHARE_QQ                    @"http://share.v.t.qq.com/index.php?c=share&a=index&title=能量部落，你的能量超乎你想象。分享内容&url=http://www.redbullclub.cn/download/RedbullClup.beta1.0.apk&appkey=&site={url}&pic=http://www.redbullclub.cn/uploads/banner/20141109/165754_487picture.jpg"

#define REGISTER_POSTPATH           @"http://www.redbullclub.cn/index.php?s=User/doRegIos"
#define VALIDATION_POSTPATH         @"http://www.redbullclub.cn/index.php?s=User/doSendVcode"

#define REGEX_EMAIL                 @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD              @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE                 @"1[3|5|7|8|][0-9]{9}"

#define APP_ID                      @"https://itunes.apple.com/us/app/hong-niu-neng-liang-bu-luo/id947297356?ls=1&mt=8"

#define LOGIN_INDEX                 @"http://www.redbullclub.cn/index.php?s=IOS/login"
#define WHAT_LOGIN_INDEX            @"http://www.redbullclub.cn/?s=IOS/login"

#define JSON_TAB                    @"http://redbullclub.cn/public/nav.json"

#define LOGIN_QQ                    @"http://xui.ptlogin2.qq.com/cgi-bin/xlogin?appid=716027609&pt_3rd_aid=101150460&style=35&s_url=http%3A%2F%2Fconnect.qq.com&refer_cgi=authorize&which=&response_type=code&client_id=101150460&redirect_uri=http://www.redbullclub.cn/index.php/User/oauth2Callback?type=20&state=840d97157fe8d45d17fb3b3dd0417b9f&scope=get_user_info,add_share,add_t,add_pic_t,get_info"
#define LOGIN_WEIBO                 @"https://api.weibo.com/oauth2/authorize?client_id=584608733&redirect_uri=http%3A%2F%2Fredbullclub.cn%2Findex.php%2FUser%2Foauth2Callback%3Ftype%3D2&response_type=code&display=default"
#define LOGIN_WEIBO_SUCCESS   @"http://redbullclub.cn/index.php/User/oauth2Callback?type=2&code"

#define STATEMENT_TITLE             @"重要声明"
#define STATEMENT_DES               @"红牛能量部落在此声明，您通过本软件参加的商业活动，与Apple Inc.无关。商品一经兑换，一律不退还能量值。"

@interface Constant : NSObject

@end
