//
//  LevelUpSprite.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 24..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "LevelUpSprite.h"
#import "CCAnimation.h"

@implementation LevelUpSprite

- (id)init
{
    self = [super initWithImageNamed:@"efc_leveup_01.png"];
    if (!self) return nil;
    self.position = ccp([CCDirector sharedDirector].viewSize.width/2,[CCDirector sharedDirector].viewSize.height/2);
    self.anchorPoint = ccp(0.5,0.5);
    [self startMove];
    return self;
}

- (void)startMove
{
    
    NSArray *levelUpAniFrames = [NSArray arrayWithObjects:[CCSpriteFrame frameWithImageNamed:@"efc_leveup_01.png"],[CCSpriteFrame frameWithImageNamed:@"efc_leveup_02.png"], nil];
    CCAnimation *levelUpAnimation = [CCAnimation animationWithSpriteFrames:levelUpAniFrames delay:0.5f];
    CCActionAnimate *animationAction = [CCActionAnimate actionWithAnimation:levelUpAnimation];
    CCActionRepeat *repeatingAnimation = [CCActionRepeat actionWithAction:animationAction times:2];
    CCActionCallFunc *callFunc = [CCActionCallFunc actionWithTarget:self selector:@selector(onMoveEnd)];
    [self runAction:[CCActionSequence actions:repeatingAnimation,callFunc,nil]];

}

#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)onMoveEnd
{
    self.visible = NO;
    [self.parent performSelector:@selector(onLevelUp)];
}

@end
