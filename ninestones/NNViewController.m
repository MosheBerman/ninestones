//
//  ninestonesViewController.m
//  ninestones
//
//  Created by Moshe Berman on 9/14/11.
//  Copyright 2011 Moshe Berman. All rights reserved.
//

#import "NNViewController.h"

#define kNumberOfStones 9

@implementation NNViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad{
    [super viewDidLoad];

    //
    //  Initialize to nine stones
    //
    
    [[self stepsLabel] setText:[NSString stringWithFormat:@"%i stones can be split in %i steps.", kNumberOfStones, [self numberOfStepsForNumberOfStones:kNumberOfStones]]];
    
    
    //
    //  Set up the text field
    //
    
    [self.numberOfStonesInput setText:@"9"];    
    [self.numberOfStonesInput becomeFirstResponder];
    
    //
    //  Set the background color
    //
    
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
}


- (void)viewDidUnload{
    [self setStepsLabel:nil];
    [self setNumberOfStonesInput:nil];
    [self setStepsTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//
//  This method calculates the number of steps required 
//  to deduce which stone of a group of stones, where all
//  but one weigh the same, is the outlying stone.
//

- (int) numberOfStepsForNumberOfStones:(long)numberOfStones
{
    
    //
    //  If the number of stones is too 
    //  large to handle, then we return -1
    //  as the answer. The app will show a 
    //  message in this case.
    //
    
    if (numberOfStones > INT_MAX) {
        return -1;
    }
    
    //
    //  Start multiplying powers of three
    //  until we find the one directly above
    //  our number of stones. When we find
    //  it, we subtract one and that's our
    //  answer.
    //
    
    int power = 0;
    int nextCalculatedPower = 0;
    
    while (numberOfStones > nextCalculatedPower) {
        
        //
        //  If the power is too large for the 
        //  computer, then we return -1. The app
        //  will show an error message in this case.
        //
        
        if (pow(3, power) < INT_MAX) {
            nextCalculatedPower = pow(3, power);
        }else{
            return -1;
        }
        
        power++;
    }
    
    //
    //  The number of steps is one less than the 
    //  next power of three that's greater than
    //  the number of stones.
    //
    
    return power-1;
}

#pragma mark - Text Field Delegate

- (IBAction)updateUI{
    
    //
    //  Grab the number of stones from text input.  
    //  Then calculate the proper number of steps and 
    //  display an appropriate label on the screen.
    //
    
    int numberOfStones = [[[self numberOfStonesInput] text] intValue];
    int numberOfSteps = [self numberOfStepsForNumberOfStones:numberOfStones];
    
    [self stepsToSplitNStonesWhereNEquals:numberOfStones];
    
    //
    //  If we have get a result of negative one, 
    //  then we have too many stones. 
    //
    //  Otherwise, if we have less than two stones,
    //  we can't split them, so say so. If there are 
    //  two or more, then show the results.
    //
    
    
    
    if (numberOfStones < 2) {
        [[self stepsLabel] setText:@"You can't split that many stones."];
    }else{
        
        if (numberOfSteps == -1) {
            [[self stepsLabel] setText:@"Whoa! That's a lot of stones!"];
        }else{
            
            [[self stepsLabel] setText:[NSString stringWithFormat:@"%i stones can be split in %i %@.", numberOfStones, numberOfSteps, ((numberOfSteps != 1) ? @"steps" : @"step")]];
        }
    }
    
        [[self stepsTable] reloadData];    
    
    
}

//
//  Calculate each step to split stones
//


- (NSMutableArray *) stepsToSplitNStonesWhereNEquals:(int)numberOfStonesToSplit{
    
    NSMutableArray *stonesInEachStep = [[NSMutableArray alloc] init];
    
    int stonesAtThisStep = numberOfStonesToSplit;
    
    //
    //  At each step, we divide the stones into groups as equal in size
    //  as possible. Then take the largest group and repeat until
    //  we have one stone left. 
    //
    //  At each step, we record how the stones have been split up.
    //
    
    while (stonesAtThisStep > 1) {
        
        //  NSLog(@"<Steps Calculator>: Number of Stones at beginning of the step: %i", stonesAtThisStep);
        //
        //  Declare the three groups
        //
        
        NSNumber *GroupOne;
        NSNumber *GroupTwo;
        NSNumber *GroupThree;
        
        //
        //  The stones will either split equally,
        //  or there will be one or two left over.
        //
        //  Here we divide up the groups of stones.
        //
        
        if (stonesAtThisStep % 3 == 0) {
            
            GroupOne = [NSNumber numberWithInt:stonesAtThisStep/3];
            GroupTwo = [NSNumber numberWithInt:stonesAtThisStep/3];            
            GroupThree = [NSNumber numberWithInt:stonesAtThisStep/3];            
            
            stonesAtThisStep = stonesAtThisStep/3;
            
        }else if(stonesAtThisStep % 3 == 1){
            
            GroupOne = [NSNumber numberWithInt:floor(stonesAtThisStep/3)];
            GroupTwo = [NSNumber numberWithInt:floor(stonesAtThisStep/3)];            
            GroupThree = [NSNumber numberWithInt:floor(stonesAtThisStep/3)+1];
            
            stonesAtThisStep = floor(stonesAtThisStep/3)+1;
            
        }else if(stonesAtThisStep % 3 == 2){
            
            //
            //  To Do: Account for exactly two stones.
            //
            
            GroupOne = [NSNumber numberWithInt:floor(stonesAtThisStep/3)+1];
            GroupTwo = [NSNumber numberWithInt:floor(stonesAtThisStep/3)+1];            
            GroupThree = [NSNumber numberWithInt:stonesAtThisStep/3];
            
            stonesAtThisStep = floor(stonesAtThisStep/3)+1;
            
        }
        
        //NSLog(@"Stones left at the end of this step is: %i", stonesAtThisStep);
        
        [stonesInEachStep addObject:[NSArray arrayWithObjects:GroupOne, GroupTwo, GroupThree, nil]];
    }
    
    return stonesInEachStep;
}


#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfStepsForNumberOfStones:[self.numberOfStonesInput.text intValue]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"NineStonesCell" owner:self options:nil];
        cell = [self tableCell];
        self.tableCell = nil;

    }
    
    NSArray *groupSizesForThisCell = [[self stepsToSplitNStonesWhereNEquals:[self.numberOfStonesInput.text intValue]] objectAtIndex:indexPath.row];
    
    int firstGroup  = [[groupSizesForThisCell objectAtIndex:0] intValue];
    int secondGroup = [[groupSizesForThisCell objectAtIndex:1] intValue];
    int thirdGroup  = [[groupSizesForThisCell objectAtIndex:2] intValue];
    
    //[cell.textLabel setText:[NSString stringWithFormat:@"%i\t-\t%i\t%i", firstGroup, secondGroup, thirdGroup]];
    
    [((UILabel *)[cell viewWithTag:5]) setText:[NSString stringWithFormat:@"%i", firstGroup]];
    [((UILabel *)[cell viewWithTag:6]) setText:[NSString stringWithFormat:@"%i", secondGroup]];    
    [((UILabel *)[cell viewWithTag:7]) setText:[NSString stringWithFormat:@"%i", thirdGroup]];        
    
    return cell;
}
@end
