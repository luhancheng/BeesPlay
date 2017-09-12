//
//  AppUtils.h
//  goujiawang
//
//  Created by iPhone on 15/7/10.
//  Copyright (c) 2015年 iPhone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Common.h"

@interface AppUtils : NSObject


#pragma mark - pull to refresh

/**
 *  添加头部刷新
 *
 *  @param table  要添加的tableView
 *  @param target 执行方法的类
 *  @param a1     事件
 */
+ (void)setupRefreshHeader:(UITableView *)table target:(id)target header:(SEL)a1;

/**
 *  添加尾部刷新
 *
 *  @param table  要添加的tableView
 *  @param target 执行方法的类
 *  @param a2     事件
 */
+ (void)setupRefreshFooter:(UITableView *)table target:(id)target footer:(SEL)a2;

/**
 *  添加头部刷新
 *
 *  @param collectionView  要添加的collectionView
 *  @param target 执行方法的类
 *  @param a1     事件
 */
+ (void)setupCollectionViewRefreshHeader:(UICollectionView *)collectionView target:(id)target header:(SEL)a1;
/**
 *  添加尾部刷新
 *
 *  @param collectionView  要添加的collectionView
 *  @param target 执行方法的类
 *  @param a2     事件
 */
+ (void)setupCollectionViewRefreshFooter:(UICollectionView *)collectionView target:(id)target footer:(SEL)a2;

/**
 *  计算宽高
 *
 *  @param myString 传入的字符串
 *  @param myFont   传入的字体
 *  @param size     限制的大小
 *
 *  @return 结果rect
 */
+ (CGRect)widthForString:(NSString *)myString font:(UIFont *)myFont size:(CGSize)size;

/**
 *  计算宽高
 *
 *  @param string 传入的字符串
 *  @param font   传入的字体
 *  @param size   限制的大小
 *
 *  @return 结果 rect
 */
+ (CGRect)boundingRectWithSizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size;

/**
 *  时间戳转年月日
 *
 *  @param string 传入的字符串
 *
 *  @return 结果 backStr
 */
+ (NSString *)changeDateTime:(NSString *)string;

/**
 *  时间戳--》刚刚/几分钟前/几小时前/年月日
 *
 *  @param string 传入的字符串
 *
 *  @return 结果 backStr
 */
+ (NSString *)changeTime:(NSString *)string;

@end
