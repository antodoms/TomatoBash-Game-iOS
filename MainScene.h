//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CCNode.h"
#import "cocos2d.h"
//#import <GooglePlayGames/GooglePlayGames.h>
#import "ABGameKitHelper.h"
#import "MKiCloudSync.h"
#import <AudioToolbox/AudioServices.h>
#import <iAd/iAd.h>

@interface MainScene : CCNode </*GPGStatusDelegate,*/ADBannerViewDelegate> {
    
    CCButton *_viberon;
    CCButton *_viberoff;
    CCButton *_sounderon;
    CCButton *_sounderoff;
}
@property (atomic, retain) ADBannerView* _iAdBannerView;
@end
