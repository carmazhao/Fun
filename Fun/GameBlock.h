//
//  GameBlock.h
//  Fun
//
//  Created by carmazhao on 12-12-23.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameBlock : NSObject
@property(nonatomic , retain)CCSprite * m_sprite;
@property(nonatomic)CGPoint             m_coor;
@property(nonatomic)NSInteger           m_passed;//手否被手指划过
@property(nonatomic)BOOL                m_pass_enable;//可否被划过
@property(nonatomic)BOOL                m_opened;//炸弹模式中 是否已翻开
@property(nonatomic)NSInteger           m_value;//权值

+(GameBlock *)block;
-(void)create_sprite:(NSString*)path;
-(void)set_sprite_pos:(CGPoint)pos;
@end
