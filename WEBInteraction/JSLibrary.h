//
//  JSLibrary.h
//  WEBInteraction
//
//  Created by CSX on 2017/3/30.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSLibrary : NSObject

//获取当前页面的url
+ (NSString *)locationHref;

//修改界面元素的值
+ (NSString *)getElementsByName:(NSString *)name andValue:(NSString *)value;

//表单提交
+ (NSString *)formsSubmit;

//获取所有的html
+ (NSString *)documentElementInner;

//获取网页title
+ (NSString *)getWebTitle;

//获取网页的一个值
+ (NSString *)getElementById:(NSString *)IDStr;













@end
