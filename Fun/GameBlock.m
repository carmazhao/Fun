//
//  GameBlock.m
//  Fun
//
//  Created by carmazhao on 12-12-23.
//
//

#import "GameBlock.h"
#import "GameState.h"

@implementation GameBlock
@synthesize m_coor;
@synthesize m_sprite;
@synthesize m_pass_enable;
@synthesize m_value;
@synthesize m_passed;
@synthesize m_opened;

+(GameBlock *)block{
    return [[[GameBlock alloc]init]autorelease];
}
-(GameBlock*)init{
    if ((self = [super init])) {
        m_pass_enable = YES;
        m_passed = NO;
        m_opened = NO;
        m_value = 0;
    }
    return self;
}
-(void)create_sprite:(NSString *)path{
    m_sprite = [CCSprite spriteWithFile:path];
}

-(void)set_sprite_pos:(CGPoint)pos{
    m_sprite.position = pos;
}
@end
