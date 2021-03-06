//
//  AppDelegate.h
//  Fun
//
//  Created by carmazhao on 12-12-11.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "AdSageView.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate , AdSageDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
