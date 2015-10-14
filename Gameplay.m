//
//  Gameplay.m
//  TomBash
//
//  Created by Anto Dominic on 31/07/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "tomato.h"
#import "GameOver.h"
#include "CCAnimatedSprite.h"
#import "CCAnimation.h"

@implementation Gameplay {
   CCLabelTTF *_score;
    CCLabelTTF *_gameover;
    CCSprite *mySprite;
    CCButton *_hourglass;
    CCSprite *_hourglow;
    CCLabelTTF *_hourtext;
    CCNodeGradient *_explodebg;
    
    int count;
    
}

@synthesize leveled;
@synthesize scored;
@synthesize highscored;
@synthesize hited;



int p_level=1;

int hits;
int level;
int score;
NSNumber *highscoregame;
NSUserDefaults *prefs;

NSString *combo;
int combovalue=1;
int bonus=0;
int totalred=0,redindex=7;
int maxSkulls=3,maxHots=3;
bool levelnew=YES;
bool gameover=NO;
bool nextlevel=NO;
bool hourglass=NO;
bool hourglassactivate=NO;
bool explosion=NO;
int hourglasscount=0;
int hourglassscore=0;

int counter=0;


int bombcount=0;
bool bombover=NO,bombend=NO;
CCTime startbomb,deltacheck;

CCAnimatedSprite *animatedSprite,*explosionsprite;
CCScene *bombing;

CCSprite *refill;

OALSimpleAudio *splash;
NSArray* soundFiles;

-(double) randomise{
    return (arc4random() / ((double) (((long long)2<<31) -1)));
}


enum Grids{_3x3=9,_3x4=12,_4x5=20};
enum Grids grid;
int x,y,character;
float scalefactor,positionfactor;

static enum Grids getRandom(int a, int b, int c) {
    double xx = (arc4random() / ((double) (((long long)2<<31) -1)));
       // NSLog(@"random : %f",xx);
        if(xx<((float) a)/(a+b+c)) return _3x3;
        else if(xx<((float)(a+ b))/(a+b+c)) return _3x4;
        else   return _4x5;
}



+ (Gameplay*) sharedInstance {
    static Gameplay *myInstance = nil;
if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
    myInstance.scored =0;
    myInstance.leveled =0;
    myInstance.highscored =0;
    myInstance.hited = 0;
}
        myInstance.scored = score;
        myInstance.leveled = level;
        myInstance.highscored = [highscoregame intValue];
        myInstance.hited = hits;
  
    return myInstance;
}

-(void)getlevel {
    
    grid = _3x3;
    maxSkulls=3,maxHots=3;
    
    if(level<3) { grid=_3x3; maxHots=3; }
    else if(level<10) { grid= getRandom(1,1,0); maxHots=6;  }
    else if(level<20)  { grid= getRandom(1,1,1); maxHots=10; }
    else if(level<30) { grid= getRandom(1,2,2); maxHots=16; }
    else { grid= getRandom(1,4,7); maxHots=20; }
    
    if (grid==_3x3) { x=3; y=3; maxHots=maxHots>9?9:maxHots; scalefactor=0.9; }
    else if (grid==_3x4) { x=3; y=4; maxHots=(maxHots>12)?12:maxHots; scalefactor=0.8;  }
    else if (grid==_4x5) { x=4; y=5; scalefactor=0.65; redindex=7;  }
    
    maxHots=(int) ( self.randomise * maxHots);
    maxSkulls=(int) ( self.randomise * maxHots * 0.7 );
    
    
    if(maxSkulls>maxHots)
    {
        int tmp = maxSkulls;
        maxSkulls=maxHots;
        maxHots=tmp;
    }
    else if(maxSkulls==maxHots)
        maxHots++;
    
//    NSLog(@"level= %d maxhots = %d  maxskull = %d  grid = %d \n\n",level,maxHots,maxSkulls,grid);
    
}
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = YES;
    count =0;
    score = 0;
    level=1;
    p_level=1;
    hits=0;
    hourglass=NO; hourglassactivate=NO;
    hourglasscount=0; hourglassscore=0;
    deltacheck=0;
    counter=0;
    
     prefs = [NSUserDefaults standardUserDefaults];
    _hourglass.visible=false;
    _hourglow.visible=false;
    _hourtext.visible=true;
    _explodebg.visible=false; explosion=NO;
    startbomb=0;
    levelnew=YES; gameover=NO;
    soundFiles = @[@"1.wav",@"2.wav",@"3.wav",@"4.wav",@"explosion.wav",@"fail.wav",@"laugh",@"magicwand.wav",@"splash.wav",@"win.wav",@"wing.wav"];
    
    [[OALSimpleAudio sharedInstance] preloadEffects:soundFiles reduceToMono:NO progressBlock:^(NSUInteger progress,NSUInteger successCount,NSUInteger total)
    {
        if (successCount == total)
        {
            CCLOG(@"Sound files loaded!");
        }
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1.9 target:self selector:@selector(gamestarts:) userInfo:nil repeats:NO];
    
    //[self performSelector:@selector(gamestarts:)];
    
   }


-(void)selectSpriteForTouch:(CGPoint)touchLocation
{
    int i;
    
 //   printf("2nd : %i \n", [SpriteArray count]);
    tomato *sprite[[SpriteArray count]];
    for (i=0; i< [SpriteArray count] ; i++)
    {
        
        sprite[i] = (tomato*) [SpriteArray objectAtIndex:i];
        
        
        if ([sprite[i].name  isEqualToString: @"angry"] || [sprite[i].name  isEqualToString: @"funny"]|| [sprite[i].name  isEqualToString:@"happy"]|| [sprite[i].name  isEqualToString: @"sick"]|| [sprite[i].name  isEqualToString:@"skull"])
        {
        
      //  printf(" Object : %f %f %f %f\n ",sprite.position.x , touchLocation.x ,sprite.position.y, touchLocation.y);
        
        float xdif = sprite[i].position.x - touchLocation.x;
        float ydif = sprite[i].position.y - touchLocation.y;
        
        float dist = sqrtf(xdif * xdif + ydif * ydif);
      //  printf(" %f ", dist );
        
        
    
        if (dist<(0.12*scalefactor)) {
            
            if ([sprite[i].name isEqualToString:@"skull"]) {
                
                for (i=0; i< [SpriteArray count] ; i++)
                {
                    [sprite[i].parent removeChild:sprite[i] cleanup:YES];
                }
                
                if( score > [highscoregame intValue])
                {
                    highscoregame = [NSNumber numberWithInt:score];
                    
                }
                
                if ([prefs boolForKey:@"sound"])
                [[OALSimpleAudio sharedInstance] playEffect:@"explosion.wav" loop:NO];
                
                if (counter==0) {
                
                explosion=YES;
                gameover = NO;
                counter=1;
                }

            }
            
            else if(![sprite[i].name isEqualToString:@"skull"]&&gameover==NO&&explosion==NO)
            {
                
                if ([combo  isEqual: @"nil"])
                {
                    combo = sprite[i].name;
                    combovalue = 1;
                }
                else
                {
                    if (combo==sprite[i].name) {
                        combovalue++;
                        CCLabelTTF *combolabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"x%d",(combovalue-1)] fontName:@"Showcard Gothic" fontSize:30];
                        int width=[[UIScreen mainScreen] bounds].size.width;
                        int height=[[UIScreen mainScreen] bounds].size.height;
                        combolabel.position = ccp(sprite[i].position.x*width,sprite[i].position.y*height);
                        
                        if (combovalue==2) {
                            if ([prefs boolForKey:@"sound"])
                                [[OALSimpleAudio sharedInstance] playEffect:@"1.wav" loop:NO];
                            combolabel.color = [CCColor greenColor];
                        }
                        if (combovalue==3) {
                            if ([prefs boolForKey:@"sound"])
                                [[OALSimpleAudio sharedInstance] playEffect:@"2.wav" loop:NO];
                            combolabel.color = [CCColor yellowColor];
                        }
                        if (combovalue==4) {
                            if ([prefs boolForKey:@"sound"])
                                [[OALSimpleAudio sharedInstance] playEffect:@"3.wav" loop:NO];
                            combolabel.color = [CCColor blueColor];
                        }
                        if (combovalue==5) {
                            if ([prefs boolForKey:@"sound"])
                                [[OALSimpleAudio sharedInstance] playEffect:@"4.wav" loop:NO];
                            combolabel.color = [CCColor redColor];
                        }
                        
                        
                        combolabel.outlineColor = [CCColor blackColor];
                        combolabel.outlineWidth = 5.0f;
                        [self addChild:combolabel z:10];
                        [combolabel runAction:[CCActionScaleTo actionWithDuration:0.2f scale:1.5]];
                        [combolabel runAction:[CCActionFadeTo actionWithDuration:1.0f opacity:0.0f]];
                        
                        
                    }
                    else{
                        combo=sprite[i].name;
                        combovalue=1;
                    }
                    
                }
                
                count = count-1;
                
                hits = hits+1;
                score+= 10*combovalue;
                hourglassscore+= 10*combovalue;
                
                if ([prefs boolForKey:@"sound"])
                [[OALSimpleAudio sharedInstance] playEffect:@"splash.wav" loop:NO];
                
                if ([prefs boolForKey:@"vibrate"])
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                
            _score.string = [NSString stringWithFormat:@"%i",score];
                CGPoint blastlocation = sprite[i].position;
                [sprite[i] rem:sprite[i]];
                sprite[i].name = @"nil";
                animatedSprite = [CCAnimatedSprite animatedSpriteWithPlist:@"blast.plist"];
                [animatedSprite addAnimationwithDelayBetweenFrames:0.1f name:@"blast"];
                
                animatedSprite.positionType = CCPositionTypeNormalized;
                animatedSprite.position = blastlocation;
                animatedSprite.scale = scalefactor*1.8;
                [animatedSprite runAnimation:@"blast"];
                [bombing addChild:animatedSprite];
                
                
            }
        }
        }
    }
}


- (void)gamestarts:(int)sender {
    
    
    int rand;

    bombing = [[CCScene alloc]init];
    [self addChild:bombing];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tomato" ofType:@"plist"];
    
    NSMutableDictionary *array=[[NSMutableDictionary alloc]init];
    array = [ NSMutableDictionary dictionaryWithContentsOfFile:path];
  //  NSMutableArray *array2 =[[NSMutableArray alloc]init];
  //  array2 = [NSMutableArray arrayWithContentsOfFile:path];
    
    tomatocolor = [array objectForKey:@"tomatocolor"];
    tomatored = [array objectForKey:@"tomatored"];
    name = [array objectForKey:@"items"];
    hots = [array objectForKey:@"friend"];
    enemy = [array objectForKey:@"danger"];
    ok = [array objectForKey:@"ok"];
    
    
    NSString *image;
    
    total_time = (3000.000-(level*10.000))/1000.000;
  //  NSLog(@"level : %i time : %f",level,total_time);
    SpriteArray = [ NSMutableArray arrayWithObjects: nil];
    count =0;
    combo = @"nil";
    bonus=0;
    totalred=0;
    bombcount=0;
    gameover=FALSE;
    bombover=FALSE;
    
    [self getlevel];
    
    CGPoint position = ccp(0.23, 0.1);
    if(grid==_3x3)
    {
        position = ccp(0.16, 0.23);
        positionfactor =0.07;
        redindex=6;
        
    }
    else if(grid==_3x4)
    {
        position = ccp(0.20, 0.14);
        positionfactor =0.06;
        redindex=9;
    }
    else if(grid==_4x5)
    {
        position = ccp(0.16, 0.1);
        positionfactor =0.04;
        redindex=16;
    }
    
    CCTime interval = 1.0/60.0;
    
    
    tomato *sprite[x*y];
    
    for (int i=0; i<y; i++)
    {
        
        for ( int j=0; j<x ; j++)
            
        {
            
            character= random() % 3;
            
            if (character==0 && maxHots>0) {
                rand = random() % 4;
                image = hots[rand];
                maxHots=maxHots-1;
                totalred++;
                
            }
            else if(character==1 && maxSkulls>0)
            {
                rand = 0;
                image = enemy[rand];
                maxSkulls=maxSkulls-1;
            }
            else
            {
                rand = random()%4;
                image = ok[rand];
                
            }
            
            if((i*x+j)==redindex && totalred==0)
            {
                rand = random() % 4;
                image = hots[rand];
                maxHots=maxHots-1;
                totalred++;
            }
            
            
            
        //    NSString *image = tomatocolor[name[rand]];
           // NSLog(image);
            NSString *image1=tomatocolor[image];
            sprite[i*x+j] = [[tomato alloc] init:image1];
            sprite[i*x+j].positionType = CCPositionTypeNormalized;
            sprite[i*x+j].position = ccp(position.x+j*0.3*scalefactor+j*positionfactor,position.y+i*0.25*scalefactor);
            sprite[i*x+j].scale = scalefactor;
            sprite[i*x+j].color = [CCColor grayColor];
            [SpriteArray addObject:sprite[i*x+j]];
            
            sprite[i*x+j].name = image;
            
            //Animation for scaling the totamo big and small in sequence
            
      //      CCAction *smaller = [CCActionScaleTo actionWithDuration:0.3F scale:(scalefactor+0.05)];
    //        CCAction *bigger = [CCActionScaleTo actionWithDuration:0.3F scale:(scalefactor-0.05)];
            CCActionSequence *pulseSequence = [CCActionSequence actions: [CCActionScaleTo actionWithDuration:0.3F scale:(scalefactor-0.05)], [CCActionScaleTo actionWithDuration:0.3F scale:(scalefactor+0.05)], nil];
            [self addChild:sprite[i*x+j]];
            [sprite[i*x+j] runAction:[CCActionRepeatForever actionWithAction: pulseSequence]];
            
            
              if ([sprite[i*x+j].name  isEqualToString: @"angry"] || [sprite[i*x+j].name  isEqualToString: @"funny"]|| [sprite[i*x+j].name  isEqualToString:@"happy"]|| [sprite[i*x+j].name  isEqualToString: @"sick"]|| [sprite[i*x+j].name  isEqualToString:@"skull"]) {
                  
                  if (![sprite[i*x+j].name isEqualToString:@"skull"]) {
                      count = count +1;
                      totalred=totalred+1;
                  }
            NSString *image2 = tomatored [image];
            CCProgressNode *sprite2 = [CCProgressNode progressWithSprite:[CCSprite spriteWithImageNamed:image2]];
            sprite2.type = CCProgressNodeTypeBar;
            sprite2.positionType = CCPositionTypeNormalized;
            sprite2.midpoint = ccp(0.5, 0);
            sprite2.barChangeRate = ccp(0, 1);
            sprite2.position = ccp(position.x+j*0.3*scalefactor+j*positionfactor,position.y+i*0.25*scalefactor);
            sprite2.scale = 1;
            
            [sprite[i*x+j] addChild:sprite2];
                  
            [self scheduleBlock:^(CCTimer *timer) {
                
                if (level)
                {
                    if (levelnew==YES) {
                        starting = timer.invokeTime;
                        current=starting;
                        levelnew = NO;
                    }
                    
                
                    current = timer.invokeTime;
                        
                    elapsed_time = current - starting;
                   //  NSLog(@" time : %f",elapsed_time);
                    sprite2.percentage =  100 - ( elapsed_time/total_time ) * 100;
                    
                    if (sprite2.percentage ==0 && count>0) {
                        sprite2.percentage=-5;
                        
                        gameover = YES;
                     }
                    
                    if (sprite2.percentage > 0 && count==0 ) {
                        nextlevel=YES;
                        count--;
                    }
                    
                }
                
                [timer repeatOnceWithInterval:interval];
            } delay:interval];
                  
            }
        }
        
    }
  
}

- (void)endanimation:(CCSprite *)sprite {
    
    refill = [CCSprite spriteWithImageNamed:@"assets/skull/color.png"];
    refill.position=sprite.position;
    [self addChild:refill z:1];
    
    if ([prefs boolForKey:@"sound"])
    [[OALSimpleAudio sharedInstance] playEffect:@"wing.wav" loop:NO];

    
    
}

-(void) fixedUpdate:(CCTime)delta{
 
    if(elapsed_time >total_time&&counter==0)
    {
        gameover=YES;
        counter=2;
        explosion=NO;
    }
  
    if (hourglass==YES)
    {
        hourglass = NO;
        
        _hourglass.visible=true;
        _hourglass.zOrder=5;
        _hourtext.zOrder=10;
        
        
    }
    if (nextlevel==YES&&hourglassactivate==NO&&gameover==NO)
    {
        nextlevel=NO;
        bonus = 5 * totalred * elapsed_time/total_time;
        score+=bonus;
        hourglassscore+=bonus;
        gameover=NO;
        bombover=FALSE;
        
        level=level+1;
        
        tomato *sprite[[SpriteArray count]];
        for (int i=0; i< [SpriteArray count] ; i++)
        {
            
            sprite[i] = (tomato*) [SpriteArray objectAtIndex:i];
            [sprite[i] rem:sprite[i]];
        }
        
        [bombing removeAllChildren];
        [refill removeAllChildren];
    }
    if (hourglassscore >= 200) {
        
        hourglassscore = hourglassscore-200;
        hourglasscount = hourglasscount+1;
        _hourtext.string = [NSString stringWithFormat:@"%d",hourglasscount];
        _hourglow.visible=true;
        _hourglow.zOrder=8;
        _hourglow.opacity=1;
        CCActionSequence *s1 = [CCActionSequence actions:[CCActionScaleTo actionWithDuration:.2f scale:1.09],[CCActionScaleTo actionWithDuration:.2f scale:1],[CCActionFadeTo actionWithDuration:0.4f opacity:0.0], nil];
        [_hourglow runAction:s1];
        
        if(hourglasscount==1)hourglass = YES;
    }
    
    if(hourglassactivate==YES&&gameover==NO)
    {
        hourglassactivate=NO;
        
        if ([prefs boolForKey:@"sound"])
        [[OALSimpleAudio sharedInstance] playEffect:@"magicwand.wav" loop:NO];
        
        tomato *sprite[[SpriteArray count]];
        
        
        for (int i=0; i< [SpriteArray count] ; i++)
        {
            
            sprite[i] = (tomato*) [SpriteArray objectAtIndex:i];
            
            refill = [CCSprite spriteWithImageNamed:@"assets/refillbg.png"];
            
            [sprite[i] addChild:refill z:-1];
            
            [refill runAction:[CCActionScaleTo actionWithDuration:0.3f scale:1.5]];
            [refill runAction:[CCActionScaleTo actionWithDuration:0.3f scale:0.9]];
            [refill runAction:[CCActionScaleTo actionWithDuration:0.3f scale:1.5]];
            [refill runAction:[CCActionFadeTo actionWithDuration:0.9f opacity:0.0f]];
            
            
        }
        
        starting = current;
        
    }

}

- (void)update:(CCTime)delta {
    // move character to the right, 100 points a second
    
    if (counter==1 || counter==2) {
        deltacheck+=delta;
        
        if (counter==2) {
            _explodebg.visible=NO;
        }
        
        if (deltacheck>=2) {
            CCScene *gameplayScene = [CCBReader loadAsScene:@"GameOver"];
            [[CCDirector sharedDirector] replaceScene:gameplayScene];
        }
    }
    if (explosion==YES&&gameover==NO&&counter==1) {
        
        counter=1;
        _explodebg.visible=YES;
        
        if (startbomb==0) {
            _hourglass.visible=false;
            _hourtext.visible=false;
            
            tomato *sprite[[SpriteArray count]];
            
            for (int i=0; i< [SpriteArray count] ; i++)
            {
                sprite[i] = (tomato*) [SpriteArray objectAtIndex:i];
                [sprite[i] rem:sprite[i]];
            }

            
            explosionsprite = [CCAnimatedSprite animatedSpriteWithPlist:@"explode.plist"];
            [explosionsprite addAnimationwithDelayBetweenFrames:0.2f name:@"explode"];
            
            explosionsprite.positionType = CCPositionTypeNormalized;
            explosionsprite.position = ccp(0.5, 0.5);
            explosionsprite.scale = scalefactor*3;
            [explosionsprite runAnimation:@"explode"];
            [bombing addChild:explosionsprite];
        }
        startbomb+=delta;
        
        if (startbomb >=1) {
            //explosion=YES; startbomb=0;
            _explodebg.visible=NO;
            [bombing removeAllChildrenWithCleanup:YES];
            CCScene *gameplayScene = [CCBReader loadAsScene:@"GameOver"];
            [[CCDirector sharedDirector] replaceScene:gameplayScene];
        }
        
    }
    if (p_level < level && counter==0)
    {
        levelnew=YES;
        p_level =level;
        
        
        // [bombing removeAllChildrenWithCleanup:YES];
        [self performSelector:@selector(gamestarts:)];
        
    }
    
    
    if (gameover==YES&&explosion==NO&&counter==2)
    {
        counter = 2;
        tomato *sprite[[SpriteArray count]];
         startbomb+=delta;
        if (bombcount<[SpriteArray count] && bombover==FALSE)
        {
            gameover = YES;
            bombover = TRUE;
        }
        if (bombover==TRUE)
        {
            if(startbomb >= 0.08)
            {
                
                
                CCSprite *childlayer = [CCSprite spriteWithImageNamed:tomatocolor[enemy[0]]];
                sprite[bombcount] = (tomato*) [SpriteArray objectAtIndex:bombcount];
                
                
                if([sprite[bombcount].name isEqualToString:@"nil"])
                    bombcount++;
                else
                {
                    
                if ([prefs boolForKey:@"sound"])
                [[OALSimpleAudio sharedInstance] playEffect:@"pop.wav" loop:NO];
                int width=[[UIScreen mainScreen] bounds].size.width;
                int height=[[UIScreen mainScreen] bounds].size.height;
                childlayer.position = ccp(sprite[bombcount].position.x*width,sprite[bombcount].position.y*height);
                
                childlayer.scale = sprite[bombcount].scale;
                [self addChild:childlayer];
                [sprite[bombcount] rem:sprite[bombcount]];
                bombcount=bombcount+1;
                startbomb=0;
                bombover=FALSE;
                }
            }
        }
        if(bombcount>=[SpriteArray count])
        {
            if ([prefs boolForKey:@"sound"])
            [[OALSimpleAudio sharedInstance] playEffect:@"fail.wav" loop:NO];
            self.userInteractionEnabled = FALSE;
            self.multipleTouchEnabled = NO;
            for (int i=0; i< [SpriteArray count] ; i++)
            {
                sprite[i] = (tomato*) [SpriteArray objectAtIndex:i];
                [sprite[i] rem:sprite[i]];
            }
            
            [SpriteArray removeAllObjects];
            
            NSString *highscorepath = [[NSBundle mainBundle] pathForResource:@"highscore" ofType:@"plist"];
            NSMutableDictionary *highscorearray=[[NSMutableDictionary alloc]init];
            highscorearray = [ NSMutableDictionary dictionaryWithContentsOfFile:highscorepath];
            highscoregame = [highscorearray objectForKey:@"highscore"];
            
            if( score > [highscoregame intValue])
            {
                highscoregame = [NSNumber numberWithInt:score];
                
            }
            //gameover=YES;
            //bombover=FALSE;
            
            CCScene *gameplayScene = [CCBReader loadAsScene:@"GameOver"];
            [[CCDirector sharedDirector] replaceScene:gameplayScene];
            return;

        }
   }
    

    
}


-(void ) touchBegan:(UITouch *)myTouch withEvent:(UIEvent *)event
  {
    
    //NSLog(@"touch was detected : lol");
    
      
        CGPoint location = [myTouch locationInView: [myTouch view]];
      
       location = [[CCDirector sharedDirector] convertToGL: location];
     
      int width=[[UIScreen mainScreen] bounds].size.width;
      int height=[[UIScreen mainScreen] bounds].size.height;
      
      location.x = location.x/width;
      location.y = location.y/height;
      
      if(gameover==NO&&explosion==NO&&counter==0)
      {
          [self selectSpriteForTouch:location];
      }
      
}

-(void) hourglasstouch {
    
    if(gameover==NO)
    {
    
    hourglassactivate = YES;
    hourglasscount=hourglasscount-1;
    _hourtext.zOrder=10;
    _hourtext.string = [NSString stringWithFormat:@"%d",hourglasscount];
    
    
    if (hourglasscount<=0) {
        _hourglass.visible = false;
        
    }
    }
    
}

@end
