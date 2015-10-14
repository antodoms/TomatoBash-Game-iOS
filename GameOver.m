//
//  GameOver.m
//  TomBash
//
//  Created by Anto Dominic on 09/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameOver.h"
#import "Gameplay.h"

@implementation GameOver{

   
}

CCTime timetaken,deltainterval;
int interval,totscore;

bool setup=NO;

@synthesize _iAdBannerView;
NSUserDefaults *prefs;
//static NSString * const kClientID = @"687616558651-jv42qdb47aahl15mkp496rc1f112ha3o.apps.googleusercontent.com";

- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = YES;
    
    [self initiAdBanner];
    
    interval = [Gameplay sharedInstance].scored / 40 ;
    totscore=0; deltainterval=0;
    timetaken=0;
    
    
    prefs = [NSUserDefaults standardUserDefaults];
    
    
    _levelover.string = [NSString stringWithFormat:@"LEVEL : %d",[Gameplay sharedInstance].leveled];
    _totalhits.string = [NSString stringWithFormat:@"TOTAL HITS : %d",[Gameplay sharedInstance].hited];
    
     NSLog(@"%d",[Gameplay sharedInstance].hited);
    
    _highscore.title = [NSString stringWithFormat:@"HIGH SCORE : %d",[self gethighscore:[Gameplay sharedInstance].scored]];
    
    [self getmaxhits:[Gameplay sharedInstance].hited];
    [self getlevel:[Gameplay sharedInstance].leveled];
    [self updategamenumber];
    
    //[MKiCloudSync start];
    
    
    [self loggedin];
    
    
    [self unlockachievements];
    [self publish];
        
}

-(void) highscorepress
{
    [_iAdBannerView removeFromSuperview];
    CCScene *gameplayScene2 = [CCBReader loadAsScene:@"HighScore"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene2];
}

-(void)loggedin{
   // [[GameCenterFiles sharedInstance] authenticateLocalUser];
    [ABGameKitHelper sharedHelper];
    

    if ([GKLocalPlayer localPlayer].authenticated) {
         _publishtext.title = [NSString stringWithFormat:@"SEE LEADERBOARD"];
  /*      if ([GPGManager sharedInstance].signedIn) {
            
        } else {
            // Display "Sign in with Google to use leaderboards!" message
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
    else{
         _publishtext.title = [NSString stringWithFormat:@"PUBLISH TO LEADERBOARD"];
        @try {
            
            [ABGameKitHelper sharedHelper];
            

          //  [[GameCenterFiles sharedInstance] authenticateLocalUser];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
          //  [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(checkgamecenterlogin:) userInfo:nil repeats:NO];
            
        }
    }

}

- (void)checkgamecenterlogin:(int)sender {
    
    
    if ([GKLocalPlayer localPlayer].authenticated) {
    }
    else{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Game Center"
                              message:@"You are not Logged into GameCenter. Please Login From Gamecenter App to see the Leaderboard and other GameCenter features."
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Sign In to Game Center", nil];
    [alertView show];
    }
}

- (void) unlockachievements{
    
    if ( [Gameplay sharedInstance].scored > 1000)
    {
        NSLog(@"Achievements Rookie unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQBw";
      //  [gameCenterManager submitAchievement:achievementId percentComplete:100];
        [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Rookie Badge" identifier:achievementId];
        
/*        GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
 */
    }
    
    if([Gameplay sharedInstance].leveled > 80)
    {
        NSLog(@"Achievements Survival unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQCA";
       [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
       [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Survival Badge" identifier:achievementId];
        
/*        GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
 */
    }
        
    if( [Gameplay sharedInstance].scored > 4000)
    {
        NSLog(@"Achievements Regular unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQBg";
        [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Regular Badge" identifier:achievementId];
        
 /*       GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
 */
    }
        
    if( [Gameplay sharedInstance].scored > 7000)
    {
        NSLog(@"Achievements Hunter unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQBQ";
        [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Hunter Badge" identifier:achievementId];
        
/*        GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
 */
    }
        
    if([Gameplay sharedInstance].leveled > 150)
    {
        NSLog(@"Achievements Survival Expert unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQCQ";
       [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Survival Expert Badge" identifier:achievementId];
        
 /*       GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
  */
    }
        
    if(((int)[prefs integerForKey:@"totalhits"]) > 300000)
    {
        NSLog(@"Achievements Rockstar unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQCw";
      [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Rockstar Badge" identifier:achievementId];
        
/*        GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
 */
    }
        
    if( [Gameplay sharedInstance].scored > 10000)
    {
        NSLog(@"Achievements Maestro unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQBA";
      [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Maestro Badge" identifier:achievementId];
        
  /*      GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
   */
    }
        
    if( [Gameplay sharedInstance].scored > 15000)
    {
        NSLog(@"Achievements Invincible unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQAw";
      [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Invincible Badge" identifier:achievementId];
        
  /*      GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
   */
    }
    if( [Gameplay sharedInstance].leveled > 300)
    {
        NSLog(@"Achievements BEAR GRYLLS ULTIMATE unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQCg";
       [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Bear Grylls Ultimate Badge" identifier:achievementId];
        
   /*     GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
    */
    }
        
    if(((int)[prefs integerForKey:@"totalwednesday"]) >= 6)
    {
        NSLog(@"Achievements BOUNTY WEDNESDAY unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQDA";
        [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Bounty Wednesday Badge" identifier:achievementId];
        
   /*     GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
    */
    }
        
    if(((int)[prefs integerForKey:@"11daystreak"]) >= 6)
    {
        NSLog(@"Achievements 11 Day streak unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQDQ";
       [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked 11 Days Streak Badge" identifier:achievementId];
        
   /*     GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
    
    */
        }
        
    if(((int)[prefs integerForKey:@"totalgames"]) >= 6)
    {
        NSLog(@"Achievements Legends unlocked");
        NSString *achievementId = @"CgkIu4yQyYEUEAIQDg";
        [[ABGameKitHelper sharedHelper] reportAchievement:achievementId percentComplete:100.0f];
        [[ABGameKitHelper sharedHelper] showNotification:@"Congratulation" message:@"You have Unlocked Legends Badge" identifier:achievementId];
        
 /*       GPGAchievement *unlockMe = [GPGAchievement achievementWithId:achievementId];
        [unlockMe unlockAchievementWithCompletionHandler:^(BOOL newlyUnlocked, NSError *error) {
            if (error) {
                // Handle the error
            } else if (!newlyUnlocked) {
                // Achievement was already unlocked
            } else {
                NSLog(@"Hooray! Achievement unlocked!");
            }
        }];
    }
  */
    }
    }
        
- (void)update:(CCTime)delta{
    
    timetaken+=delta;
    if(timetaken < 1.9)
    {
        deltainterval+=delta;
        if (deltainterval > 0.05 && (totscore <=  [Gameplay sharedInstance].scored)) {
            deltainterval=0;
            totscore=totscore+interval;
            _scoreover.string = [NSString stringWithFormat:@"SCORE : %d",totscore];
            
        }
    }
    else if (timetaken > 1.9 && timetaken <2.5)
        _scoreover.string = [NSString stringWithFormat:@"SCORE : %d",[Gameplay sharedInstance].scored];
    
    
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

-(int)gethighscore :(int) score{
    
    int maxscore = (int) [prefs integerForKey:@"highscore"];
    
    if(!maxscore)
    {
        [prefs setInteger:0 forKey:@"highscore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if( score > maxscore)
    {
         [prefs setInteger:score forKey:@"highscore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        maxscore = score;
    }
    
    return maxscore;
}

-(void)getmaxhits :(int) hits{
    
    int maxhits = (int)[prefs integerForKey:@"maxhits"];
    
    if(!maxhits)
    {
        [prefs setInteger:0 forKey:@"maxhits"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (hits > maxhits) {
        [prefs setInteger:hits forKey:@"maxhits"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        maxhits = hits;
    }
}

-(void)gettotalhits :(int)hits{
    int totalhits = (int)[prefs integerForKey:@"totalhits"];
    
    if(!totalhits)
    {
        [prefs setInteger:0 forKey:@"totalhits"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    totalhits+=hits;
    [prefs setInteger:totalhits forKey:@"totalhits"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)getlevel :(int) level{
    
    int maxlevel = (int)[prefs integerForKey:@"maxlevel"];
    
    if(!maxlevel)
    {
        [prefs setInteger:0 forKey:@"maxlevel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (level > maxlevel)
    {
        [prefs setInteger:level forKey:@"maxlevel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        maxlevel = level;
    }
}

-(void)updategamenumber {
    
    int games = (int)[prefs integerForKey:@"totalgames"];
    
    if(!games)
    {
        [prefs setInteger:0 forKey:@"totalgames"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    games+=1;
    [prefs setInteger:games forKey:@"totalgames"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void) playagain
{
    [_iAdBannerView removeFromSuperview];
    
    CCScene *gameplayScene = [CCBReader loadAsScene:@"ReadySetGo"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void) share
{
    
    NSString *text = [NSString stringWithFormat:@":) Beat my score, %d",[self gethighscore:0]];
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/tomato-bash/id931276952/"];
    UIImage *image = [UIImage imageNamed:@"Icon-60@2x"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url, image]
     applicationActivities:nil];
    
    [[CCDirector sharedDirector] presentViewController:controller animated:YES completion:nil];
    
    
}

- (void) menu
{
    [_iAdBannerView removeFromSuperview];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void) publish {
    
    if ([GKLocalPlayer localPlayer].authenticated) {
      
        int highscorevalue= [self gethighscore :0];
   // NSLog(@"high score is: %d",highscorevalue);
//    NSString *highScoreLead = @"CgkIu4yQyYEUEAIQFg";
    
 //   [gameCenterManager reportScore:highscorevalue forCategory:@"GHS"];
     [[ABGameKitHelper sharedHelper] reportScore:highscorevalue forLeaderboard:@"HIGH"];
    
/*    GPGScore *myScore = [[GPGScore alloc] initWithLeaderboardId:highScoreLead];
    myScore.value = highscorevalue;
    [myScore submitScoreWithCompletionHandler: ^(GPGScoreReport *report, NSError *error) {
        if (error) {
            // Handle the error
        } else {
            // Analyze the report, if you'd like
        }
    }];
 */
    }
    else{
        [ABGameKitHelper sharedHelper];
    }
}

- (void) published {
    
    if ([GKLocalPlayer localPlayer].authenticated) {
        _publishtext.title = @"SEE LEADERBOARD";
        
        [[ABGameKitHelper sharedHelper] showLeaderboard:@"HIGH"];
    }
    else{
        [ABGameKitHelper sharedHelper];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)match:(GKMatch *)theMatch didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    // The match received data sent from the player.
   
}

-(void) matchEnded
{
    
}
-(void) matchStarted{
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gamecenter:"]];
    }
}
    
@end
