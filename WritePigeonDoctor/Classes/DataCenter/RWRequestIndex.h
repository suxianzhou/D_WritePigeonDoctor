//
//  RWRequestIndex.h
//  ZhongYuSubjectHubKY
//
//  Created by zhongyu on 16/6/21.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#ifndef RWRequestIndex_h
#define RWRequestIndex_h

#ifndef __SERVER_INDEX__
#define __SERVER_INDEX__ @"http://api.zhongyuedu.com/bg/"
#endif

#ifndef __USER_REGISTER__
#define __USER_REGISTER__ __SERVER_INDEX__@"register.php"
#endif

#ifndef __USER_LOGIN__
#define __USER_LOGIN__ __SERVER_INDEX__@"login.php"
#endif

#ifndef __REPLACE_PASSWORD__
#define __REPLACE_PASSWORD__ __SERVER_INDEX__@"change_pwd.php"
#endif

#ifndef __VERIFICATION_CODE__
#define __VERIFICATION_CODE__ @"http://api.zhongyuedu.com/comm/code.php"
#endif

#ifndef __USER_INFORMATION__
#define __USER_INFORMATION__ __SERVER_INDEX__@"age.php"
#endif

#ifndef __OFFICE_LIST__
#define __OFFICE_LIST__ __SERVER_INDEX__@"ks_list.php"
#endif

#ifndef __SEARCH_USER__
#define __SEARCH_USER__ __SERVER_INDEX__@"find_user.php"
#endif

#ifndef __SERVICES_LIST__
#define __SERVICES_LIST__ __SERVER_INDEX__@"find_price.php"
#endif

#ifndef __BULID_ORDER__
#define __BULID_ORDER__ __SERVER_INDEX__@"order.php"
#endif

#ifndef __SEARCH_ORDER__
#define __SEARCH_ORDER__ __SERVER_INDEX__@"find_order.php"
#endif

#ifndef __PROCEEDING_ORDER__
#define __PROCEEDING_ORDER__ __SERVER_INDEX__@"find_nopay.php"
#endif

#ifndef __UPDATE_ORDER__
#define __UPDATE_ORDER__ __SERVER_INDEX__@"change_order.php"
#endif

#ifndef __VISIT__
#define __VISIT__ __SERVER_INDEX__@"find_visit.php"
#endif

#ifndef __UPDATE_VISIT__
#define __UPDATE_VISIT__ __SERVER_INDEX__@"update_home_visit.php"
#endif

#ifndef __VERIFY_DOCTOR__
#define __VERIFY_DOCTOR__ __SERVER_INDEX__@"register_doc.php"
#endif

#endif /* RWRequestIndex_h */
