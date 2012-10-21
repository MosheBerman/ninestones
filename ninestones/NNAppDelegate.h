//
//  ninestonesAppDelegate.h
//  ninestones
//
//  Created by Moshe Berman on 9/14/11.
//  Copyright 2011  Apps, Videos, Websites. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNViewController;

@interface NNAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet NNViewController *viewController;

@end
