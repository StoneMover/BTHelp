//
//  NSString+BTString.h
//  BTHelpExample
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BTString)

/// 返回156*****8016电话
- (NSString*)bt_phoneEncrypt;

/// 是否全部为数字
- (BOOL)bt_isStrAllNumber;

/// 是否为浮点型数据
- (BOOL)bt_isPureFloat;

/// base64 解密
- (NSString*)bt_base64Decode;

/// base64 加密
- (NSString*)bt_base64Encode;

/// md5 加密
- (NSString*)bt_md5;


/// 计算文字高度,传入文字的固定高度、字体、行间距参数
/// @param width 文字的宽度
/// @param font 文字的字体
- (CGFloat)bt_calculateStrHeight:(CGFloat)width font:(UIFont*)font;

/// 计算文字高度,传入文字的固定高度、字体、行间距参数
/// @param width 文字的宽度
/// @param font 文字的字体
/// @param lineSpeace 文字的上下间距
- (CGFloat)bt_calculateStrHeight:(CGFloat)width font:(UIFont*)font lineSpeace:(CGFloat)lineSpeace;


/// 计算文字宽度，传入文字的固定高度
/// @param height 文字的高度
/// @param font 文字的字体
- (CGFloat)bt_calculateStrWidth:(CGFloat)height font:(UIFont*)font;

/// 将json格式字符串转为字典
- (nullable NSDictionary *)bt_toDict;


/// 将json格式字符串转为字典数组
- (nullable NSArray<NSDictionary *> *)bt_toArray;

/// 获取domain（ip）
- (nullable NSString*)bt_host;


/// 获取URL切割后的key-value参数字典
- (NSDictionary*)bt_urlParameters;

/// 随机字符串，默认长度16
+ (NSString*)bt_randomStr;

/// 随机字符串
/// @param lenth 需要的字符串长度
+ (NSString *)bt_randomStrWithLenth:(NSInteger)lenth;

/// 随机数字字符串
/// @param lenth 需要的字符串长度
+ (NSString *)bt_randomNumStrWithLenth:(NSInteger)lenth;

/// 随机大写字母字符串
/// @param lenth  需要的字符串长度
+ (NSString *)bt_randomCapitalStrWithLenth:(NSInteger)lenth;

/// 随机小写字母字符串
/// @param lenth  需要的字符串长度
+ (NSString *)bt_randomLowercaseStrWithLenth:(NSInteger)lenth;


/// 获取随机字符串方法
/// @param lenth 返回长度
/// @param isNumber 是否需要数字
/// @param isCapital 是否需要大写字母
/// @param isLowercase 是否需要小写字母
+ (NSString *)bt_randomStrWithLenth:(NSInteger)lenth isNumber:(BOOL)isNumber isCapital:(BOOL)isCapital isLowercase:(BOOL)isLowercase;


/// 快速将Integer类型转为字符串
/// @param integerValue 具体数字
+ (NSString *)bt_integer:(NSInteger)integerValue;

/// 快速将CGFloat类型转为字符串
/// @param floatValue 具体数字
+ (NSString *)bt_float:(CGFloat)floatValue;

@end

NS_ASSUME_NONNULL_END
