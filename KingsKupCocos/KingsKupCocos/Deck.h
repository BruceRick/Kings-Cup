//
//  Deck.h
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-04-11.
//
//

#import <Foundation/Foundation.h>
#import "CCSprite.h"
#import "Card.h"
#import "CCLayer.h"
#import "HelloWorldLayer.h"


@class HelloWorldLayer;
@class Card;

@interface Deck : CCSprite

@property (nonatomic, assign) CGPoint m_Position;

@property (nonatomic, assign) NSMutableArray *m_pDeck;

@property (nonatomic,assign) NSMutableArray *m_pAllCards;

@property (nonatomic, assign) CCSprite *m_pCardTexture;

- (void)Initialize:(NSString*)a_pCardTexturePath;
- (void)Shuffle;
- (void)DrawCards;
- (void)dealloc;
- (void)updateCards;




@end
