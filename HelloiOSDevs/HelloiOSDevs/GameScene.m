//
//  GameScene.m
//  HelloiOSDevs
//
//  Created by Gibson Tang on 22/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
        [self addChild:bg];

        size = [[CCDirector sharedDirector] winSize];
        lblScore = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:48];
        lblScore.position = ccp(size.width/2, size.height/2);
        [self addChild:lblScore];
        
        score = 0;//set score to 0
        
        //preload audio
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sfx.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Boo.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"applause.wav"];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgm.mp3"];//play background music
        
        bugs = [CCMenu menuWithItems: nil];
        maxBugs = 4;
        for(int i = 0; i < maxBugs; i++)
        {
            CCMenuItemSprite *bug;
            CCSprite *bugSprite = [CCSprite spriteWithFile:@"bug.png"];
            bug = [CCMenuItemSprite itemFromNormalSprite:bugSprite selectedSprite:nil target:self selector:@selector(squashed:)];
            [bugs addChild:bug];
            int width = 240;
            int randomX = arc4random()%width + 30;
            bug.position = ccp(randomX, 0);
            //randomX = 240 + 30;
            float randSpeed = 12.0 + arc4random()%8;
            [bug runAction:[CCMoveTo actionWithDuration:randSpeed position:ccp(randomX, 960)]];
            [bug runAction:[CCRotateBy actionWithDuration:4.0f angle:360]];
            [bug runAction:[CCFadeTo actionWithDuration:2.0f opacity:128]];
        }
        bugs.position = ccp(0,0);
        [self addChild:bugs];
        
        [self schedule:@selector(tick:)];
    }
	return self;
}

- (void) tick:(ccTime)dt {
    for (CCMenuItemSprite* bug in [bugs children])
    {
        if (bug.position.y >= size.height)
        {
            [bug stopAllActions];
            UIAlertView* alert_view = [[UIAlertView alloc] initWithTitle:@"Lose"                                                              message:@"You lose" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert_view setDelegate:self];
            [alert_view show];
            [alert_view autorelease];
            [self unschedule:@selector(tick:)];//remove the timer since the player has lost the game
            [[SimpleAudioEngine sharedEngine] playEffect:@"Boo.mp3"];
            break;
        }
    }
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        AppDelegate* obj = ((AppDelegate*)[UIApplication sharedApplication].delegate);

        if (score >= maxBugs)
            [obj setHeader:@"Winner"];
        else
            [obj setHeader:@"Loser"];
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer node]];
    }
}

- (void) squashed: (CCMenuItemSprite*)bug {
    NSLog(@"Bug squashed");
    [bug stopAllActions];
    score++;
    [lblScore setString:[NSString stringWithFormat:@"%d", score]];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"sfx.wav"];

    if (score >= maxBugs)//to check if player has tapped all the bugs
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"applause.wav"];
        UIAlertView* alert_view = [[UIAlertView alloc] initWithTitle:@"Win"                                                              message:@"You win" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert_view setDelegate:self];
        [alert_view show];
        [alert_view autorelease];
        [self unschedule:@selector(tick:)];//remove the timer since player has won the game
    }
    //bug.visible = false;
}
@end
