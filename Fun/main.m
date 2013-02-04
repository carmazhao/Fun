//
//  main.m
//  Fun
//
//  Created by carmazhao on 12-12-11.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdSageManager.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [[AdSageManager getInstance]setAdSageKey:@"8a1fd2065c0a446da6a06318d875a8fc"];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppController");
    [pool release];

    return retVal;
}
