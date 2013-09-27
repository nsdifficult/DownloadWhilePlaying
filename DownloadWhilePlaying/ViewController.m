//
//  ViewController.m
//  DownloadWhilePlaying
//
//  Created by Yi Rongyi on 13-9-27.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "FileTools.h"
#import "AFDownloadRequestOperation.h"

#define URL_TEST_RATE_1 @"http://ia700204.us.archive.org/2/items/Pbtestfilemp4videotestmp4/video_test.mp4"


@interface ViewController ()
{
    BOOL _flag;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self cacheVideoWithUrl:URL_TEST_RATE_1];
   
}
- (void)setPlayerWithUrl:(NSURL *)url {
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.moviePlayerController.scalingMode = MPMovieScalingModeAspectFit;
    self.moviePlayerController.repeatMode = MPMovieRepeatModeNone;
    self.moviePlayerController.shouldAutoplay = YES;
    self.moviePlayerController.controlStyle = MPMovieControlStyleEmbedded;
    self.moviePlayerController.fullscreen = NO;
    [self.moviePlayerController.view setFrame:CGRectMake(10, 10, 300, 400)];
    [self.moviePlayerController play];
    [self.view addSubview:self.moviePlayerController.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cacheVideoWithUrl:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
    
    AFDownloadRequestOperation *afDoperation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:[FileTools videoCachePathFromUrl:urlStr] shouldResume:YES];
    
    [afDoperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file ");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    NSString *tmpFilename = [afDoperation.tempPath lastPathComponent];
    NSString *tmpFilePath = afDoperation.tempPath;
    [afDoperation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        NSLog(@"%lli/%lli",totalBytesReadForFile,totalBytesExpectedToReadForFile);
        if (!_flag) {
            NSString *str = [NSString stringWithFormat:@"http://localhost:8081/%@",tmpFilename];
            [FileTools saveFileSize:totalBytesExpectedToReadForFile url:tmpFilePath];
            NSURL *url = [NSURL URLWithString:str];
            
            [self setPlayerWithUrl:url];
            _flag = YES;
        }
        
        
    }];
    [afDoperation start];
    
}
@end
