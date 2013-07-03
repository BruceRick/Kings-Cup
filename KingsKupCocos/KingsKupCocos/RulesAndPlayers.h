//
//  RulesAndPlayers.h
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-06-28.
//
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "NewRule.h"

@interface RulesAndPlayers : CCSprite <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, assign) NSMutableArray *m_pRules;
@property (nonatomic, assign) NSMutableArray *m_pPlayers;
@property (nonatomic, assign) NSDictionary *m_pData;
@property (nonatomic, assign) CCMenu *m_pMenu;


+ (RulesAndPlayers*)Instance;
- (void)Read;
- (void)Write;
- (void)ShowTable;
- (void)RemoveTable;


@end
