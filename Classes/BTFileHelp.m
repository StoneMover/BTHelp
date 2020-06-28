//
//  BTFileHelp.m
//  BTHelpExample
//
//  Created by apple on 2020/6/28.
//  Copyright © 2020 stonemover. All rights reserved.
//

#import "BTFileHelp.h"

@implementation BTFileHelp

+ (NSString*)getHomePath{
    return NSHomeDirectory();
}



+ (NSString*)getDocumentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)getCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)getLibraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}


+ (NSString*)getTmpPath{
    NSString *path = NSTemporaryDirectory();
    return path;
}


+ (BOOL)isFileExit:(NSString*)path{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


+ (void)deleteFile:(NSString*)path{
    if ([self isFileExit:path]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"删除%@出错:%@",path,error.domain);
        }
    }
}


+ (void)copyFile:(NSString*)filePath toPath:(NSString*)path isOverride:(BOOL)overrid{
    NSFileManager * mananger=[NSFileManager defaultManager];
    if (overrid) {
        [self deleteFile:filePath];
    }else{
        if ([self isFileExit:path]) {
            return;
        }
    }
    [self deleteFile:path];
    
    NSString * parentPath=[path stringByDeletingLastPathComponent];
    if (![self isFileExit:parentPath]) {
        [self createPath:parentPath];
    }
    
    NSError * error;
    [mananger copyItemAtPath:filePath toPath:path error:&error];
    if (error) {
        NSLog(@"复制%@出错:%@",path,error.domain);
    }
}


+ (void)createPath:(NSString*)path{
    if (![self isFileExit:path]) {
        NSFileManager * fileManager=[NSFileManager defaultManager];
        NSString * parentPath=[path stringByDeletingLastPathComponent];
        if ([self isFileExit:parentPath]) {
            NSError * error;
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        }else{
            [self createPath:parentPath];
            [self createPath:path];
        }
        
    }
}

+ (void)createDocumentPath:(NSString*)path{
    NSString *pathRestul=[NSString stringWithFormat:@"%@/%@",[self getDocumentPath],path];
    [self createPath:pathRestul];
}


+ (NSString*)saveFile:(NSString*)path withFileName:(NSString*)name withData:(NSData*)data{
    return [self saveFile:path withFileName:name withData:data isCover:NO];
}

+ (NSString*)saveFile:(NSString*)path withFileName:(NSString*)name withData:(NSData*)data isCover:(BOOL)cover{
    [self createPath:path];
    NSData * resultData=nil;
    NSString * resultPath=[NSString stringWithFormat:@"%@/%@",path,name];
    if ([self isFileExit:resultPath]&&cover) {
        NSMutableData * dataOri=[NSMutableData dataWithContentsOfFile:resultPath];
        [dataOri appendData:data];
        resultData=dataOri;
    }else{
        resultData=data;
    }
    
    [[NSFileManager defaultManager] createFileAtPath:resultPath contents:resultData attributes:nil];
    
    return [NSString stringWithFormat:@"%@/%@",path,name];
}

+ (NSString*)getCachePic{
    NSString * pic=[NSString stringWithFormat:@"%@/pic",[self getCachePath]];
    if (![self isFileExit:pic]) {
        [self createPath:pic];
    }
    
    return pic;
}
+ (NSString*)getCacheVideo{
    
    NSString * video =[NSString stringWithFormat:@"%@/video",[self getCachePath]];
    if (![self isFileExit:video]) {
        [self createPath:video];
    }
    
    return video;
}

+ (NSString*)getCacheVoice{
    NSString * voice=[NSString stringWithFormat:@"%@/voice",[self getCachePath]];
    if (![self isFileExit:voice]) {
        [self createPath:voice];
    }
    return voice;
}


+ (NSArray*)getFolderAllFileName:(NSString*)folderPath fileType:(NSString*)fileType{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:folderPath];  //baseSavePath 为文件夹的路径
    NSMutableArray *filePathArray = [[NSMutableArray alloc]init];   //用来存目录名字的数组
    NSString *file;
    while((file=[myDirectoryEnumerator nextObject]))     //遍历当前目录
    {
        if (fileType) {
            if([[file pathExtension] isEqualToString:fileType])  //取得后缀名为.xml的文件名
            {
                [filePathArray addObject:file];
            }
        }else{
            [filePathArray addObject:file];
        }
        
    }
    return filePathArray;
}

@end
