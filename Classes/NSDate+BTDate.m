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

- (BOOL)isFutureTime{
    NSDate * currentDate=[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: currentDate];
    NSDate *localeDate = [currentDate dateByAddingTimeInterval: interval];
    if (self.timeIntervalSince1970 > localeDate.timeIntervalSince1970) {
        return YES;
    }
    return NO;
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
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    formatter.dateFormat=formater;
    NSString * str = [formatter stringFromDate:self];
    return str;
}

+ (NSDate*)initLocalDate{
    NSDate * date = [[NSDate alloc] init];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate * localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

+ (NSDate*)dateYMD:(NSString*)dateStr{
    return [self dateFromStr:dateStr formatter:@"YYYY-MM-dd"];
}



+ (NSDate*)dateYMDHMS:(NSString*)dateStr{
    return [self dateFromStr:dateStr formatter:@"YYYY-MM-dd HH:mm:ss"];
}


+ (NSDate*)dateYMDHM:(NSString*)dateStr{
    return [self dateFromStr:dateStr formatter:@"YYYY-MM-dd HH:mm"];
}

+ (NSDate*)dateFromStr:(NSString*)dateStr formatter:(NSString*)formatterStr{
    NSDateFormatter * formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat=formatterStr;
    NSDate * date = [formatter dateFromString:dateStr];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate * localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}


@end
