//
//  JSLibrary.m
//  WEBInteraction
//
//  Created by CSX on 2017/3/30.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "JSLibrary.h"

@implementation JSLibrary

+ (NSString *)locationHref{
    return @"document.location.href";
}

+ (NSString *)getElementsByName:(NSString *)name andValue:(NSString *)value{
    return [NSString stringWithFormat:@"document.getElementsByName('%@')[0].value='%@';",name,value];
}

+ (NSString *)formsSubmit{
    return @"document.forms[0].submit();";
}

+ (NSString *)documentElementInner{
    return @"document.documentElement.innerHTML";
}

+ (NSString *)getWebTitle{
    return @"document.title";
}


+ (NSString *)getElementById:(NSString *)IDStr{
    return [NSString stringWithFormat:@"document.getElementById('%@').innerText",IDStr];
}







@end
