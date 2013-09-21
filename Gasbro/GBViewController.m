//
//  GBViewController.m
//  Gasbro
//
//  Created by Sean Thomas Burke on 9/10/13.
//  Copyright (c) 2013 Sean Thomas Burke. All rights reserved.
//

#import "GBViewController.h"
#import <CoreLocation/CoreLocation.h>
#define kLatestKivaLoansURL [NSURL URLWithString: @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2

@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end

@interface GBViewController ()

@end

@implementation GBViewController


@synthesize latitude;
@synthesize longitude;
CLLocationManager *locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                         options:kNilOptions
                                                           error:&error];
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    NSLog(@"loans: %@", latestLoans); //3
    
    // 1) Get the latest loan
    NSDictionary* loan = [latestLoans objectAtIndex:0];
    
    // 2) Get the funded amount and loan amount
    NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
    NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
    float outstandingAmount = [loanAmount floatValue] - [fundedAmount floatValue];
    
    // 3) Set the label appropriately
    humanReadble.text = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
                         [loan objectForKey:@"name"],
                         [(NSDictionary*)[loan objectForKey:@"location"] objectForKey:@"country"],
                         outstandingAmount
                         ];
    
    //build an info object and convert to json
    NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                          [loan objectForKey:@"name"], @"who",
                          [(NSDictionary*)[loan objectForKey:@"location"] objectForKey:@"country"], @"where",
                          [NSNumber numberWithFloat: outstandingAmount], @"what",
                          nil];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    //print out the data contents
    jsonSummary.text = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)compute:(id)sender{
    
}
-(IBAction)updatePeople:(id)sender{
    people_label.text = [NSString stringWithFormat:@"%f", people_slider.value];
}
-(IBAction)updateMPG:(id)sender{
    mpg_label.text = [NSString stringWithFormat:@"%f", mpg_slider.value];
}

-(IBAction)getGasPrice:(id)sender{

    
}



@end
