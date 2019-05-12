//
//  Pet.m
//  Phonagotchi
//
//  Created by Dayson Dong on 2019-05-09.
//  Copyright © 2019 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"
#import <AVFoundation/AVFoundation.h>

@interface Pet()

@property (nonatomic) BOOL isGrumpy;
@property (nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation Pet

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isGrumpy = NO;
        _isAsleep = NO;
        _restfulness = 60;
        _timer = self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(minusRestfulness) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)beingPetted:(CGPoint)velocity {
    _isGrumpy = NO;
    if (fabs(velocity.x) > 1000 + (self.restfulness/60) * 1000 || fabs(velocity.y) > 1000 + (self.restfulness/60) * 1000 ) {
        _isGrumpy = YES;
    }
}
-(void)makeNoise {
    NSString *path = [NSString stringWithFormat:@"%@/Cat-sound-effect.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
    [self.audioPlayer play];
    NSLog(@"rawrrrrr");
}



-(void)minusRestfulness {
     _restfulness --;
    NSLog(@"getting tired %ld",(long)self.restfulness);
    if (self.restfulness == 0) {
        [self.timer invalidate];
        self.isAsleep = YES;
        [self.updateStatusDelegate updatePetImageWithPetStatus:self.isAsleep];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(restoreRestfulness) userInfo:nil repeats:YES];
    }
}

-(void)restoreRestfulness {
    _restfulness ++;
    NSLog(@"restoring... %lu",self.restfulness);
    if (self.restfulness == 60) {
        [self.timer invalidate];
        self.isAsleep = NO;
        [self.updateStatusDelegate updatePetImageWithPetStatus:self.isAsleep];
        _timer = self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(minusRestfulness) userInfo:nil repeats:YES];
    }
    
}




@end
