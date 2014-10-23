//
//  InputLayer.m
//  sem_math
//
//  Created by SangChan on 2014. 10. 6..
//  Copyright 2014년 sangchan. All rights reserved.
//

#import "InputLayer.h"

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
        [self setAnswer:@"0"];
        self.position = ccp(0.0,0.0);
        CCNodeColor *nodeColorBlue = [CCNodeColor nodeWithColor:[CCColor blueColor]];
        [nodeColorBlue setContentSize:CGSizeMake([CCDirector sharedDirector].viewSize.width, 100.0)];
        //[self addChild:nodeColorBlue];
        [self setButton:0 withPosition:ccp(100,20)];
        [self setButton:1 withPosition:ccp(140,20)];
        [self setButton:2 withPosition:ccp(180,20)];
        [self setButton:3 withPosition:ccp(220,20)];
        [self setButton:4 withPosition:ccp(260,20)];
        [self setButton:5 withPosition:ccp(300,20)];
        [self setButton:6 withPosition:ccp(340,20)];
        [self setButton:7 withPosition:ccp(380,20)];
        [self setButton:8 withPosition:ccp(420,20)];
        [self setButton:9 withPosition:ccp(460,20)];
        
        CCButton *delButton = [CCButton buttonWithTitle:@"[del]" fontName:@"Verdana-Bold" fontSize:20.0f];
        [delButton setPosition:ccp(140,60)];
        [delButton setTarget:self selector:@selector(delButtonClicked:)];
        [self addChild:delButton];
        
        CCButton *submitButton = [CCButton buttonWithTitle:@"[submit]" fontName:@"Verdana-Bold" fontSize:20.0f];
        [submitButton setPosition:ccp(420,60)];
        [submitButton setTarget:self selector:@selector(submitButtonClicked:)];
        [self addChild:submitButton];
        
        answerLabel = [CCLabelTTF labelWithString:_answer fontName:@"Marker Felt" fontSize:40];
        [answerLabel setPosition:ccp([CCDirector sharedDirector].viewSize.width / 2, 80)];
        [self addChild:answerLabel];
        
    }
    return self;
}

- (void)setButton:(int)num withPosition:(CGPoint)position
{
    NSString *string = [NSString stringWithFormat:@"%d",num];
    CCButton *numButton = [CCButton buttonWithTitle:string fontName:@"Verdana-Bold" fontSize:32.0f];
    [numButton setPosition:position];
    [numButton setTarget:self selector:@selector(numButtonClicked:)];
    
    [self addChild:numButton];
}

- (void)setAnswer:(NSString *)answer
{
    _answer = answer;
    [answerLabel setString:_answer];
}

- (void)plusAnswer:(NSString *)plus
{
    _answer = ([_answer isEqualToString:@"0"]) ? [NSString stringWithFormat:@"%@",plus] : [NSString stringWithFormat:@"%@%@",_answer,plus];
    [answerLabel setString:_answer];
}

- (void)numButtonClicked:(id)sender
{
    CCButton *numButton = (CCButton *)sender;
    [self plusAnswer:numButton.title];
}

- (void)delButtonClicked:(id)sender
{
    [self setAnswer:@"0"];
}

- (void)submitButtonClicked:(id)sender
{
    NSLog(@"submit!");
}

@end
