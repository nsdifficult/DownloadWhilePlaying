//
//  AppDelegate.h
//  DownloadWhilePlaying
//
//  Created by Yi Rongyi on 13-9-27.
//  Copyright (c) 2013年 TRS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTTPServer;
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) HTTPServer *httpServer;
@end
