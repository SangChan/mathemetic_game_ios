//
//  ComboSprite.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 24..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "ComboSprite.h"

static inline CGPoint ccpForGame( CGFloat x, CGFloat y )
{
    CGFloat x_offset = [CCDirector sharedDirector].viewSize.width/2 - GAME_WIDTH/2;
    CGFloat y_offset = [CCDirector sharedDirector].viewSize.height/2 + GAME_HEIGHT/2;
    return CGPointMake(x_offset + x, y_offset - y);
}

@implementation ComboSprite

- (id)initWithComboCount:(int)comboCount
{
    self = [super initWithImageNamed:@"image_combo_bg.png"];
    if (!self) return nil;
    
    self.position = ccpForGame(10, 170);
    self.anchorPoint = ccp(0,1.0);
    int combo10Count = floor(comboCount / 10);
    int combo5Count = floor((comboCount - (combo10Count * 10))/5);
    int combo1Count = floor((comboCount - (combo10Count * 10)) - (combo5Count * 5));
    
    [self drawWithComboCount:combo10Count :combo5Count :combo1Count];
    
    return self;
}
#define IMAGE_GLITTER @"IMAGE_GLITTER"
- (void)drawWithComboCount:(int)combo10Count :(int)combo5Count :(int)combo1Count
{
    const int height_const_value = self.contentSize.height + 13;
    const int width_const_value = self.contentSize.width/2;
    int lastYPosition = -1;;
    for (int i = 0; i < combo10Count; i++) {
        lastYPosition = (13 * (11 - i));
        CCSprite *comboImage = [CCSprite spriteWithImageNamed:@"image_combo_10.png"];
        comboImage.position = ccp(width_const_value, height_const_value - lastYPosition);
        comboImage.anchorPoint = ccp(0.5,1.0);
        [self addChild:comboImage];
    }
    for (int i = 0; i < combo5Count; i++) {
        lastYPosition = (13 * (11 - i - combo10Count));
        CCSprite *comboImage = [CCSprite spriteWithImageNamed:@"image_combo_5.png"];
        comboImage.position = ccp(width_const_value, height_const_value - lastYPosition);
        comboImage.anchorPoint = ccp(0.5,1.0);
        [self addChild:comboImage];
    }
    for (int i = 0; i < combo1Count; i++) {
        lastYPosition = (13 * (11 - i - combo10Count - combo5Count));
        CCSprite *comboImage = [CCSprite spriteWithImageNamed:@"image_combo_1.png"];
        comboImage.position = ccp(width_const_value, height_const_value - lastYPosition);
        comboImage.anchorPoint = ccp(0.5,1.0);
        [self addChild:comboImage];
    }
    
    if (lastYPosition > -1) {
        CCSprite *image_gliter = [CCSprite spriteWithImageNamed:@"efc_combo.png"];
        image_gliter.position = ccp(width_const_value, height_const_value - lastYPosition + 6);
        image_gliter.anchorPoint = ccp(0.5,1.0);
        image_gliter.name = IMAGE_GLITTER;
        [self addChild:image_gliter];
        CCActionBlink *blinkAction = [CCActionBlink actionWithDuration:1 blinks:4];
        CCActionCallFunc *funcCall = [CCActionCallFunc actionWithTarget:self selector:@selector(onGlitterEnd)];
        [image_gliter runAction:[CCActionSequence actions:blinkAction, funcCall,nil]];
    }
}

- (void)onGlitterEnd
{
    if ([self getChildByName:IMAGE_GLITTER recursively:NO]) {
        CCSprite *image_glitter = (CCSprite *)[self getChildByName:IMAGE_GLITTER recursively:NO];
        [image_glitter setVisible:FALSE];
    }
}

@end
