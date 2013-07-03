//
//  CardSelectedLayer.m
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-06-13.
//
//

#import "CardSelectedLayer.h"
#import "Deck.h"
#import "AppDelegate.h"

#pragma mark - CardSelectedLayer

@interface CardSelectedLayer()
{
    Card* _pSelectedCard;
    CGSize size;
}

@end

@implementation CardSelectedLayer


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CardSelectedLayer *layer = [CardSelectedLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) initWithCard:(Card*)a_pSelectedCard
{
    
    
    
    if ((self = [super init]))
    {
        
        size = [CCDirector sharedDirector].winSize;
        [self schedule:@selector(update:)];
        CCSprite *background = [[CCSprite alloc] initWithFile:@"BlackRect.jpg"];
        background.scaleX = size.width/background.contentSize.width;
        background.scaleY = size.height/background.contentSize.height;
        background.position = ccp(size.width/2, size.height/2);
        background.opacity = 200;
        _pSelectedCard = a_pSelectedCard;
        _pSelectedCard.m_pBackTexture.position = ccp(size.width/2, size.height/2);
        
        float CardHWRatio = _pSelectedCard.m_pBackTexture.contentSize.height/_pSelectedCard.m_pBackTexture.contentSize.width;
        
       
        
        _pSelectedCard.m_pBackTexture.scaleY = (size.height/1.25)/_pSelectedCard.m_pBackTexture.contentSize.height;
        _pSelectedCard.m_pBackTexture.scaleX = ((size.height/1.25)/CardHWRatio)/_pSelectedCard.m_pBackTexture.contentSize.width;
        
        
        //[self addChild:background];
        [self addChild:_pSelectedCard.m_pBackTexture];
        
        
    }
    
    
    return self;
    
    
}


- (void)update:(ccTime)dt
{
    
    
    
}

- (void)Tap:(UITapGestureRecognizer*)recognizer
{
    if(_pSelectedCard.m_isFlipped)
        [self Exit];
    else
        [_pSelectedCard Flip];
    
}

- (void) Exit
{
    
    GameLayer *gameLayer = (GameLayer*)self.parent;
    
    [gameLayer Resume];
    
    
    
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup:YES];
    [self release];
    
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
