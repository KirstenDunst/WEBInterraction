//
//  JSObject.m
//  IT008OCAndJS
//
//  Created by lwx on 16/7/28.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import "JSObject.h"

@implementation JSObject


- (void)showAlertWithTitle:(NSString *)title AndString:(NSString *)string {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:string preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel");
        }];
        
        [alert addAction:action];
        
        [self.delegate presentViewController:alert animated:YES completion:nil];
    });
    
    
    
    
}


- (void)openPhotoAlbum {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self.delegate;
    
    [self.delegate presentViewController:picker animated:YES completion:nil];
}

@end







