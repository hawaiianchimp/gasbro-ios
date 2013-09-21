//
//  GBRest.m
//  Gasbro
//
//  Created by Sean Thomas Burke on 9/21/13.
//  Copyright (c) 2013 Sean Thomas Burke. All rights reserved.
//

#import "GBRest.h"
#import "SBJson.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString: @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2

@implementation GBRest

@synthesize url;


-(NSData *) doRestCall:(NSString*)inputUrl withOptions:(NSDictionary*)options{

    for (id key in options)
    {
       NSLog(@"%@=%@&", key, [options objectForKey:key]);
    }
    
    NSURL callURL = inputUrl + "?" +
    dispatch_async(kBgQueue, ^{
        
        NSData* data = [NSData dataWithContentsOfURL: kLatestKivaLoansURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    
    return data;
}

-(int64_t *) getGasPrice:(NSString*)inputUrl withOptions:(NSDictionary*)options{
    
    for (id key in options)
    {
        NSLog(@"%@=%@&", key, [options objectForKey:key]);
    }
    
    NSURL callURL = inputUrl + "?" +
    dispatch_async(kBgQueue, ^{
        
        NSData* data = [NSData dataWithContentsOfURL: kLatestKivaLoansURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    
    return data;
}

@end