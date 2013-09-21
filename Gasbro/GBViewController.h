//
//  GBViewController.h
//  Gasbro
//
//  Created by Sean Thomas Burke on 9/10/13.
//  Copyright (c) 2013 Sean Thomas Burke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBViewController : UIViewController{
    
    
    IBOutlet UITextField *start_address;
    IBOutlet UITextField *end_address;
    
    IBOutlet UISlider *people_slider;
    IBOutlet UISlider *mpg_slider;
    
    IBOutlet UILabel *people_label;
    IBOutlet UILabel *mpg_label;
    
    IBOutlet UISegmentedControl *type;
    
    
    IBOutlet UILabel *cost_per_person;
    IBOutlet UILabel *cost_total;
    IBOutlet UILabel *price;
    
    IBOutlet UIButton *calculate_button;
    
    IBOutlet UILabel* humanReadble;
    IBOutlet UILabel* jsonSummary;
    
    IBOutlet UILabel *latitudeLabel;
    IBOutlet UILabel *longitudeLabel;
    IBOutlet UILabel *addressLabel;
    
}

- (IBAction)getCurrentLocation:(id)sender;


-(IBAction)compute:(id)sender;
-(IBAction)updatePeople:(id)sender;
-(IBAction)updateMPG:(id)sender;
-(IBAction)getGasPrice:(id)sender;


@property (readwrite) Float64 longitude;
@property (readwrite) Float64 latitude;

@end
