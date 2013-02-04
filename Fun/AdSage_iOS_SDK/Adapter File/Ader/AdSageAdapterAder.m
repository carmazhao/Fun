//
//  AdSageAdapterAder.m
//  adsage_test
//
//  Created by Chen Meisong on 12-6-14.
//  Copyright (c) 2012年 AppFactory. All rights reserved.
//

#import "AdSageAdapterAder.h"
#import "AdSageView.h"
#import "AdSageManager.h"
#import "AderSDK.h"
static AdSageAdapterAder *Aderdelegate = nil;
static CGRect adSizeList(AdSageBannerAdViewSizeType bannerAdViewSize)
{
    switch (bannerAdViewSize) {
        case AdSageBannerAdViewSize_320X50:
            return CGRectMake(0.0, 0.0, 320.0, 50.0);
            break;
        case AdSageBannerAdViewSize_748X110:
            return CGRectMake(0.0, 0.0, 728.0, 90.0);
            break;
        default:
            return CGRectZero;
    }
}

@implementation AdSageAdapterAder

+ (void)load {
    [[AdSageManager getInstance] registerClass:self];
}

+ (AdSageAdapterType)adapterType {
    return AdSageAdapterTypeAder;
}

+ (BOOL)hasBannerSize:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (!CGRectEqualToRect(adSizeList(bannerAdViewSize), CGRectZero)) {
        return YES;
    }
    return NO;
}

+ (BOOL)hasFullScreen
{
    return NO;
}

- (void)getBannerAd:(AdSageBannerAdViewSizeType)bannerAdViewSize
{
    if (![[self class] hasBannerSize:bannerAdViewSize]) {
        return;
    }
    
    timer = [[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadAdTimeOut:) userInfo:nil repeats:NO] retain];
    
    NSString *publisherID = [self getPublisherId];
    CGRect frame = adSizeList(bannerAdViewSize);
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    [AderSDK setDelegate:nil];
    [AderSDK stopAdService];
    [AderSDK startAdService:bgView appID:publisherID adFrame:frame model:([self isTestMode] ? MODEL_TEST:MODEL_RELEASE)]; 
    [AderSDK setDelegate:self];
    Aderdelegate = self;
    self.adNetworkView = bgView;
    [bgView release];
}

- (void)stopBeingDelegate {
}

- (void)stopTimer {
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    if (Aderdelegate == self) {
        [AderSDK setDelegate:nil];
        Aderdelegate = nil;
        [AderSDK stopAdService];
    }
}

- (void)dealloc {
	[super dealloc];
}

- (void)loadAdTimeOut:(NSTimer*)theTimer {
    [self stopTimer];
    [self stopBeingDelegate];
    [_adSageView adapter:self didFailAd:nil];
}

#pragma mark implement AderDelegateProtocal method

//成功接收并显示新广告后调用，count表示当前广告是第几条广告，SDK启动后从1开始，累加计数
- (void)didSucceedToReceiveAd:(NSInteger)count
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [_adSageView adapter:self didReceiveAdView:self.adNetworkView];
}

/*
 接受SDK返回的错误报告
 code 1: 参数错误
 code 2: 服务端错误
 code 3: 应用被冻结
 code 4: 无合适广告
 code 5: 应用账户不存在
 code 6: 频繁请求
 */
- (void) didReceiveError:(NSError *)error
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [_adSageView adapter:self didFailAd:self.adNetworkView];
}

@end
