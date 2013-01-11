//
//  ControlCreater.m
//  Fun
//
//  Created by carmazhao on 13-1-11.
//
//

#import "ControlCreater.h"
#import "GameState.h"

static ControlCreater * m_inst;
@implementation ControlCreater
+(ControlCreater*)get_instance {
    if (m_inst == nil) {
        m_inst = [[ControlCreater alloc]init];
    }
    return  m_inst;
}

-(ControlCreater *)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(CCMenu *)create_simple_button:(NSString *)normal_path :(NSString *)down_path :(id)target :(SEL)selector{
    CCSprite * btn_normal = [CCSprite spriteWithFile:normal_path];
    btn_normal.scale = ([GameState get_instance]).m_scale;
    btn_normal.contentSize = CGSizeMake(btn_normal.contentSize.width * [GameState get_instance].m_scale, btn_normal.contentSize.height*[GameState get_instance].m_scale);
    
    CCSprite * btn_down = [CCSprite spriteWithFile:down_path];
    btn_down.scale = ([GameState get_instance]).m_scale;
    btn_down.contentSize = CGSizeMake(btn_down.contentSize.width * [GameState get_instance].m_scale, btn_down.contentSize.height*[GameState get_instance].m_scale);
    btn_down.color = ccYELLOW;
    
    CCMenuItemSprite * btn_item = [CCMenuItemSprite itemWithNormalSprite:btn_normal selectedSprite:btn_down target:target selector:selector];
    
    CCMenu * menu = [CCMenu menuWithItems:btn_item , nil];
    return menu;
}
@end
