//
//  MainMenuLayer.m
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-06-17.
//
//

#import "MainMenuLayer.h"
#import "AppDelegate.h"
#import "GameLayer.h"
#import "RulesAndPlayers.h"

#pragma mark - CardSelectedLayer

@interface MainMenuLayer()
{
    CCMenu *blah;
}

@end


@implementation MainMenuLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

- (id) init
{
    
    if ((self = [super init]))
    {
        
        CCLabelBMFont *play = [CCLabelBMFont labelWithString:@"Play" fntFile:@"KingsCupBitMapFont-empty.fnt"];
        CCLabelBMFont *rules = [CCLabelBMFont labelWithString:@"Rules" fntFile:@"KingsCupBitMapFont-empty.fnt"];
        
        CGSize size = [CCDirector sharedDirector].winSize;
        
        
        
        CCMenuItemLabel *playButton = [CCMenuItemLabel itemWithLabel:play target:self selector:@selector(playButtonTapped:)];
        CCMenuItemLabel *rulesButton = [CCMenuItemLabel itemWithLabel:rules target:self selector:@selector(rulesButtonTapped:)];
        
        
        CCMenu *myMenu = [CCMenu menuWithItems:playButton, rulesButton, nil];
        myMenu.position = ccp(size.width/2, size.height/2);
        //[myMenu setPosition:cpp(size.width/2,size.height/2)];
        [self addChild:myMenu z:2];
        
        [myMenu alignItemsVertically];
        [myMenu alignItemsVerticallyWithPadding:20];	// 10px of padding around each button
        //[myMenu alignItemsHorizontally];
        //[myMenu alignItemsHorizontallyWithPadding:20];	// 20px of padding around each button
        //[myMenu alignItemsInColumns:(NSNumber*)1, nil];
        //[myMenu alignItemsInRows:(NSNumber*)1, nil];
        
        
        
        
        [self schedule:@selector(update:)];
        
        
        
        
        
    }
    return self;
}

-(void)playButtonTapped:(id)sender
{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
    
    
    
    
}

-(void)rulesButtonTapped:(id)sender
{
    
    [[RulesAndPlayers Instance] ShowTable];
    [self addChild:[RulesAndPlayers Instance].m_pMenu];
    /*NewRule *newrulelayer = [NewRule alloc];
    [newrulelayer Init:@"BRUCE"];
    [self addChild:newrulelayer];
    */
    
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[NewRule scene] withColor:ccWHITE]];
    
}

-(void)update:(ccTime)dt
{
    
    
    
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    [self release];
	[super dealloc];
}

@end
