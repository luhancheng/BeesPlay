//
//  AppUtils.m
//  goujiawang
//
//  Created by iPhone on 15/7/10.
//  Copyright (c) 2015年 iPhone. All rights reserved.
//

#import "AppUtils.h"
#import "MJRefresh.h"
@implementation AppUtils
+ (void)setupRefreshHeader:(UITableView *)table target:(id)target header:(SEL)a1 {

    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:a1];
    

    // 设置文字
    [header setTitle:@"下拉准备刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10];
    
    header.stateLabel.hidden  =YES;
    header.lastUpdatedTimeLabel.hidden =YES;
    // 设置颜色
//    header.stateLabel.textColor = MAINCOLOR;
//    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    
    
       // 设置footer
    table.mj_header = header;
    //table.header = header;//
    
    
}

+ (void)setupRefreshFooter:(UITableView *)table target:(id)target footer:(SEL)a2 {
    
//    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:a2];
//
//    
//    // 设置文字
//    [footer setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
//    [footer setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
//    [footer setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:a2];
    
    // 禁止自动加载
    footer.automaticallyRefresh = YES;
    
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:10];
    
    
    // 设置颜色
    footer.stateLabel.textColor = MAINCOLOR;
 
    
    // 设置footer
    //table.footer = footer;
    table.mj_footer  = footer;
    
}

+ (void)setupCollectionViewRefreshHeader:(UICollectionView *)collectionView target:(id)target header:(SEL)a1 {
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:a1];
    
    
    // 设置文字
    [header setTitle:@"下拉准备刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10];
    
    header.stateLabel.hidden  =YES;
    header.lastUpdatedTimeLabel.hidden =YES;
    // 设置颜色
    //    header.stateLabel.textColor = MAINCOLOR;
    //    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    
    
    // 设置footer
    //collectionView.header = header;
    collectionView.mj_header = header;
    
    
}

+ (void)setupCollectionViewRefreshFooter:(UICollectionView *)collectionView target:(id)target footer:(SEL)a2 {
    
    //    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:a2];
    //
    //
    //    // 设置文字
    //    [footer setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    //    [footer setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    //    [footer setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:a2];
    
    // 禁止自动加载
    footer.automaticallyRefresh = YES;
    
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:10];
    
    
    // 设置颜色
    footer.stateLabel.textColor = MAINCOLOR;
    
    
    // 设置footer
    //collectionView.footer = footer;
    collectionView.mj_footer = footer;
    
}

+ (CGRect)widthForString:(NSString *)myString font:(UIFont *)myFont size:(CGSize)size
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:myString];
    [attributedText addAttribute:NSFontAttributeName value:myFont
                           range:NSMakeRange(0, [attributedText length])];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    CGRect boundingRect = [attributedText boundingRectWithSize:size
                                                       options:options
                                                       context:nil];
    return boundingRect;
}

+ (CGRect)boundingRectWithSizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size{

   CGRect rect =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |
     NSStringDrawingUsesFontLeading  attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect;
}

+ (NSString *)changeDateTime:(NSString *)string
{
    NSString *backStr;
    
    double publishLong = [string doubleValue];
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:publishLong/1000];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    publishDate = [publishDate  dateByAddingTimeInterval:interval];
    
    backStr = [formatter stringFromDate:publishDate];
    
    return backStr;
}

+ (NSString *)changeTime:(NSString *)string
{
    NSDate *datas = [NSDate date];
    NSInteger minutes = [datas minutesAfterNumWithTimestamp:string];
    
    NSString *backStr;
    if (minutes < 1) {
        backStr = @"刚刚";
    }else if (minutes < 60){
        backStr = [NSString stringWithFormat:@"%ld分钟前",(long)minutes];
    }else if (minutes < 60*24){
        backStr = [NSString stringWithFormat:@"%ld小时前",minutes/60];
    }else{
        
//        backStr = [NSString stringWithFormat:@"%ld天前",minutes/(60*24)];
        
        double publishLong = [string doubleValue];
        NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:publishLong/1000];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:date];
        publishDate = [publishDate  dateByAddingTimeInterval:interval];
        
        backStr = [formatter stringFromDate:publishDate];
    }
    
    return backStr;
}

@end
