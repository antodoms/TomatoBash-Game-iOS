//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "cocos2d.h"


@implementation MainScene

@synthesize _iAdBannerView;
NSArray* soundFiles;
OALSimpleAudio *splash;
//static NSString * const kClientID = @"687616558651-jv42qdb47aahl15mkp496rc1f112ha3o.apps.googleusercontent.com";
NSUserDefaults *prefs;

int maincounter=0;
- (void) didLoadFromCCB {
    
   [ABGameKitHelper sharedHelper];
     prefs = [NSUserDefaults standardUserDefaults];
     self.userInteractionEnabled = TRUE;
    
    
    maincounter=0;
    
    soundFiles = @[@"1.wav",@"2.wav",@"3.wav",@"4.wav",@"explosion.wav",@"fail.wav",@"laugh",@"magicwand.wav",@"splash.wav",@"win.wav",@"wing.wav"];
    
    [[OALSimpleAudio sharedInstance] preloadEffects:soundFiles reduceToMono:NO progressBlock:^(NSUInteger progress,NSUInteger successCount,NSUInteger total)
     {
         if (successCount == total)
         {
             CCLOG(@"Sound files loaded!");
         }
     }];
    
    if(![prefs boolForKey:@"initial"])
    {
        [prefs setBool:true forKey:@"initial"];
        [prefs setBool:true forKey:@"sound"];
        [prefs setBool:true forKey:@"vibrate"];
    }
    [self initiAdBanner];

    if ([prefs boolForKey:@"sound"]!=false)
    {
        _sounderoff.visible=false;
        _sounderon.visible=true;
    }
    else
    {
        _sounderon.visible=false;
        _sounderoff.visible=true;
    }
    
    if ([prefs boolForKey:@"vibrate"]!=false)
    {
        _viberoff.visible=false;
        _viberon.visible=true;
    }
    else
    {
        _viberon.visible=false;
        _viberoff.visible=true;
    }
    
/*    if (![GPGManager sharedInstance].signedIn) {
        @try {
            [[GPGManager sharedInstance] signInWithClientID:kClientID silently:YES];
        }
        @catch (NSException *exception) {
            NSLog(@"no internet connection");
        }
        @finally {
            NSLog(@"watever");
        }
    }
   */
}

- (void) play
{
    if (maincounter==0) {
        maincounter=1;
    [_iAdBannerView removeFromSuperview];
   if ([prefs boolForKey:@"sound"])
    [[OALSimpleAudio sharedInstance] playEffect:@"splash.wav" loop:NO];
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"ReadySetGo"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
    }
}

- (void) highscore
{
    if (maincounter==0) {
        maincounter=1;
    [_iAdBannerView removeFromSuperview];
    if ([prefs boolForKey:@"sound"])
    [[OALSimpleAudio sharedInstance] playEffect:@"splash.wav" loop:NO];
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"HighScore"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    }
}



-(void) soundon
{
    
    _sounderoff.visible = true;
    _sounderon.visible = false;
    [prefs setBool:false forKey:@"sound"];
}
-(void) soundoff
{
    
    [[OALSimpleAudio sharedInstance] playEffect:@"splash.wav" loop:NO];
    _sounderon.visible = true;
    _sounderoff.visible = false;
    [prefs setBool:true forKey:@"sound"];
}

-(void) vibeon
{
   
    _viberon.visible = false;
    _viberoff.visible = true;
    [prefs setBool:false forKey:@"vibrate"];
}
-(void) vibeoff
{
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    _viberon.visible = true;
    _viberoff.visible = false;
    [prefs setBool:true forKey:@"vibrate"];
}

- (void) help
{
    if (maincounter==0) {
        maincounter=1;
    [_iAdBannerView removeFromSuperview];
    if ([prefs boolForKey:@"sound"])
    [[OALSimpleAudio sharedInstance] playEffect:@"splash.wav" loop:NO];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"help"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    }
}

-(void) initiAdBanner {
    
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        _iAdBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        
    } else {
        _iAdBannerView = [[ADBannerView alloc] init];
    }
    
    [_iAdBannerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [[[UIApplication sharedApplication].keyWindow rootViewController].view addSubview:_iAdBannerView];
    [_iAdBannerView setBackgroundColor:[UIColor clearColor]];
    [[[UIApplication sharedApplication].keyWindow rootViewController].view addSubview:_iAdBannerView];
    _iAdBannerView.delegate = self;
    
    [[[UIApplication sharedApplication].keyWindow rootViewController].view bringSubviewToFront:_iAdBannerView];
    CGRect bannerFrame = _iAdBannerView.frame;
    CGRect contentFrame = [[UIApplication sharedApplication].keyWindow rootViewController].view.bounds;
    bannerFrame.origin.y = 0;
    
    _iAdBannerView.frame = bannerFrame;
    
}

@end
