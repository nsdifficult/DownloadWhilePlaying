//
//  FileTools.h
//  TibetVoiceDemo
//
//  Created by Yi Rongyi on 13-6-24.
//  Copyright (c) 2013年 Yi Rongyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DOWNLOAD_CACHE_PATH [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"Incomplete"]

@interface FileTools : NSObject

+ (NSString *)applicationFilePath;
+ (NSString *)tmpDirectory;




+ (NSString *)fileNameFromUrl:(NSString *)urlStr;
+ (NSString *)videoCachePathFromUrl:(NSString *)urlStr;

//边播放边下载，保存文件的大小
+ (void)saveFileSize:(UInt64)size url:(NSString *)urlStr;
+ (UInt64)fileSizeWithUrl:(NSString *)urlStr;

@end
