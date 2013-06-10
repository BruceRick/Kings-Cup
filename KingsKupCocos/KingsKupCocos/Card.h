//
//  Card.h
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-04-11.
//
//

#import "CCSprite.h"
#import "Deck.h"
#import "HelloWorldLayer.h"

@class HelloWorldLayer;
@class Deck;

@interface Card : CCSprite

@property (nonatomic, assign) int m_Suit;
@property (nonatomic, assign) int m_Value;
@property (nonatomic, assign) CGPoint m_Position;
@property (nonatomic, assign) CCSprite* m_pTexture;
@property (nonatomic, assign) Boolean m_isFlipped;
@property (nonatomic, assign) CGPoint m_OriginalScale;


- (void)dealloc;
- (void)Flip;
- (void)Init:(int)a_Suit:(int)a_Value:(NSString*)a_pTexture;
- (void)Draw:(CGPoint)a_Position;
- (void)Update;




@end
