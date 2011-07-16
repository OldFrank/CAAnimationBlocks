//
//  RootViewController.m
//  RootViewController
//
//  Created by xissburg on 7/16/11.
//  Copyright 2011 xissburg. All rights reserved.
//

#import "RootViewController.h"
#import "CAAnimation+Blocks.h"
#import <QuartzCore/QuartzCore.h>


@implementation RootViewController

@synthesize imageView;

- (void)dealloc
{
    self.imageView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.layer.shadowOffset = CGSizeMake(0, 4);
    self.imageView.layer.shadowRadius = 7;
    self.imageView.layer.shadowOpacity = 0.7;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.imageView = nil;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(runAnimation:) withObject:nil afterDelay:1.0];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)runAnimation:(id)unused
{
    const CGFloat duration = 0.1f;
    const CGFloat angle = 0.03f;
    NSNumber *angleR = [NSNumber numberWithFloat:angle];
    NSNumber *angleL = [NSNumber numberWithFloat:-angle];
    
    CABasicAnimation *animationL = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    CABasicAnimation *animationR = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    void (^completionR)(BOOL) = ^(BOOL finished) {
        [self.imageView.layer setValue:angleL forKey:@"transform.rotation.z"];
        [self.imageView.layer addAnimation:animationL forKey:@"L"];
    };
    
    void (^completionL)(BOOL) = ^(BOOL finished) {
        [self.imageView.layer setValue:angleR forKey:@"transform.rotation.z"];
        [self.imageView.layer addAnimation:animationR forKey:@"R"];
    };
    
    animationL.fromValue = angleR;
    animationL.toValue = angleL;
    animationL.duration = duration;
    animationL.completion = completionL;
    
    animationR.fromValue = angleL;
    animationR.toValue = angleR;
    animationR.duration = duration;
    animationR.completion = completionR;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = angleR;
    animation.duration = duration/2;
    animation.completion = completionR;
    [self.imageView.layer setValue:angleR forKey:@"transform.rotation.z"];
    [self.imageView.layer addAnimation:animation forKey:@"0"];
}

@end
