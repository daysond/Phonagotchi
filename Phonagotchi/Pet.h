//
//  Pet.h
//  Phonagotchi
//
//  Created by Dayson Dong on 2019-05-09.
//  Copyright © 2019 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol UpdateStatusDelegate <NSObject>

-(void)updatePetImageWithPetStatus: (BOOL)petStatus;

@end

@interface Pet : NSObject

@property (nonatomic,readonly,getter=isGrumpy) BOOL isGrumpy;
@property (nonatomic) NSInteger restfulness;
@property (nonatomic) BOOL isAsleep;
@property (nonatomic) NSTimer *timer;
@property (weak, nonatomic) id<UpdateStatusDelegate> updateStatusDelegate;

-(void)beingPetted: (CGPoint) velocity;
-(void)minusRestfulness;
-(void)makeNoise;

@end

NS_ASSUME_NONNULL_END
