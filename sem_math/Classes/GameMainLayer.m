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
#import "LevelGuageSprite.h"
#import "LevelUpSprite.h"

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
        
        [self resetGame];
    }
    return self;
}

- (void)resetGame
{
    image_comboCard = nil;
    [self removeCarSprite];
    [self setAnswerLabelString:@"0"];
    [self resetComboCount];
    [self drawComboGuage];
    [self resetLevelCount];
    [self drawLevelGuage];
    [self createCarSprite];
    
}

- (void)createCarSprite
{
    [self setAnswerLabelString:@"0"];
    carSprite = [[CarSprite alloc] initWithPosition:ccpForGame(-180,80)];
    [self addChild:carSprite];
}

- (void)removeCarSprite
{
    if (carSprite) {
        [self removeChild:carSprite];
    }
    carSprite = nil;
}
- (void)onCarMoveEndedWithNoAnswer
{
    [self removeCarSprite];
    [self decreaseLevelCount];
    [self resetComboCount];
    [self createCarSprite];
}

#define LEVEL_GUAGE_MAX 10
#define LEVELUPSPRITE @"LEVELUPSPRITE"
- (void)onCarMoveEndedWithAnswer
{
    [self removeCarSprite];
    if (levelCount == LEVEL_GUAGE_MAX) {
        LevelUpSprite *levelupSprite = [LevelUpSprite new];
        levelupSprite.name = LEVELUPSPRITE;
        [self addChild:levelupSprite];
    }
    else {
        [self createCarSprite];
    }
}

- (void)showComboCard:(int)num
{
    NSString *imageSrc = (num == 5) ? @"efc_5combo.png": @"efc_10combo.png";
    image_comboCard = [CCSprite spriteWithImageNamed:imageSrc];
    image_comboCard.position = ccp([CCDirector sharedDirector].viewSize.width/2,[CCDirector sharedDirector].viewSize.height/2);
    image_comboCard.anchorPoint = ccp(0.5,0.5);
    [self addChild:image_comboCard];
    CCActionBlink *blinkAction = [CCActionBlink actionWithDuration:1 blinks:4];
    CCActionCallFunc *funcCall = [CCActionCallFunc actionWithTarget:self selector:@selector(onComboBlinkEnd)];
    [image_comboCard runAction:[CCActionSequence actions:blinkAction, funcCall,nil]];
}

- (void)onComboBlinkEnd
{
    if (image_comboCard) {
        [self removeChild:image_comboCard];
    }
    image_comboCard = nil;
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
        [self increaseLevelCount];
    }
    else {
        [carSprite showWrongAnswer];
        [self resetComboCount];
        [self decreaseLevelCount];
    }
}

#define COMBOSPRITE @"COMBOSPRITE"
- (void)drawComboGuage
{
    if ([self getChildByName:COMBOSPRITE recursively:NO]) {
        [self removeChildByName:COMBOSPRITE];
    }
    ComboSprite *comboSprite = [[ComboSprite alloc] initWithComboCount:comboCount];
    [comboSprite setName:COMBOSPRITE];
    [self addChild:comboSprite];
}

- (void)increaseComboCount
{
    comboCount++;
    [self drawComboGuage];
    if (comboCount % 5 == 0 && comboCount % 10 == 0) {
        [self showComboCard:10];
    } else if (comboCount % 5 == 0 && comboCount % 10 != 0) {
        [self showComboCard:5];
    }
}
- (void)resetComboCount
{
    comboCount = 0;
    [self drawComboGuage];
}

#define LEVELGUAGESPRITE @"LEVELGUAGESPRITE"
- (void)drawLevelGuage
{
    if ([self getChildByName:LEVELGUAGESPRITE recursively:NO]) {
        [self removeChildByName:LEVELGUAGESPRITE];
    }
    LevelGuageSprite *levelGuageSprite = [[LevelGuageSprite alloc] initWithLevelCount:levelCount];
    [levelGuageSprite setName:LEVELGUAGESPRITE];
    [self addChild:levelGuageSprite];
}

- (void)increaseLevelCount
{
    levelCount++;
    if (levelCount > LEVEL_GUAGE_MAX) {
        levelCount = LEVEL_GUAGE_MAX;
    }
    [self drawLevelGuage];
}

- (void)decreaseLevelCount
{
    levelCount--;
    if (levelCount < 0) {
        levelCount = 0;
    }
    [self drawLevelGuage];
}

- (void)resetLevelCount
{
    levelCount = 0;
    [self drawLevelGuage];
}

- (void)onLevelUp
{
    if ([self getChildByName:LEVELUPSPRITE recursively:NO]) {
        [self removeChildByName:LEVELUPSPRITE];
    }
    [self resetGame];
}
@end
