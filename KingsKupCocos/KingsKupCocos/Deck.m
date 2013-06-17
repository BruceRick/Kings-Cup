//
//  Deck.m
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-04-11.
//
//

#import "Deck.h"

const int _Decksize = 52;
const int _NumberOfCards = 13;
float _CardOffset;
CGPoint CardSize;
CGSize winSize;


@implementation Deck
{
    
}

@synthesize m_pAllCards = _pAllCards;
@synthesize m_pDeck = _pDeck;
@synthesize m_pCardTexture = _pCardTexture;
@synthesize m_Position = _Position;


- (void)Initialize:(NSString*)a_pCardTexturePath
{
    
    winSize = [CCDirector sharedDirector].winSize;
    
    self.m_pAllCards = [[NSMutableArray alloc] init];
    self.m_pDeck = [[NSMutableArray alloc] init];
    self.m_pCardTexture = [[CCSprite alloc ]initWithFile:a_pCardTexturePath];
    
    
    float CardHWRatio = self.m_pCardTexture.contentSize.height/self.m_pCardTexture.contentSize.width;
    
    CardSize = ccp(0,0);
    CardSize.y = winSize.height/4;
    CardSize.x = CardSize.y/CardHWRatio;
    
    _CardOffset = CardSize.x/2;
    
    for(int i = 0; i < _Decksize; i++)
    {
        
        Card * _newCard = [Card alloc];
        
        int suit = (i+1)/_NumberOfCards;
        int value = i - (_NumberOfCards*suit);
        
        [_newCard Init:suit :value:a_pCardTexturePath];
        
        [_pAllCards addObject:_newCard];
        
    }
    
}

- (void)Shuffle
{
    
    int _CardsLeft = _Decksize;
    
    for(int i = 0; i < _Decksize; i++)
    {
        //( (arc4random() % (max-min+1)) + min );
        
        //int _randomCard = (( arc4random()% (_CardsLeft-0+1)));
        
        [_pDeck addObject:[_pAllCards objectAtIndex:i]];
        //[m_pAllCards removeObjectAtIndex:i];
        
        //m_allCards
        _CardsLeft--;
        
        
    }
    
    
    
    
}

- (void)DrawCards
{
    
    CGPoint _CardPosition = ccp(0,0);
    
    
    
    for( int i = 0; i <  _pDeck.count; i++)
    {
        
        Card *card = [_pDeck objectAtIndex:i];
        
        card.m_pBackTexture.scaleX = CardSize.x/card.m_pBackTexture.contentSize.width;
        card.m_pBackTexture.scaleY = CardSize.y/card.m_pBackTexture.contentSize.height;
        //ccColor3B tint = ccc3(255, 0, 0);
        
        //[card setColor:tint];
        
        //CCFiniteTimeAction *it = [CCTintTo actionWithDuration:0.1 red:255 green:0 blue:0];
        
        //[card runAction:it];
        
        //card.m_pTexture.color = tint;
        //card.m_pTexture.scaleX /= 2;
        //card.m_pTexture.scaleY /= 2;
        
        _CardPosition.x = i * (card.m_pBackTexture.contentSize.width * card.m_pBackTexture.scaleX);
        _CardPosition.y = winSize.height/2;
        
        card.m_OriginalScale =  ccp(card.m_pBackTexture.scaleX,card.m_pBackTexture.scaleY);
        
        
        
        
        card.m_pBackTexture.position = ccp(_CardPosition.x,_CardPosition.y);
        
        
        [self addChild:card.m_pBackTexture];

        [card release];
        
    }
    
    
    [self updateCards];

    
    
}

- (void)dealloc
{
    for(int i = 0; i < _pAllCards.count; i++)
    {
        [[_pAllCards objectAtIndex:i] release];
    }
    
    for(int i = 0; i < _pDeck.count; i++)
    {
        [[_pDeck objectAtIndex:i] release];
    }
    
    
    //[_pAllCards release];
    //[_pDeck release];
    [_pCardTexture release];
    [super dealloc];
}



- (void)updateCards
{
    CGPoint _CardPosition = ccp(0,0);
    
    for( int i = 0; i < self.children.count
        ; i++)
    {
        
        
        
        CCSprite *card = (CCSprite *)[self.children objectAtIndex:i];
        
        _CardPosition.x += card.contentSize.width* card.scaleX;
        _CardPosition.y = winSize.height/2;
        
        
        //card.position = ccp(_CardPosition.x,_CardPosition.y);
        
        //[[_pDeck objectAtIndex:i] Update];
        
        
        
        
        
        float DisFromMid = card.position.x + self.position.x - 160;
        
        if(DisFromMid < 1)
            DisFromMid *= -1;
        
        
        if(DisFromMid > 150)
        {
            
            card.scaleX = CardSize.x/card.contentSize.width;
            card.scaleY = CardSize.y/card.contentSize.height;
            
        }
        else
        {
            
            CGPoint _OriginalScale = ccp(CardSize.x/card.contentSize.width, CardSize.y/card.contentSize.height);
            
            DisFromMid/=150;
            DisFromMid = 1-DisFromMid;
            
            DisFromMid = _OriginalScale.x * 1.5 * DisFromMid;
            card.scaleX = _OriginalScale.x + DisFromMid;
            card.scaleY = _OriginalScale.y + DisFromMid;
            
        }

        //[card release];
        
    }
    
    
    
}


@end
