//
//  ninestonesAppDelegate.h
//  ninestones
//
//  Created by Moshe Berman on 9/14/11.
//  Copyright 2011  Apps, Videos, Websites. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ninestonesViewController;

@interface ninestonesAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ninestonesViewController *viewController;

@end
