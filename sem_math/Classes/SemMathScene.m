//
//  SemMathScene.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 6..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "SemMathScene.h"
#import "IntroScene.h"
#import "StatusLayer.h"
#import "InputLayer.h"

@implementation SemMathScene

+(SemMathScene *)scene
{
    return [[self alloc]init];
}

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self)
        return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor darkGrayColor]];
    [self addChild:background];
    
    StatusLayer *statusLayer = [StatusLayer node];
    [self addChild:statusLayer];
    
    InputLayer *inputLayer = [InputLayer node];
    [self addChild:inputLayer];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    [backButton setLabelColor:[CCColor blackColor] forState:CCControlStateNormal];
    [backButton setLabelColor:[CCColor darkGrayColor] forState:CCControlStateHighlighted];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    [self addExpression:@"+" withAugend:6 withAddend:2];
    // done
    return self;
}


// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------


- (void)addExpression:(NSString *)arithmetic withAugend:(int)auguend withAddend:(int)addend
{
    CGPoint centerPos = ccp([CCDirector sharedDirector].viewSize.width * 0.5, [CCDirector sharedDirector].viewSize.height * 0.5);
    NSString *expression = [NSString stringWithFormat:@"%d %@ %d = ?",auguend, arithmetic, addend];
    CCLabelTTF *expressionLabel = [CCLabelTTF labelWithString:expression fontName:@"Marker Felt" fontSize:48];
    expressionLabel.position = ccp(0,centerPos.y);
    [self addChild:expressionLabel];
    
    id moveAction = [CCActionMoveBy actionWithDuration:10 position:ccp([CCDirector sharedDirector].viewSize.width,0)];
    [expressionLabel runAction:moveAction];
}
@end
