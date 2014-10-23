//
//  InputLayer.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 6..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "InputLayer.h"
#import "GameMainLayer.h"

static inline CGPoint ccpForGame( CGFloat x, CGFloat y )
{
    return CGPointMake(x, [CCDirector sharedDirector].viewSize.height - y);
}

@interface InputLayer () {
    NSString * _answer;
    CCLabelTTF *answerLabel;
}

@end

@implementation InputLayer


+ (InputLayer *)node
{
    return [[self alloc]init];
}
- (id)init
{
    if (self = [super init]) {
        CCButton *homeButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"btn_home.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"btn_home_hit.png"] disabledSpriteFrame:nil];
        homeButton.anchorPoint = ccp(0, 1.0);
        homeButton.position = ccpForGame(10, 10);
        [homeButton setTarget:self selector:@selector(homeButtonClicked:)];
        [self addChild:homeButton];
        
        
        CCButton *userNMButton = [CCButton buttonWithTitle:@"김재능" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"btn_userMN.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"btn_userMN_hit.png"] disabledSpriteFrame:nil];
        userNMButton.label.color = [CCColor blackColor];
        userNMButton.anchorPoint = ccp(0, 1.0);
        userNMButton.position = ccpForGame(485, 15);
        [self addChild:userNMButton];
        
        [self makeButton];
        
    }
    return self;
}

- (void)makeButton
{
    NSArray *buttonImage = [[NSArray alloc]initWithObjects:
                            @"btn_1.png",@"btn_1_hit.png",
                            @"btn_2.png",@"btn_2_hit.png",
                            @"btn_3.png",@"btn_3_hit.png",
                            @"btn_4.png",@"btn_4_hit.png",
                            @"btn_5.png",@"btn_5_hit.png",
                            @"btn_back.png",@"btn_back_hit.png",
                            @"btn_6.png",@"btn_6_hit.png",
                            @"btn_7.png",@"btn_7_hit.png",
                            @"btn_8.png",@"btn_8_hit.png",
                            @"btn_9.png",@"btn_9_hit.png",
                            @"btn_0.png",@"btn_0_hit.png",
                            @"btn_enter.png",@"btn_enter_hit.png", nil];
    
    for (int i = 0; i < 12; i++) {
        CCButton *numPadButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:[buttonImage objectAtIndex:i*2]] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:[buttonImage objectAtIndex:i*2+1]] disabledSpriteFrame:nil];
        numPadButton.anchorPoint = ccp(0, 1.0);
        numPadButton.position = ccpForGame(105 + (63 * (i%6)), (i <= 5)? 220 : 270);
        if (i <= 5) {
            numPadButton.name = [NSString stringWithFormat:@"%d",i+1];
        }
        else if (i == 10) {
            numPadButton.name = [NSString stringWithFormat:@"%d",0];
        }
        else {
            numPadButton.name = [NSString stringWithFormat:@"%d",i];
        }
        
        if (i == 5) {
            [numPadButton setTarget:self selector:@selector(backButtonClicked:)];
        }
        else if (i == 11) {
            [numPadButton setTarget:self selector:@selector(enterButtonClicked:)];
        }
        else {
            [numPadButton setTarget:self selector:@selector(numButtonClicked:)];
        }
        [self addChild:numPadButton];
    }
}

- (void)homeButtonClicked:(id)sender
{
    NSLog(@"home button clicked!");
}


- (void)numButtonClicked:(id)sender
{
    CCButton *numButton = (CCButton *)sender;
    NSLog(@"num button clicked: %@",[numButton name]);
    
    NSString *prevAnswer = [[GameMainLayer node] getAnswerLabelString];
    if ([prevAnswer isEqualToString:@"0"]) {
        [[GameMainLayer node] setAnswerLabelString:[numButton name]];
    }
    else {
        [[GameMainLayer node] setAnswerLabelString:[NSString stringWithFormat:@"%@%@",prevAnswer,[numButton name]]];
    }
}

- (void)backButtonClicked:(id)sender
{
    [[GameMainLayer node] setAnswerLabelString:@"0"];
}

- (void)enterButtonClicked:(id)sender
{
    [[GameMainLayer node] compareInputAndAnswer];
}

@end
