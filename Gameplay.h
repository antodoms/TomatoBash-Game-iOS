//
//  Gameplay.h
//  TomBash
//
//  Created by Anto Dominic on 31/07/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#include <CCActionInterval.h>
#import <AudioToolbox/AudioServices.h>

@interface Gameplay : CCNode {
    
    
    NSMutableArray *SpriteArray;
    NSDictionary *tomatocolor;
    NSDictionary *tomatored;
    NSArray *hots;
    NSArray *enemy;
    NSArray *ok;
    NSArray *name;
    float starting;
    float current;
    float elapsed_time;
    float total_time;
    float anime;
    
}

//@property (nonatomic, retain) NSMutableArray *SpriteArray;
//@property (nonatomic, retain) NSDictionary *tomatocolor;
//@property (nonatomic, retain) NSDictionary *tomatored;
@property (nonatomic) int leveled;
@property (nonatomic) int scored;
@property (nonatomic) int highscored;
@property (nonatomic) int hited;

-(double) randomise;
+(Gameplay*) sharedInstance;


-(void)selectSpriteForTouch:(CGPoint)touchLocation;
//-(void) checkForTap: (CGPoint) touch;

//-(BOOL) circle : (CGPoint) circlepoint withRadius: (float) radius CollisionWithCircle: (CGPoint) circlepointTwo CollisionWithCircleRadius: (float) radiusTwo;


@end
