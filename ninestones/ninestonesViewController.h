//
//  ninestonesViewController.h
//  ninestones
//
//  Created by Moshe Berman on 9/14/11.
//  Copyright 2011  Apps, Videos, Websites. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ninestonesViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>{
    UILabel *stepsLabel;
    UITextField *numberOfStonesInput;
    UITableView *stepsTable;
    UITableViewCell *tableCell;
}


//
//
//

@property (nonatomic, retain) IBOutlet UILabel *stepsLabel;
@property (nonatomic, retain) IBOutlet UITextField *numberOfStonesInput;
@property (nonatomic, retain) IBOutlet UITableView *stepsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *tableCell;

//
//
//

- (int) numberOfStepsForNumberOfStones:(long)numberOfStones;

//
//
//

- (NSMutableArray *) stepsToSplitNStonesWhereNEquals:(int)numberOfStonesToSplit;

//
//
//

- (IBAction)updateUI;

@end
