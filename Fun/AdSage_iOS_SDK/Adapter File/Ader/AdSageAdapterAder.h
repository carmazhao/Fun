//
//  AdSageAdapterAder.h
//  adsage_test
//
//  Created by Chen Meisong on 12-6-14.
//  Copyright (c) 2012年 AppFactory. All rights reserved.
//

//ader v1.0.6
#import <Foundation/Foundation.h>
#import "AdSageAdapter.h"
#import "AderDelegateProtocal.h"

@interface AdSageAdapterAder : AdSageAdapter<AderDelegateProtocal>{
    @private
    NSTimer *timer;
}
@end
