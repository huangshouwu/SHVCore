//
//  SVHFileTool.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/9/6.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHFileTool.h"

NSString* SVHSandBoxDocumentPath(void){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

NSString* SVHSandBoxLibarayPath(void){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

NSString* SVHSandBoxCachePath(void){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
   return [paths objectAtIndex:0];
}

NSString* SVHSandBoxPreferencePanesPath(void){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

NSString* SVHSandBoxTempPath(void){
    return NSTemporaryDirectory();
}

NSString* SVHCreateDirectoryInDirectory(NSString* directoryPath,NSString* name){
    if (directoryPath.length && name.length) {
        NSString * rarFilePath = [directoryPath stringByAppendingPathComponent:name];//将需要创建的串拼接到后面
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
        // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
        BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
        if (!existed && !isDir) {//如果文件夹不存在
           BOOL result = [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            if (result) {
                return rarFilePath;
            }
        }else{
            return rarFilePath;
        }
    }
    return nil;
}

@implementation SVHFileTool

+ (NSString*)GJTFileSizeDescription:(float)size{
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleBinary];
}

@end


