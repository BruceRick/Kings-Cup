//
//  HelloWorldLayer.m
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-04-11.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"
#import "CardSelectedLayer.h"


// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - GameLayer




@interface GameLayer()
{
    Deck *_pDeck;
    float _DeckMovementFriction;
    CGPoint _DeckMovementVelocity;
    CGSize winSize;
    Card *_pSelectedCard;
    BOOL _CardSelected;
    
    CardSelectedLayer *_pCardSelectedLayer;
    
}

@end


// HelloWorldLayer implementation
@implementation GameLayer



// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
- (id) init
{
    
    if ((self = [super init]))
    {
        winSize = [CCDirector sharedDirector].winSize;
        
        //detect touches
        self.isTouchEnabled = YES;
        
        //**Move Deck Gestures**
        
        //Left
        UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(MoveDeckLeft:)];
        swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        
        //Right
        UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(MoveDeckRight:)];
        swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        
        UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(HandleSwipeUp:)];
        swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        
        UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)];
        
        //Register Gesture Recognizers
        [[CCDirector sharedDirector].view addGestureRecognizer:swipeLeftGestureRecognizer];
        [[CCDirector sharedDirector].view addGestureRecognizer:swipeRightGestureRecognizer];
        [[CCDirector sharedDirector].view addGestureRecognizer:swipeUpGestureRecognizer];
        [[CCDirector sharedDirector].view addGestureRecognizer:tapGestureRecognizer];
        
        [swipeLeftGestureRecognizer release];
        [swipeRightGestureRecognizer release];
        [swipeUpGestureRecognizer release];
        [tapGestureRecognizer release];
        
        CCSprite *pBackground = [[CCSprite alloc]initWithFile:@"FeltTable.jpeg"];
        CGSize backgroundSize = pBackground.contentSize;
        pBackground.position = ccp(winSize.width/2,winSize.height/2);
        
        pBackground.scaleX = winSize.width/backgroundSize.width;
        pBackground.scaleY = winSize.height/backgroundSize.height;
        
        _pDeck = [Deck node];
        _DeckMovementFriction = 0.9;
        _DeckMovementVelocity = ccp(0,0);
        
        [_pDeck Initialize:(NSString*)@"KingsKupCard.png"];
        
        //[_pDeck Initialize:[[CCSprite alloc ]initWithFile:@"Card.jpg"]];
        [self addChild:pBackground];
        
        [_pDeck Shuffle];
        [_pDeck DrawCards];
        
        [self addChild:_pDeck];
        [self schedule:@selector(update:)];
        //[self schedule:@selector(draw:)];
        _pSelectedCard = [_pDeck.m_pDeck objectAtIndex:0];
        
        
        
        
        
    }
    return self;
}

- (void)update:(ccTime)dt
{
    
    if(_CardSelected)
        return;
    
    _DeckMovementVelocity.x *= _DeckMovementFriction;
    _DeckMovementVelocity.y *= _DeckMovementFriction;
    _pDeck.position = ccp(_pDeck.position.x + _DeckMovementVelocity.x,_pDeck.position.y+_DeckMovementVelocity.y);
    
    
    
    Card *lastCardInDeck = [_pDeck.children objectAtIndex:_pDeck.children.count-1];
    if(_pDeck.position.x > winSize.width/2)
    {
        _pDeck.position = ccp(winSize.width/2,_pDeck.position.y);
    }
    else if(lastCardInDeck.position.x + _pDeck.position.x < winSize.width/2)
    {
        _pDeck.position = ccp(lastCardInDeck.position.x * -1 + winSize.width/2,_pDeck.position.y);
    }
    
    [_pDeck updateCards];
    
    
    
}

- (void)draw;
{
    
    
    
}

- (void)MoveDeckLeft:(UIGestureRecognizer*)recognizer
{

    _DeckMovementVelocity.x = -20;
    
}

- (void)MoveDeckRight:(UIGestureRecognizer*)recognizer
{
    _DeckMovementVelocity.x = 20;
    
}

- (void)HandleSwipeUp:(UITapGestureRecognizer*)recognizer
{
    
    [_pSelectedCard.m_pBackTexture removeFromParentAndCleanup:YES];
    
    _CardSelected = YES;
    
    _pCardSelectedLayer = [[CardSelectedLayer alloc] initWithCard:_pSelectedCard];
    
    [self addChild:_pCardSelectedLayer];
    
}



- (void)Tap:(UITapGestureRecognizer*)recognizer
{
    CGPoint tapPosition = [recognizer locationInView:[[CCDirector sharedDirector] openGLView]];
    //CGPoint tapPosition = [[CCDirector sharedDirector] convertToGL:[self convertToNodeSpace:[recognizer locationInView:[[CCDirector sharedDirector] openGLView]]]];
    
    for(CCNode *child in self.children)
    {
        if([child isKindOfClass:[CardSelectedLayer class]])
        {
            [_pCardSelectedLayer Tap:recognizer];
            return;
        }
    }
    
    for(Card *card in _pDeck.m_pDeck)
    {
        
        float minX = card.m_pBackTexture.position.x - (card.m_pBackTexture.contentSize.width*card.m_pBackTexture.scaleX)/2 + _pDeck.position.x;
        float maxX = card.m_pBackTexture.position.x + (card.m_pBackTexture.contentSize.width*card.m_pBackTexture.scaleX)/2 + _pDeck.position.x;
        float minY = card.m_pBackTexture.position.y - (card.m_pBackTexture.contentSize.height*card.m_pBackTexture.scaleY)/2;
        float maxY = card.m_pBackTexture.position.y + (card.m_pBackTexture.contentSize.height*card.m_pBackTexture.scaleY)/2;
       
        
        
        if(tapPosition.x > minX && tapPosition.x < maxX && tapPosition.y > minY && tapPosition.y < maxY)
        {
            _pSelectedCard.m_pBackTexture.color = ccWHITE;
            card.m_pBackTexture.color = ccRED;
            _pSelectedCard = card;
        }
        
        
    }
    
    
    
    
}

- (void)Resume
{
    _CardSelected = NO;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
