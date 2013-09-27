//
//  FileTools.m
//  TibetVoiceDemo
//
//  Created by Yi Rongyi on 13-6-24.
//  Copyright (c) 2013年 Yi Rongyi. All rights reserved.
//

#import "FileTools.h"

#define USERDEFAULTS_KEY_ARRAY_FILE_SIZE @"USERDEFAULTS_KEY_ARRAY_FILE_SIZE"
@implementation FileTools



+ (NSString *)applicationFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (NSString *)tmpDirectory {
    NSString *tmpDir = [[[self applicationFilePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"tmp"];
    return tmpDir;
}

+ (NSString *)fileNameFromUrl:(NSString *)urlStr {
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSString *filename = [[[URL path] lastPathComponent] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return filename;
}


+ (NSString *)videoCachePathFromUrl:(NSString *)urlStr{
    NSString *downloadDestinationPath = [DOWNLOAD_CACHE_PATH stringByAppendingPathComponent:[FileTools fileNameFromUrl:urlStr]];
    return downloadDestinationPath;
}



+ (void)saveFileSize:(UInt64)size url:(NSString *)urlStr{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dicUD = [defaults objectForKey:USERDEFAULTS_KEY_ARRAY_FILE_SIZE];
    if (dicUD == nil) {
        dicUD = [NSMutableDictionary dictionary];
    }
    [dicUD setObject:[NSNumber numberWithLongLong:size] forKey:urlStr];
    
    [defaults setObject:dicUD forKey:USERDEFAULTS_KEY_ARRAY_FILE_SIZE];
}
+ (UInt64)fileSizeWithUrl:(NSString *)urlStr{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dicUD = [defaults objectForKey:USERDEFAULTS_KEY_ARRAY_FILE_SIZE];
    NSNumber *number = [dicUD objectForKey:urlStr];
    if (number) {
        return [number longLongValue];
    }else{
        return 0;
    }
}


@end
