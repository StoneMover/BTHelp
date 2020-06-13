# BTHelp

开发中常用的一些工具类

## BTModel

一个自动的```json```解析```model```，继承于该类写上对象的```json```属性即可

### TestModel.h

```
#import "BTModel.h"

@class TestChildModel;

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : BTModel

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) TestChildModel * child;

@property (nonatomic, strong) NSMutableArray * childs;

@end

@interface TestChildModel : BTModel

@property (nonatomic, strong) NSString * content;

@end

NS_ASSUME_NONNULL_END

```

### TestModel.m

```
#import "TestModel.h"

@implementation TestModel

- (void)initSelf{
    [super initSelf];
    self.classDict = @{@"child":TestChildModel.class,@"childs":TestChildModel.class};
}

@end


@implementation TestChildModel



@end

```
解析

```
NSDictionary * dict = @{@"title":@"三国演义",@"child":@{@"content":@"东汉末年"},@"childs":@[@{@"content":@"分三国"},@{@"content":@"烽火连天不休"}]};
TestModel * model = [TestModel modelWithDict:dict];
NSLog(@"下个断点看有没有解析成功");
```

如果是字典的数组那么调用这个方法返回一个数组的```model```

```
+(NSMutableArray*)modelWithArray:(NSArray*)array;
```

同样支持将```model```转化为字典数据

```
-(NSDictionary*)autoDataToDictionary;
```

## NSDate+BTDate.h

提供更方便的```NSDate```对象的使用方式

初始化，根据时区获取对应的date，避免中国时区少```8```小时的问题

```
+ (instancetype)initLocalDate;
```

```NSDateFormatter```初始化方式

```
//传入2010-01-01 这个字符串获取date
+ (NSDate*)dateYMD:(NSString*)dateStr;

//传入2010-01-01 13:04:34 这个字符串获取date
+ (NSDate*)dateYMDHMS:(NSString*)dateStr;

//传入2010-01-01 13:04 这个字符串获取date
+ (NSDate*)dateYMDHM:(NSString*)dateStr;

//传入日期,以及格式化样式获取date
+ (NSDate*)dateFromStr:(NSString*)dateStr formatter:(NSString*)formatterStr;
```

获取格式化字符串

```
- (NSString*)dateStr:(NSString*)formater;
```

其它快捷方法

```
- (NSString*)year;

- (NSString*)month;

- (NSString*)day;

//英文的周几字符串
- (NSString*)weekDay;

//数字周几，0是周日
- (NSInteger)weekDayNum;

//传入头部字符串如周和星期，如果传回周会返回周一、周二..周日等字符串，传星期会返回星期一、星期二..星期天字符串
- (NSString*)weekDayNumStrWithHead:(NSString*)head;

//计算年龄,生成当前date类,传入年月日即可
- (NSInteger)calculateAge:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

//是否是未来时间
- (BOOL)isFutureTime;

//得到距离系统当前时间的显示时间,比如一小时前,三分钟前,时间格式:yyyy-MM-dd HH:mm:ss
- (NSString*)dateFromNowStr;
```

## BTTimerHelp

一个基于```NSTimer```封装的计时器，如果你需要精准的计时器功能，使用```gcd```，该类会提供快捷的开始、暂停、结束、重设计时器回调间隔功能

```
self.timer = [[BTTimerHelp alloc]init];
self.timer.changeTime = 1;
//每隔一秒回调一次
self.timer.block = ^{
               
};
[self.timer start];
```

暂停

```
[self.timer pause];
```

如果你需要在某一刻改变计时间隔

```
self.timer.changeTime = 3;
[self.timer start];
```

用完之后记得销毁

```
[self.timer stop];
```

## BTIconHelp

快速选取头像辅助类，相册、相机权限自己在```info.plist```中添加，权限问题也会在内部自己判断处理

初始化使用

```
self.iconHelp = [[BTIconHelp alloc] init:self];
self.iconHelp.block = ^(UIImage *image) {
                    
};
[self.iconHelp go];
```



