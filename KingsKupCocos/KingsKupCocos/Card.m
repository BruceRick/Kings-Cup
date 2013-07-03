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
@synthesize m_pBackTexture = _pBackTexture;
@synthesize m_pFrontTexture = _pFrontTexture;
@synthesize m_OriginalScale = _OriginalScale;

- (void)Flip
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCNode *allspritesNode = [CCNode node];
    allspritesNode.position = ccp(_pBackTexture.position.x, _pBackTexture.position.y);
    
    CCSprite *front = [[CCSprite alloc] initWithFile:@"KingsKupCardFront.png"];
    front.scaleX = _pBackTexture.contentSize.width*_pBackTexture.scaleX/front.contentSize.width;
    front.scaleY = _pBackTexture.contentSize.height* _pBackTexture.scaleY/front.contentSize.height;
    
    
    CCLabelBMFont *label = [CCLabelBMFont labelWithString:[self GenValLab] fntFile:@"KingsCupBitMapFont-empty.fnt"];
    CCLabelBMFont *label2 = [CCLabelBMFont labelWithString:[self GenValLab] fntFile:@"KingsCupBitMapFont-empty.fnt"];
    
    NSString *rule = [[NSString alloc] initWithString:[[RulesAndPlayers Instance].m_pRules objectAtIndex:self.m_Suit*13+self.m_Value]];
    
    CCLabelBMFont *ruleLabel = [CCLabelBMFont labelWithString:rule fntFile:@"KingsCupBitMapFont-empty.fnt"];
    
    
    //if(ruleLabel.contentSize.width * ruleLabel.scaleX > _pBackTexture.contentSize.width * _pBackTexture.scaleX)
        //ruleLabel.scaleX = (_pBackTexture.contentSize.width*0.8*_pBackTexture.scaleX)/ruleLabel.contentSize.width;
    
    label.position = ccp((-_pBackTexture.contentSize.width*_pBackTexture.scaleX)/2 + label.contentSize.width,
                         (_pBackTexture.contentSize.height* _pBackTexture.scaleY)/2 - label.contentSize.height/1.5);
    
    label2.position = ccp((_pBackTexture.contentSize.width*_pBackTexture.scaleX)/2 - label2.contentSize.width,
                          (-_pBackTexture.contentSize.height*_pBackTexture.scaleY)/2 + label2.contentSize.height/1.5);
    ruleLabel.position = ccp(0,0);
    
    
    
    //label2.scaleY *= -1;
    //label2.scaleX *= -1;
    if(self.m_Suit < 2)
    {
        label.color = ccRED;
        label2.color = ccRED;
        ruleLabel.color = ccRED;
    }
    else
    {
        label.color = ccBLACK;
        label2.color = ccBLACK;
        ruleLabel.color = ccBLACK;
    }

    [allspritesNode addChild:front];
    [allspritesNode addChild:label];
    [allspritesNode addChild:label2];
    [allspritesNode addChild:ruleLabel];

    float duration_ = 0.1;
    
    [_pBackTexture.parent addChild:allspritesNode];
    CCActionInterval *a = [CCSequence actions:[CCDelayTime actionWithDuration:duration_],[CCActionTween actionWithDuration:duration_ key:@"scaleX" from:0 to:1], nil];
    [allspritesNode runAction:a];
    [_pBackTexture runAction:[CCActionTween actionWithDuration:duration_ key:@"scaleX" from:_pBackTexture.scaleX to:0]];
    allspritesNode.scaleX = 0;

    self.m_isFlipped = true;
    
}
- (void)dealloc
{
    
    
    [super dealloc];
}

- (void)Init:(int)a_Suit value:(int)a_Value texture:(NSString*)a_pTexturePath
{
    
    _Suit = a_Suit;
    _Value = a_Value;
    _pBackTexture = [[CCSprite alloc ]initWithFile:a_pTexturePath];
    _pFrontTexture = [[CCSprite alloc]initWithFile:@"WhiteRec.jpg"];
    self.m_isFlipped = false;
    
    
}

- (void)Draw:(CGPoint)a_Position
{
    
    _pBackTexture.position = ccp(a_Position.x,a_Position.y);
    //_pTexture.position = ccp(0,0);
    [self addChild:_pBackTexture];
    
    //_OriginalScale.x = _pTexture.scaleX;
    //_OriginalScale.y = _pTexture.scaleY;
    
}

- (void)Update
{
    
    //if(previousX == self.m_pTexture.parent.position.x)
        //return;
    
    float DisFromMid = self.m_pBackTexture.position.x - ((self.m_pBackTexture.contentSize.width/2)) + self.m_pBackTexture.parent.position.x - 160;
    
    if(DisFromMid < 1)
        DisFromMid *= -1;
    
    if(DisFromMid > 100)
    {
        
        self.m_pBackTexture.scaleX = _OriginalScale.x;
        self.m_pBackTexture.scaleY = _OriginalScale.y;
        
    }
    else
    {
        
        DisFromMid/=100;
        DisFromMid = 1-DisFromMid;
        
        DisFromMid = _OriginalScale.x * 2 * DisFromMid;
        self.m_pBackTexture.scaleX = _OriginalScale.x + DisFromMid;
        self.m_pBackTexture.scaleY = _OriginalScale.y + DisFromMid;
        
        
        
    }
    
    
    
    
    previousX = self.m_pBackTexture.parent.position.x;
    
}

- (NSString*)GenValLab
{
    
    NSMutableString *value = [[NSMutableString alloc] initWithString:@""];
    
    [value appendString:[NSString stringWithFormat:@"%i",self.m_Value + 1]];
    
    
    switch (self.m_Suit) {
        case 0:
            [value appendString:@"\n♥"];
            break;
        case 1:
            [value appendString:@"\n♦"];
            break;
        case 2:
            [value appendString:@"\n♠"];
            break;
        case 3:
            [value appendString:@"\n♣"];
            break;
            
        default:
            break;
    }
    

    
    return value;
    
    
}

@end
