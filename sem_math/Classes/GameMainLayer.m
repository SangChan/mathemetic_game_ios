//
//  GameMainLayer.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 23..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "GameMainLayer.h"
#import "CarSprite.h"
#import "ComboSprite.h"

static inline CGPoint ccpForGame( CGFloat x, CGFloat y )
{
    return CGPointMake(x, [CCDirector sharedDirector].viewSize.height - y);
}


@implementation GameMainLayer

static GameMainLayer *sharedGameMainLayer = nil;

+ (GameMainLayer *)node
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameMainLayer = [[self alloc] init];
    });
    return sharedGameMainLayer;
}

- (id)init
{
    if (self = [super init]) {
        
        answerLabel = [CCLabelTTF labelWithString:@"0" fontName:nil fontSize:20];
        answerLabel.anchorPoint = ccp(0,1.0);
        answerLabel.position = ccpForGame(115, 190); // Middle of screen
        [self addChild:answerLabel];
        
        comboCount = 0;
        [self drawComboGuage];
        [self createCarSprite];
    }
    return self;
}

- (void)createCarSprite
{
    [self setAnswerLabelString:@"0"];
    carSprite = [[CarSprite alloc] initWithPosition:ccpForGame(-180,80)];
    [self addChild:carSprite];
}

- (void)removeCarSprite
{
    [self removeChild:carSprite];
    carSprite = nil;
}
- (void)onCarMoveEndedWithNoAnswer
{
    [self removeCarSprite];
    [self createCarSprite];
}

- (void)onCarMoveEndedWithAnswer
{
    [self removeCarSprite];
    [self createCarSprite];
}

- (void)setAnswerLabelString:(NSString *)string
{
    [answerLabel setString:string];
}
- (NSString *)getAnswerLabelString
{
    return [answerLabel string];
}
- (void)compareInputAndAnswer
{
    BOOL isCorrect = [carSprite compareInput:[[answerLabel string] intValue]];
    if (isCorrect) {
        [carSprite showRightAnswer];
        [self increaseComboCount];
    }
    else {
        [carSprite showWrongAnswer];
        [self resetComboCout];
    }
}

#define COMBOSPRITE @"COMBOSPRITE"
- (void)drawComboGuage
{
    if ([self getChildByName:COMBOSPRITE recursively:NO]) {
        [self removeChildByName:COMBOSPRITE];
    }
    ComboSprite *comboSprite = [[ComboSprite alloc]initWithComboCount:comboCount];
    [comboSprite setName:COMBOSPRITE];
    [self addChild:comboSprite];
}

- (void)increaseComboCount
{
    comboCount++;
    [self drawComboGuage];
    if (comboCount == 5) {
    } else if (comboCount == 10) {
    }
}

- (void)resetComboCout
{
    comboCount = 0;
    [self drawComboGuage];
}

@end
