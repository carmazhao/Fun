//
//  ScrollPageView.h
//  Fun
//
//  Created by carmazhao on 12-12-13.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define MOVE_LEFT   YES
#define MOVE_RIGHT  NO

#define DOT_INTER 20

@interface ScrollPageView : CCLayer {
}
@property(nonatomic , retain)CCLayer *  m_main_layer;
@property(nonatomic)NSInteger   m_unit_width;           //每个页面宽度
@property(nonatomic)NSInteger   m_num_of_pages;         //加进来多少页面

@property(nonatomic)CGPoint     m_pre_touch_pos;
@property(nonatomic)BOOL        m_dir_flag;
@property(nonatomic)CGPoint     m_pre_layer_pos;

@property(nonatomic , retain)NSMutableArray * m_dots_arr; //装小点点
@property(nonatomic , retain)CCSprite *      m_lighted_dot;


+(ScrollPageView* )create_layer;
-(ScrollPageView *)init;

-(void)add_page_view:(CCLayer *)page;
-(BOOL)check_bound:(CGPoint)target;
@end
