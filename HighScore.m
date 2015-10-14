//
//  HighScore.m
//  TomatoBash
//
//  Created by Anto Dominic on 22/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "HighScore.h"

@implementation HighScore {
    
     BOOL _silentlySigningIn;
}
@synthesize _iAdBannerView;
NSString *_leaderboardIdentifier;

CCTime timetaken,deltainterval;
int interval,totscore,highscore;
NSUserDefaults *prefs;

BOOL gamecentercheck=YES;
UIView *myView;
int gamecentercount=0;
BOOL toggle=true;
BOOL buttonactivate = false;
//static NSString * const kClientID = @"687616558651-jv42qdb47aahl15mkp496rc1f112ha3o.apps.googleusercontent.com";

- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = YES;
    
 //   [GPGManager sharedInstance].statusDelegate = self;
    
    _leader.visible=false;
    _achieve.visible=false;
    toggle=false;
    buttonactivate = false;
    [self initiAdBanner];
    
    prefs = [NSUserDefaults standardUserDefaults];
   
    
    
    highscore= (int) [prefs integerForKey:@"highscore"];
    interval = highscore / 40;
    totscore=0; deltainterval=0;
    timetaken=0;
    
    
    _levelover.string = [NSString stringWithFormat:@"%d LEVELS",[self getlevel]];
    _totalhits.string = [NSString stringWithFormat:@"%d HITS",[self getmaxhits]];
    
    gamecentercount =0;
   // [[GameCenterFiles sharedInstance] authenticateLocalUser];
   // [[ABGameKitHelper sharedHelper] resetAchievements];
}



- (void)update:(CCTime)delta{
    
    timetaken+=delta;
    if(timetaken < 2.2)
    {
        deltainterval+=delta;
        if (deltainterval > 0.05 && (totscore <= highscore)) {
            deltainterval=0;
            totscore=totscore+interval;
            _highscore.string = [NSString stringWithFormat:@"%d",totscore];
            
        }
    }
    else if (timetaken > 2.3 && timetaken <2.5)
        _highscore.string = [NSString stringWithFormat:@"%d",highscore];
    
    if (timetaken > 2.5 && timetaken < 3.5) {
        buttonactivate=true;
    }
    
}



-(int)gethighscore {
    
    int maxscore = (int)[prefs integerForKey:@"highscore"];
    if(!maxscore)
        [prefs setInteger:0 forKey:@"maxscore"];
    
    return maxscore;
}

-(int)getmaxhits {

    int maxhits = (int)[prefs integerForKey:@"maxhits"];
    
    if(!maxhits)
        [prefs setInteger:0 forKey:@"maxhits"];
    
    return maxhits;
    
}

-(int)getlevel {
    
    int maxlevel = (int)[prefs integerForKey:@"maxlevel"];
    
    if (!maxlevel) {
        
            [prefs setInteger:0 forKey:@"maxlevel"];
    }
    
    return maxlevel;
}



- (void)gamecenter {

    gamecentercount+=1;

    if ([GKLocalPlayer localPlayer].authenticated) {
    [[ABGameKitHelper sharedHelper] showLeaderboard:@"GHS"];
   //     [[ABGameKitHelper sharedHelper] showAchievements];
        

        
    }
    else{
        
        @try {
             [ABGameKitHelper sharedHelper];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
       }
    if( gamecentercount>5 && ![GKLocalPlayer localPlayer].authenticated)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Game Center"
                                  message:@"You are not Logged into GameCenter. Please Login From Gamecenter App to see the Leaderboard and other GameCenter features."
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Sign In to Game Center", nil];
        [alertView show];
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
    bannerFrame.origin.y = contentFrame.size.height-50;
    
    _iAdBannerView.frame = bannerFrame;
    
}

- (void) googleplay {
   
/*    if ([GPGManager sharedInstance].signedIn) {
        
        if(buttonactivate==true)
        {
            
            if (toggle==false) {
                [_totalhits runAction:[CCActionScaleTo actionWithDuration:0.5 scale:0.4]];
                [_and runAction:[CCActionScaleTo actionWithDuration:0.5 scale:0.4]];
                [_in runAction:[CCActionScaleTo actionWithDuration:0.5 scale:0.4]];
                [_highscore runAction:[CCActionScaleTo actionWithDuration:0.5 scale:0.4]];
                [_levelover runAction:[CCActionScaleTo actionWithDuration:0.5 scale:0.4]];
                
                [_leader runAction:[CCActionScaleTo actionWithDuration:0.5 scale:1]];
                [_achieve runAction:[CCActionScaleTo actionWithDuration:0.5 scale:1]];
                _totalhits.visible = false;
                _and.visible = false;
                _in.visible = false;
                _highscore.visible=false;
                _levelover.visible=false;
                _leader.visible=true;
                _achieve.visible=true;
                toggle=true;
                
            }
            else{
                [_leader runAction:[CCActionScaleTo actionWithDuration:0.5 scale:0.5]];
                [_achieve runAction:[CCActionScaleTo actionWithDuration:0.5 scale:0.5]];
                
                [_totalhits runAction:[CCActionScaleTo actionWithDuration:0.5 scale:1]];
                [_and runAction:[CCActionScaleTo actionWithDuration:0.5 scale:1]];
                [_in runAction:[CCActionScaleTo actionWithDuration:0.5 scale:1]];
                [_highscore runAction:[CCActionScaleTo actionWithDuration:0.5 scale:1]];
                [_levelover runAction:[CCActionScaleTo actionWithDuration:0.5 scale:1]];
                
                _totalhits.visible = true;
                _and.visible = true;
                _in.visible = true;
                _highscore.visible=true;
                _levelover.visible=true;
                _leader.visible=false;
                _achieve.visible=false;
                toggle=false;
            }
        }

        
    } else {
        // Display "Sign in with Google to use leaderboards!" message
        @try {
            [[GPGManager sharedInstance] signInWithClientID:kClientID silently:NO];
        }
        @catch (NSException *exception) {
            NSLog(@"no internet connection");
        }
        @finally {
            NSLog(@"watever");
            
        }
        
        
    }
  
  */
    
   /*
 
    [[NSBundle mainBundle] loadNibNamed:@"googleplay" owner:self options:nil];
    myView = [[[NSBundle mainBundle] loadNibNamed:@"googleplay" owner:self options:nil] objectAtIndex:0];
    [[[CCDirector sharedDirector] view] addSubview:myView];
 */   
}

- (void) backbutton
{
    [_iAdBannerView removeFromSuperview];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
}



- (void)didFinishGamesSignInWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received an error while signing in %@", [error localizedDescription]);
    } else {
        NSLog(@"Signed in!");
    }
    
    _silentlySigningIn = NO;
    [self refreshInterfaceBasedOnSignIn];
}

- (void)didFinishGamesSignOutWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received an error while signing out %@", [error localizedDescription]);
    } else {
        NSLog(@"Signed out!");
    }
    
    _silentlySigningIn = NO;
    [self refreshInterfaceBasedOnSignIn];
}

- (void)refreshInterfaceBasedOnSignIn {

    
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gamecenter:"]];
    }
}

-(void)matchEnded{
    
}
-(void) matchStarted{
    
}
-(void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID{
    
}

/*
-(void)selectLeaderboard {

    
    if ([GPGManager sharedInstance].signedIn) {
        NSLog(@"SIGNED IN ALREADY\n\n");
        NSString *targetLeaderboardId = @"CgkIu4yQyYEUEAIQFg";
        [[GPGLauncherController sharedInstance] presentLeaderboardWithLeaderboardId:targetLeaderboardId];
        
    } else {
        // Display "Sign in with Google to use leaderboards!" message
        
        //  [[GPGManager sharedInstance] signInWithClientID:kClientID silently:YES];
        
    }

}

-(void)selectAchievements {
    if ([GPGManager sharedInstance].signedIn) {
        // Submit score to leaderboard!
        NSLog(@"SIGNED IN ALREADY\n\n");
        //  [[GPGManager sharedInstance] signOut];
        [[GPGLauncherController sharedInstance] presentAchievementList];
        
    } else {
        // Display "Sign in with Google to use leaderboards!" message
        @try {
            [[GPGManager sharedInstance] signInWithClientID:kClientID silently:NO];
        }
        @catch (NSException *exception) {
            NSLog(@"no internet connection");
        }
        @finally {
            NSLog(@"watever");
            
        }
        
        
    }
    
}
 */
@end
