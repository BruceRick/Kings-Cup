//
//  HelloWorldLayer.h
//  KingsKupCocos
//
//  Created by Bruce Rick on 2013-04-11.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "Deck.h"

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface GameLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    
    
    
}

- (void)Resume;
// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;

@end
