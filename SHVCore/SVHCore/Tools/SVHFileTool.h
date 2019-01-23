//
//  GJTFileTool.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/9/6.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 文件管理工具 */

/**
 一般需要持久的数据都放在此目录中，可以在当中添加子文件夹，iTunes备份和恢复的时候，会包括此目录
 @return 沙盒Document目录
 */
NSString* GJTSandBoxDocumentPath(void);

/**
 设置程序的默认设置和其他状态信息，iTunes会自动备份该目录，例如杂志、新闻、地图应用使用的数据库缓存文件和可下载内容应该保存到这个文件夹。一般可以重新下载或者重新生成的数据应该保存在 <Application_Home>/Library/Caches 目录下面
 @return 沙盒Libaray目录
 */
NSString* GJTSandBoxLibarayPath(void);

/**
 存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除。一般存放体积比较大，不是特别重要的资源
 @return 沙盒Cache目录
 */
NSString* GJTSandBoxCachePath(void);

/**
 保存应用的所有偏好设置，ios的Settings（设置）应用会在该目录中查找应用的设置信息，iTunes会自动备份该目录
 @return 沙盒PreferencePanes目录
 */
NSString* GJTSandBoxPreferencePanesPath(void);

/**
 创建临时文件的目录，当iOS设备重启时，文件会被自动清除，只是临时使用的数据应该保存到 <Application_Home>/tmp 文件夹。iCloud 不会备份这些文件，下次启动应用自动删除
 @return 沙盒Temp目录
 */
NSString* GJTSandBoxTempPath(void);

/**
 在指定目录下面创建子目录

 @param directoryPath 指定目录路径
 @param name 子目录名
 @return 完整目录路径，如果返回nil，则创建失败
 */
NSString* GJTCreateDirectoryInDirectory(NSString* directoryPath,NSString* name);


@interface GJTFileTool : NSObject

+ (NSString*)GJTFileSizeDescription:(float)size;

@end
