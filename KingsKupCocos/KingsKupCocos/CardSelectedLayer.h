//
//  CardSelectedLayer.h
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-06-13.
//
//

#import "CCLayer.h"
#import "Card.h"
#import "cocos2d.h"

@interface CardSelectedLayer : CCLayer

+(CCScene*)scene;
-(id)initWithCard:(Card*)a_pSelectedCard;
- (void)Tap:(UITapGestureRecognizer*)recognizer;

@end
