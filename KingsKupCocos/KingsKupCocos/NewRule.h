//
//  NewRule.h
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-07-02.
//
//

#import "CCLayer.h"
#import "cocos2d.h"


@interface NewRule : CCLayer

@property (nonatomic, assign) NSString* m_pRule;

+(CCScene *) scene;
-(void)Init:(NSString*)a_pRule;

@end
