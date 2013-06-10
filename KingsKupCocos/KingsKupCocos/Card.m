//
//  Card.m
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-04-11.
//
//

#import "Card.h"

float previousX = 0;

@implementation Card

@synthesize m_Suit = _Suit;
@synthesize m_Value = _Value;
@synthesize m_Position = _Position;
@synthesize m_isFlipped = _isFlipped;
@synthesize m_pTexture = _pTexture;
@synthesize m_OriginalScale = _OriginalScale;

- (void)Flip
{
    
}
- (void)dealloc
{
    
    
    [super dealloc];
}

- (void)Init:(int)a_Suit:(int)a_Value:(NSString*)a_pTexturePath
{
    
    _Suit = a_Suit;
    _Value = a_Value;
    _pTexture = [[CCSprite alloc ]initWithFile:a_pTexturePath];
    
    
    
}

- (void)Draw:(CGPoint)a_Position
{
    
    _pTexture.position = ccp(a_Position.x,a_Position.y);
    //_pTexture.position = ccp(0,0);
    [self addChild:_pTexture];
    
    //_OriginalScale.x = _pTexture.scaleX;
    //_OriginalScale.y = _pTexture.scaleY;
    
}

- (void)Update
{
    
    //if(previousX == self.m_pTexture.parent.position.x)
        //return;
    
    float DisFromMid = self.m_pTexture.position.x - ((self.m_pTexture.contentSize.width/2)) + self.m_pTexture.parent.position.x - 160;
    
    if(DisFromMid < 1)
        DisFromMid *= -1;
    
    if(DisFromMid > 100)
    {
        
        self.m_pTexture.scaleX = _OriginalScale.x;
        self.m_pTexture.scaleY = _OriginalScale.y;
        
    }
    else
    {
        
        DisFromMid/=100;
        DisFromMid = 1-DisFromMid;
        
        DisFromMid = _OriginalScale.x * 2 * DisFromMid;
        self.m_pTexture.scaleX = _OriginalScale.x + DisFromMid;
        self.m_pTexture.scaleY = _OriginalScale.y + DisFromMid;
        
        
        
    }
    
    
    
    
    previousX = self.m_pTexture.parent.position.x;
    
}

@end
