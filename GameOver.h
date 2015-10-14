//
//  GameOver.h
//  TomBash
//
//  Created by Anto Dominic on 09/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <iAd/iAd.h>
#import <CCActionInterval.h>
#import "MKiCloudSync.h"
//#import <GooglePlayGames/GooglePlayGames.h>
#import "ABGameKitHelper.h"

@interface GameOver : CCNode <ADBannerViewDelegate> {
    CCLabelTTF *_scoreover;
    CCLabelTTF *_levelover;
    CCLabelTTF *_totalhits;
    CCButton *_highscore;
    CCButton *_publishtext;
 //   GameCenterFiles *gameCenterManager;
}


@property (atomic, retain) ADBannerView* _iAdBannerView;

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController;
@end
