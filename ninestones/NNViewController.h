//
//  ninestonesViewController.h
//  ninestones
//
//  Created by Moshe Berman on 9/14/11.
//  Copyright 2011  Apps, Videos, Websites. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

//
//
//

@property (nonatomic, strong) IBOutlet UILabel *stepsLabel;
@property (nonatomic, strong) IBOutlet UITextField *numberOfStonesInput;
@property (nonatomic, strong) IBOutlet UITableView *stepsTable;
@property (nonatomic, strong) IBOutlet UITableViewCell *tableCell;

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
