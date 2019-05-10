//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "Pet.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic) UIImageView *anotherApple;
@property (nonatomic) UIPanGestureRecognizer *panRecog;
@property (nonatomic) UIPanGestureRecognizer *panRecogForFeeding;
@property (nonatomic) UIPanGestureRecognizer *panRecogForNewApple;
@property (nonatomic) NSArray <NSLayoutConstraint*> *appleImageConstraints;
@property (nonatomic) Pet *pet;

@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pet = [Pet new];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    self.bucketImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.image = [UIImage imageNamed:@"bucket"];
    [self.view addSubview:self.bucketImageView];
    
    [NSLayoutConstraint activateConstraints:@[[self.bucketImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:8],
                                              [self.bucketImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:8],
                                              [self.bucketImageView.widthAnchor constraintEqualToConstant:150],
                                              [self.bucketImageView.heightAnchor constraintEqualToConstant:150]
                                              ]];
    self.appleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleImageView.image = [UIImage imageNamed:@"apple"];
    [self.view addSubview:self.appleImageView];
    
    [NSLayoutConstraint activateConstraints:@[[self.appleImageView.centerXAnchor constraintEqualToAnchor:self.bucketImageView.centerXAnchor],
                                              [self.appleImageView.centerYAnchor constraintEqualToAnchor:self.bucketImageView.centerYAnchor],
                                              [self.appleImageView.widthAnchor constraintEqualToConstant:50],
                                              [self.appleImageView.heightAnchor constraintEqualToConstant:50]
                                              ]];
    
    UIImageView *newApple = [[UIImageView alloc]initWithFrame:CGRectZero];
    newApple.translatesAutoresizingMaskIntoConstraints = NO;
    newApple.image = [UIImage imageNamed:@"apple"];
    self.anotherApple = newApple;
    
//    [self.anotherApple setUserInteractionEnabled:YES];
    [self.petImageView setUserInteractionEnabled:YES];
    [self.appleImageView setUserInteractionEnabled:YES];
    
    self.panRecog = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(petting)];
    self.panRecogForFeeding = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(feeding)];

    [self.petImageView addGestureRecognizer:self.panRecog];
    [self.appleImageView addGestureRecognizer:self.panRecogForFeeding];
}

-(void)petting {
    [self.pet beingPetted:[self.panRecog velocityInView:self.petImageView]];
    if ([self.pet isGrumpy]) {
        self.petImageView.image =  [UIImage imageNamed:@"grumpy"];
    }
    if (self.panRecog.state == UIGestureRecognizerStateEnded ) {

        self.petImageView.image = [UIImage imageNamed:@"default"];
    }
}

-(void)feeding {
  
    if (self.panRecogForFeeding.state == UIGestureRecognizerStateBegan) {
        [self.view addSubview:self.anotherApple];
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.anotherApple.centerXAnchor constraintEqualToAnchor:self.bucketImageView.centerXAnchor],
                                                  [self.anotherApple.centerYAnchor constraintEqualToAnchor:self.bucketImageView.centerYAnchor],
                                                  [self.anotherApple.widthAnchor constraintEqualToConstant:50],
                                                  [self.anotherApple.heightAnchor constraintEqualToConstant:50]
                                                  ]];
        
    }
    if (self.panRecogForFeeding.state == UIGestureRecognizerStateChanged) {
        CGPoint touchLocation = [self.panRecogForFeeding locationInView:self.view];
        self.appleImageView.center = touchLocation;
    }
    
    if (self.panRecogForFeeding.state == UIGestureRecognizerStateEnded) {
        CGPoint touchLocation = [self.panRecogForFeeding locationInView:self.view];
        if (CGRectContainsPoint(self.petImageView.frame, touchLocation)) {
            [UIView animateWithDuration:1
                             animations:^{self.appleImageView.alpha = 0;}
                             completion:^(BOOL finished)
                                {self.appleImageView.center = self.bucketImageView.center;
                                 self.appleImageView.alpha = 1;}];
        } else {
            self.appleImageView.center = CGPointMake(touchLocation.x, self.view.frame.size.height - touchLocation.y + 25);
        }
    }
    
    
}


@end
