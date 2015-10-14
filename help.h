//
//  help.h
//  TomatoBash
//
//  Created by Anto Dominic on 28/10/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <iAd/iAd.h>
@interface help : CCNode <ADBannerViewDelegate> {
    
}
@property (atomic, retain) ADBannerView* _iAdBannerView;
@end
