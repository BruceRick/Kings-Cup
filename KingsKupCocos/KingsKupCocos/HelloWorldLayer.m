//
//  HelloWorldLayer.m
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-04-11.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer




@interface HelloWorldLayer()
{
    Deck *_pDeck;
    float _DeckMovementFriction;
    CGPoint _DeckMovementVelocity;
    CGSize winSize;
    Card *_pSelectedCard;
    
}

@end


// HelloWorldLayer implementation
@implementation HelloWorldLayer



// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
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
        
        CCSprite *pBackground = [[CCSprite node ]initWithFile:@"FeltTable.jpeg"];
        CGSize backgroundSize = pBackground.contentSize;
        pBackground.position = ccp(winSize.width/2,winSize.height/2);
        
        pBackground.scaleX = winSize.width/backgroundSize.width;
        pBackground.scaleY = winSize.height/backgroundSize.height;
        
    
        
        
        _pDeck = [Deck node];
        _DeckMovementFriction = 0.9;
        _DeckMovementVelocity = ccp(0,0);
        
        
        
        
        [_pDeck Initialize:(NSString*)@"Card.jpg"];
        
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
    
    float minX = _pSelectedCard.m_pTexture.position.x - _pSelectedCard.m_pTexture.contentSize.width/2 + _pDeck.position.x;
    float maxX = _pSelectedCard.m_pTexture.position.x + _pSelectedCard.m_pTexture.contentSize.width/2 + _pDeck.position.x;
    float minY = _pSelectedCard.m_pTexture.position.y - _pSelectedCard.m_pTexture.contentSize.height/2;
    float maxY = _pSelectedCard.m_pTexture.position.y + _pSelectedCard.m_pTexture.contentSize.height/2;
    
    CGPoint tapPosition = [recognizer locationInView:[[CCDirector sharedDirector] openGLView]];
    
    if(tapPosition.x > minX && tapPosition.x < maxX && tapPosition.y > minY && tapPosition.y < maxY)
    {
        for(Card *card in _pDeck.m_pDeck)
        {
            if(card != _pSelectedCard)
                card.m_pTexture.opacity = 0;
            
        }
    }
    
    _pSelectedCard.m_pTexture.position = ccp(winSize.width/2,winSize.height/2);
    
    
    CCActionInterval *inA, *outA;

    
    float inDeltaZ, inAngleZ;
    float outDeltaZ, outAngleZ;
    
        inDeltaZ = 90;
        inAngleZ = 270;
        outDeltaZ = 90;
        outAngleZ = 0;
    
        
    float duration_ = 2;
    
    inA = [CCSequence actions:
           [CCDelayTime actionWithDuration:duration_/2],
           [CCShow action],
           [CCOrbitCamera actionWithDuration: duration_/2 radius: 1 deltaRadius:0 angleZ:inAngleZ deltaAngleZ:inDeltaZ angleX:0 deltaAngleX:0],
           [CCCallFunc actionWithTarget:self selector:@selector(finish)],
           nil ];
    outA = [CCSequence actions:
            [CCOrbitCamera actionWithDuration: duration_/2 radius: 1 deltaRadius:0 angleZ:outAngleZ deltaAngleZ:outDeltaZ angleX:0 deltaAngleX:0],
            [CCHide action],
            [CCDelayTime actionWithDuration:duration_/2],
            nil ];
    
    [_pSelectedCard.m_pTexture runAction: inA];
    //[outScene_ runAction: outA];
    
}

- (void)Tap:(UITapGestureRecognizer*)recognizer
{
    CGPoint tapPosition = [recognizer locationInView:[[CCDirector sharedDirector] openGLView]];
    //CGPoint tapPosition = [[CCDirector sharedDirector] convertToGL:[self convertToNodeSpace:[recognizer locationInView:[[CCDirector sharedDirector] openGLView]]]];
    
    
    
    for(Card *card in _pDeck.m_pDeck)
    {
        
        float minX = card.m_pTexture.position.x - card.m_pTexture.contentSize.width/2 + _pDeck.position.x;
        float maxX = card.m_pTexture.position.x + card.m_pTexture.contentSize.width/2 + _pDeck.position.x;
        float minY = card.m_pTexture.position.y - card.m_pTexture.contentSize.height/2;
        float maxY = card.m_pTexture.position.y + card.m_pTexture.contentSize.height/2;
       
        
        
        if(tapPosition.x > minX && tapPosition.x < maxX && tapPosition.y > minY && tapPosition.y < maxY)
        {
            _pSelectedCard.m_pTexture.color = ccWHITE;
            card.m_pTexture.color = ccRED;
            _pSelectedCard = card;
        }
        
        
    }
    
    
    
    int a = 0;
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
