//
//  HPlaceHolderTextView.h
//  AFNetworking
//
//  Created by Salvador on 2020/2/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HPlaceHolderTextView : UITextView

/**
 placeholder文字
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 placeholder文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, strong) UIFont *placeholderFont;

-(void)textChanged:(NSNotification*)notification;

@end

NS_ASSUME_NONNULL_END
