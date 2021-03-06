//
//  MyCocos2DClass.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 6..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "BGLayer.h"

@implementation BGLayer

static inline CGPoint ccpForGame( CGFloat x, CGFloat y )
{
    CGFloat x_offset = [CCDirector sharedDirector].viewSize.width/2 - GAME_WIDTH/2;
    CGFloat y_offset = [CCDirector sharedDirector].viewSize.height/2 + GAME_HEIGHT/2;
    return CGPointMake(x_offset + x, y_offset - y);
}

+ (BGLayer *)node
{
    return [[self alloc]init];
}
- (id)init
{
    
    if (self = [super init]) {
        CCSprite *imageBG = [CCSprite spriteWithImageNamed:@"image_bg.png"];
        imageBG.anchorPoint = ccp(0,1.0);
        imageBG.position = ccpForGame(0,-20);
        [self addChild:imageBG];
        
        CCSprite *image_conTop_bg = [CCSprite spriteWithImageNamed:@"image_conTop_bg.png"];
        image_conTop_bg.anchorPoint = ccp(0,1.0);
        image_conTop_bg.position = ccpForGame(0,0);
        [self addChild:image_conTop_bg];
        
        CCSprite * image_conTop_level = [CCSprite spriteWithImageNamed:@"image_conTop_level.png"];
        image_conTop_level.anchorPoint = ccp(0,1.0);
        image_conTop_level.position = ccpForGame(70,10);
        [self addChild:image_conTop_level];
        
        CCSprite * image_conTop_coinbar = [CCSprite spriteWithImageNamed:@"image_conTop_coinbar.png"];
        image_conTop_coinbar.anchorPoint = ccp(0,1.0);
        image_conTop_coinbar.position = ccpForGame(240,10);
        [self addChild:image_conTop_coinbar];
        
        
        CCSprite * image_answerboard = [CCSprite spriteWithImageNamed:@"image_answerboard.png"];
        image_answerboard.anchorPoint = ccp(0,1.0);
        image_answerboard.position = ccpForGame(90,170);
        [self addChild:image_answerboard];
        
        
        CCSprite * image_answerboard_textbar = [CCSprite spriteWithImageNamed:@"image_answerboard_textbar.png"];
        image_answerboard_textbar.anchorPoint = ccp(0,1.0);
        image_answerboard_textbar.position = ccpForGame(105, 190);
        [self addChild:image_answerboard_textbar];
        
        
        CCLabelTTF *askLabel = [CCLabelTTF labelWithString:@"지나가는 문제의 답을 입력하세요." fontName:nil fontSize:13];
        askLabel.anchorPoint = ccp(0,1.0);
        askLabel.color = [CCColor brownColor];
        askLabel.position = ccpForGame(105, 175); // Middle of screen
        [self addChild:askLabel];
        
    }
    return self;
}

@end
