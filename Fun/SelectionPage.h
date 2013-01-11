//
//  SelectionPage.h
//  Fun
//
//  Created by carmazhao on 12-12-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "RoundSelectionMeta.h"

@interface SelectionPage : CCLayerColor {
}
@property(nonatomic , retain)RoundSelectionMeta * m_meta;   //本页数据集
@property(nonatomic , retain)NSMutableArray *   m_level_arr;    //装小心按钮
@property(nonatomic)NSInteger                   m_page_num;     //本页页号
@property(nonatomic)BOOL                        m_touch_locked;//是否点击后移动了手指

+(SelectionPage *)create_page:(RoundSelectionMeta *)meta:(NSInteger)page_num;
-(SelectionPage *)initWithMeta:(RoundSelectionMeta *)meta:(NSInteger)page_num;
@end
