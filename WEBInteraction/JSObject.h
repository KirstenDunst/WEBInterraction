//
//  JSObject.h
//  IT008OCAndJS
//
//  Created by lwx on 16/7/28.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol JSObjectDelegate <JSExport>

- (void)openPhotoAlbum;

- (void)showAlertWithTitle:(NSString *)title AndString:(NSString *)string;

@end


@interface JSObject : NSObject <JSObjectDelegate>

@property (nonatomic, assign) id delegate;

@end










