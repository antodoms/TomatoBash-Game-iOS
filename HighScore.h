//
//  HighScore.h
//  TomatoBash
//
//  Created by Anto Dominic on 22/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//#import <GooglePlayGames/GooglePlayGames.h>
#import <iAd/iAd.h>
#import <CCActionInterval.h>
#import "ABGameKitHelper.h"


@interface HighScore : CCNode </*GPGStatusDelegate,*/ADBannerViewDelegate> {
    CCLabelTTF *_levelover;
    CCLabelTTF *_totalhits;
    CCLabelTTF *_highscore;
    CCLabelTTF *_and;
    CCLabelTTF *_in;
    CCButton *_achieve;
    CCButton *_leader;
    NSString *currentLeaderBoard;
    NSString *highScore;
    
}

@property (atomic, retain) ADBannerView* _iAdBannerView;

@end
