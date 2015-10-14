//
//  ReadySetGo.m
//  TomBash
//
//  Created by Anto Dominic on 11/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "ReadySetGo.h"
#import "Gameplay.h"

@implementation ReadySetGo

- (void)didLoadFromCCB {
    
    CCScene *gameplayScene2 = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene2];
    
  
}


@end
