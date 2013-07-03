//
//  NewRule.m
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-07-02.
//
//

// Import the interfaces
#import "IntroLayer.h"
#import "GameLayer.h"
#import "NewRule.h"
#import "MainMenuLayer.h"

#pragma mark - NewRule

// HelloWorldLayer implementation
@implementation NewRule

@synthesize m_pRule;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	NewRule *layer = [NewRule node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(void) Init:(NSString*)a_pRule
{
    
    m_pRule = a_pRule;
    
    
}

//
-(void) onEnter
{
	[super onEnter];
    
	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    
	CCSprite *background;
    
    
    background = [CCSprite spriteWithFile:@"BlackRect.jpg"];
    background.scaleX = size.width/background.contentSize.width;
    background.scaleY = size.height/background.contentSize.height;
	background.position = ccp(size.width/2, size.height/2);
    
    CCLabelBMFont *title = [CCLabelBMFont labelWithString:@"New Rule" fntFile:@"KingsCupBitMapFont-empty.fnt"];
    title.position = ccp(size.width/2,size.height - size.height/8);
    
    //CCSprite *new
    
	// add the label as a child to this Layer
	[self addChild: background];
    [self addChild: title];
    
    
    
	
	
}


@end