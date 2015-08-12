//
//  URL.h
//  OnePage
//
//  Created by lanouhn on 15/7/27.
//  Copyright (c) 2015年 Lanou. All rights reserved.
//

//网路接口
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kItemWidth (kScreenWidth - 3 * 10) / 2
#define kMainMenuHeaderViewHeight 180

#define kCycleScrollAPI @"http://api.huaban.com/weekly/?"
#define kFirstCollectionCellAPI @"http://api.huaban.com/all/?limit=20"
#define kCollectionCellAPI @"http://api.huaban.com/all/?limit=20&max=%@"

#define kCollectionImageAPI @"http://img.hb.aicdn.com/%@_fw192w"

#define kUserHeaderImageAPI @"http://img.hb.aicdn.com/%@_sq75w"

#define kLifeAPI @"http://api.budejie.com/api/api_open.php?market=tencentyingyongbao&order=new&udid=866190023345301&a=theme_datalist&appname=baisibudejie&pagesize=20&c=topic&os=4.4.4&client=android&theme_id=163&page=%d"

#define kSubLifeAPI @"&visiting=15359200&type=0&mac=38%3Abc%3A1a%3Ac5%3Ae9%3Ade&ver=5.9.8"

#define kDrawImageAPI @"http://api.budejie.com/api/api_open.php?market=tencentyingyongbao&order=new&udid=866190023345301&a=theme_datalist&appname=baisibudejie&pagesize=20&c=topic&os=4.4.4&client=android&theme_id=142&page=%d"

#define kInfoCollectionImageAPI  @"http://api.huaban.com/pins/%@"

#define kMovicAPI @"http://api.budejie.com/api/api_open.php?market=tencentyingyongbao&order=new&udid=866190023345301&a=theme_datalist&appname=baisibudejie&pagesize=20&c=topic&os=4.4.4&client=android&theme_id=57&page=%d"


