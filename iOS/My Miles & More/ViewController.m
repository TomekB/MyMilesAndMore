//
//  ViewController.m
//  My Miles & More
//
//  Created by Mateusz Glapiak on 10/26/13.
//  Copyright (c) 2013 Mateusz Glapiak. All rights reserved.
//

#import "ViewController.h"
#import "NearbyStoresViewController.h"
#import "UIImageView+AFNetworking.h"
const CGFloat duration = 10.0;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NearbyStoresViewController *vc = [[NearbyStoresViewController alloc] initWithLatitude:52.519171 withLongitude:13.4060912 withCountryCode:@"DE" withCity:@"Berlin"];
    [self.navigationController pushViewController:vc animated:YES];
    
    

}


@end
