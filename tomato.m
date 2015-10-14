//
//  tomato.m
//  TomBash
//
//  Created by Anto Dominic on 09/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "tomato.h"



@implementation tomato

 CCSprite *bear;
 CCAction *walkAction;
 CCAction *moveAction;

-(id) init :(NSString*) link  {
   
    if ((self = [super init])) {
        CCSprite *sprite = [CCSprite spriteWithImageNamed: link];
        [self addChild:sprite];
        
        
    }
    
    return self;
}

-(id) rem : (tomato*) sprite {
    
    [sprite.parent removeChild:sprite cleanup:YES];
    
return self;
    
}

@end
