//
//  Pet.m
//  Phonagotchi
//
//  Created by Dayson Dong on 2019-05-09.
//  Copyright © 2019 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"

@interface Pet()

@property (nonatomic) BOOL isGrumpy;

@end

@implementation Pet

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isGrumpy = NO;
    }
    return self;
}

- (void)beingPetted:(CGPoint)velocity {
    _isGrumpy = NO;
    if (fabs(velocity.x) > 1000.0 || fabs(velocity.y) > 1000.0) {
        _isGrumpy = YES;
    }

    
}

@end
