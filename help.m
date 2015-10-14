//
//  help.m
//  TomatoBash
//
//  Created by Anto Dominic on 28/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "help.h"


@implementation help{
    CCLabelTTF *_firsttext;
    CCSprite *_firstreda;
    CCSprite *_firstredb;
    CCSprite *_firstredc;
    CCSprite *_firstredd;
    CCButton *_firstbutton;
    
    CCLabelTTF *_secondtext;
    CCSprite *_secondred;
    CCButton *_secondbutton;
    
    CCLabelTTF *_thirdtext;
    CCSprite *_thirdred;
    CCButton *_thirdbutton;
    
    CCLabelTTF *_fourthtext;
    CCSprite *_fourthreda;
    CCSprite *_fourthredb;
    CCButton *_fourthbutton;
    
    CCLabelTTF *_fifthtext;
    CCSprite *_fifthreda;
    CCSprite *_fifthredb;
    CCSprite *_fifthredc;
    CCButton *_fifthbutton;
}
@synthesize _iAdBannerView;
NSUserDefaults *prefs;
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
   prefs = [NSUserDefaults standardUserDefaults];
    _firsttext.visible=true; _firsttext.scale=2;
    _firstreda.visible=true; _firstreda.opacity=0;
    _firstredb.visible=true; _firstredb.opacity=0;
    _firstredc.visible=true; _firstredc.opacity=0;
    _firstredd.visible=true; _firstredd.opacity=0;
    _firstbutton.visible=true; _firstbutton.scale=0;
    
    [_firsttext runAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.5 scale:1], nil]];
    [_firstreda runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.7],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_firstredb runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.7],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_firstredc runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.7],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_firstredd runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.7],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_firstbutton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.2],[CCActionScaleTo actionWithDuration:0.3 scale:1], nil]];
    
    _secondtext.visible=false;
    _secondred.visible=false;
    _secondbutton.visible=false;
    
    _thirdtext.visible=false;
    _thirdred.visible=false;
    _thirdbutton.visible=false;
    
    _fourthtext.visible=false;
    _fourthreda.visible=false;
    _fourthredb.visible=false;
    _fourthbutton.visible=false;
    
    _fifthtext.visible=false;
    _fifthreda.visible=false;
    _fifthredb.visible=false;
    _fifthredc.visible=false;
    _fifthbutton.visible=false;
    
    
}

-(void) first{
    if ([prefs boolForKey:@"sound"])
        [[OALSimpleAudio sharedInstance] playEffect:@"wing.wav" loop:NO];
    
    [self initiAdBanner];
    
//    _firsttext.visible=false;
//    _firstreda.visible=false;
//    _firstredb.visible=false;
//    _firstredc.visible=false;
//    _firstredd.visible=false;
    _firstbutton.visible=false;
    
    [_firsttext runAction:[CCActionSequence actions:[CCActionFadeOut actionWithDuration:0.3], nil]];
    [_firstreda runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5],[CCActionFadeOut actionWithDuration:0.3], nil]];
    [_firstredb runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5],[CCActionFadeOut actionWithDuration:0.3], nil]];
    [_firstredc runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5],[CCActionFadeOut actionWithDuration:0.3], nil]];
    [_firstredd runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5],[CCActionFadeOut actionWithDuration:0.3], nil]];
    
    _secondtext.visible=true; _secondtext.opacity=0;
    _secondred.visible=true; _secondred.opacity=0;
    _secondbutton.visible=true; _secondbutton.scale=0;
    _secondtext.scale=2;
    [_secondtext runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1],[CCActionFadeIn actionWithDuration:0.3],[CCActionScaleTo actionWithDuration:0.5 scale:1], nil]];
    [_secondred runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.5],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_secondbutton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.6],[CCActionFadeIn actionWithDuration:0.3],[CCActionScaleTo actionWithDuration:0.3 scale:1], nil]];
   
    
    _thirdtext.visible=false;
    _thirdred.visible=false;
    _thirdbutton.visible=false;
    
    _fourthtext.visible=false;
    _fourthreda.visible=false;
    _fourthredb.visible=false;
    _fourthbutton.visible=false;
    
    _fifthtext.visible=false;
    _fifthreda.visible=false;
    _fifthredb.visible=false;
    _fifthredc.visible=false;
    _fifthbutton.visible=false;
}
-(void) second{
    if ([prefs boolForKey:@"sound"])
        [[OALSimpleAudio sharedInstance] playEffect:@"wing.wav" loop:NO];
    _firsttext.visible=false;
    _firstreda.visible=false;
    _firstredb.visible=false;
    _firstredc.visible=false;
    _firstredd.visible=false;
    _firstbutton.visible=false;
    
  //  _secondtext.visible=false;
 //   _secondred.visible=false;
    _secondbutton.visible=false;
    
    [_secondtext runAction:[CCActionSequence actions:[CCActionFadeOut actionWithDuration:0.3], nil]];
    [_secondred runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5],[CCActionFadeOut actionWithDuration:0.3], nil]];
    
    
    _thirdtext.visible=true; _thirdtext.opacity=0;
    _thirdred.visible=true; _thirdred.opacity=0;
    _thirdbutton.visible=true; _thirdbutton.scale=0;
    _thirdtext.scale=2;
    [_thirdtext runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1],[CCActionFadeIn actionWithDuration:0.3],[CCActionScaleTo actionWithDuration:0.3 scale:1], nil]];
    [_thirdred runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.5],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_thirdbutton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.8],[CCActionFadeIn actionWithDuration:0.3],[CCActionScaleTo actionWithDuration:0.3 scale:1], nil]];
    
    _fourthtext.visible=false;
    _fourthreda.visible=false;
    _fourthredb.visible=false;
    _fourthbutton.visible=false;
    
    _fifthtext.visible=false;
    _fifthreda.visible=false;
    _fifthredb.visible=false;
    _fifthredc.visible=false;
    _fifthbutton.visible=false;
}
-(void) third {
    if ([prefs boolForKey:@"sound"])
        [[OALSimpleAudio sharedInstance] playEffect:@"wing.wav" loop:NO];
    _firsttext.visible=false;
    _firstreda.visible=false;
    _firstredb.visible=false;
    _firstredc.visible=false;
    _firstredd.visible=false;
    _firstbutton.visible=false;
    
    _secondtext.visible=false;
    _secondred.visible=false;
    _secondbutton.visible=false;
    
  //  _thirdtext.visible=false;
   // _thirdred.visible=false;
    _thirdbutton.visible=false;
    
    [_thirdtext runAction:[CCActionSequence actions:[CCActionFadeOut actionWithDuration:0.3], nil]];
    [_thirdred runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5],[CCActionFadeOut actionWithDuration:0.3], nil]];
    
    _fourthtext.visible=true; _fourthtext.opacity=0;
    _fourthreda.visible=true; _fourthreda.opacity=0;
    _fourthredb.visible=true; _fourthredb.opacity=0;
    _fourthbutton.visible=true;  _fourthbutton.scale=0;
    _fourthtext.scale=2;
    [_fourthtext runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1],[CCActionFadeIn actionWithDuration:0.3],[CCActionScaleTo actionWithDuration:0.3 scale:1], nil]];
    [_fourthreda runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.5],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_fourthredb runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.5],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_fourthbutton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.8],[CCActionFadeIn actionWithDuration:0.3],[CCActionScaleTo actionWithDuration:0.3 scale:1], nil]];
    
    _fifthtext.visible=false;
    _fifthreda.visible=false;
    _fifthredb.visible=false;
    _fifthredc.visible=false;
    _fifthbutton.visible=false;
}
-(void) fourth{
    if ([prefs boolForKey:@"sound"])
        [[OALSimpleAudio sharedInstance] playEffect:@"wing.wav" loop:NO];
    _firsttext.visible=false;
    _firstreda.visible=false;
    _firstredb.visible=false;
    _firstredc.visible=false;
    _firstredd.visible=false;
    _firstbutton.visible=false;
    
    _secondtext.visible=false;
    _secondred.visible=false;
    _secondbutton.visible=false;
    
    _thirdtext.visible=false;
    _thirdred.visible=false;
    _thirdbutton.visible=false;
    
  //  _fourthtext.visible=false;
  //  _fourthreda.visible=false;
   // _fourthredb.visible=false;
    _fourthbutton.visible=false;
    
    [_fourthtext runAction:[CCActionSequence actions:[CCActionFadeOut actionWithDuration:0.3], nil]];
    [_fourthreda runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5],[CCActionFadeOut actionWithDuration:0.3], nil]];
    [_fourthredb runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5],[CCActionFadeOut actionWithDuration:0.3], nil]];
    
    _fifthtext.visible=true;
    _fifthreda.visible=true;
    _fifthredb.visible=true;
    _fifthredc.visible=true;
    _fifthbutton.visible=true;
    
    _fifthtext.visible=true; _fifthtext.opacity=0;
    _fifthreda.visible=true; _fifthreda.opacity=0;
    _fifthredb.visible=true; _fifthredb.opacity=0;
    _fifthredc.visible=true; _fifthredc.opacity=0;
    _fifthbutton.visible=true;  _fifthbutton.scale=0;
    _fifthtext.scale=2;
    [_fifthtext runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1],[CCActionFadeIn actionWithDuration:0.3],[CCActionScaleTo actionWithDuration:0.3 scale:1], nil]];
    [_fifthreda runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.5],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_fifthredb runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.5],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_fifthredc runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.5],[CCActionFadeIn actionWithDuration:0.3], nil]];
    [_fifthbutton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.8],[CCActionFadeIn actionWithDuration:0.3],[CCActionScaleTo actionWithDuration:0.3 scale:1], nil]];
}
-(void) mainmenu{
    [_iAdBannerView removeFromSuperview];
    if ([prefs boolForKey:@"sound"])
        [[OALSimpleAudio sharedInstance] playEffect:@"splash.wav" loop:NO];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
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



@end
