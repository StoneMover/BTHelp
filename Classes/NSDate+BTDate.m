//
//  NSDate+BTDate.m
//  live
//
//  Created by stonemover on 2019/5/8.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "NSDate+BTDate.h"

@implementation NSDate (BTDate)

- (NSInteger)year{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents  * components  =  [calendar components: NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSInteger)month{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents  * components  =  [calendar components: NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)day{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents  * components  =  [calendar components: NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSInteger)calculateAge:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSInteger age =[self year]-year;
    if (month>[self month]) {
        age--;
    }else if (month==[self month]){
        if (day>[self day]) {
            age--;
        }
    }
    
    return age;
}

- (BOOL)isFutureTime:(NSDate*)date{
    NSDate * currentDate=[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: currentDate];
    NSDate *localeDate = [currentDate dateByAddingTimeInterval: interval];
    NSDate * resultDate=[localeDate laterDate:date];
    if ([resultDate isEqualToDate:localeDate]) {
        return NO;
    }
    return YES;
}


- (NSString*)dateFromNowStr{
    NSDate * d= self;
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate * dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSTimeInterval cha=now-late;
    int second=cha;
    int minute=second/60;
    int hour=minute/60;
    int day=hour/24;
    if (day!=0) {
        if (day>30) {
            return [NSString stringWithFormat:@"%d月前",day/30];
        }
        
        if (day>365) {
            return [NSString stringWithFormat:@"%d年前",day/365];
        }
        
        return [NSString stringWithFormat:@"%d天前",day];
    }
    if (hour!=0) {
        return [NSString stringWithFormat:@"%d小时前",hour];
    }
    if (minute!=0) {
        return [NSString stringWithFormat:@"%d分钟前",minute];
    }
    return @"刚刚";
}

- (NSString*)dateStr:(NSString*)formater{
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat=formater;
    return [formatter stringFromDate:self];
}

+ (NSDate*)dateYMD:(NSString*)dateStr{
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"YYYY-MM-dd";
    return [formatter dateFromString:dateStr];
}



+ (NSDate*)dateYMDHMS:(NSString*)dateStr{
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"YYYY-MM-dd HH:mm:ss";
    return [formatter dateFromString:dateStr];
}


+ (NSDate*)dateYMDHM:(NSString*)dateStr{
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"YYYY-MM-dd HH:mm";
    return [formatter dateFromString:dateStr];
}

+ (NSDate*)dateFromStr:(NSString*)dateStr formatter:(NSString*)formatterStr{
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat=formatterStr;
    return [formatter dateFromString:dateStr];
}


@end
