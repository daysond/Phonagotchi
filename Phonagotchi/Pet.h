//
//  Pet.h
//  Phonagotchi
//
//  Created by Dayson Dong on 2019-05-09.
//  Copyright © 2019 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pet : NSObject

@property (nonatomic) NSString* name;
@property (nonatomic,readonly,getter=isGrumpy) BOOL isGrumpy;

-(void)beingPetted: (CGPoint) velocity;

@end

NS_ASSUME_NONNULL_END
