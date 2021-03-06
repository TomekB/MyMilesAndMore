//
//  BeaconManager.h
//  My Miles & More
//
//  Created by Mateusz Glapiak on 10/26/13.
//  Copyright (c) 2013 Mateusz Glapiak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@protocol BeaconManagerDelegate <NSObject>

-(void)foundDeviceWithUUID:(NSString*)uuid;

@end

@interface BeaconManager : NSObject<CBCentralManagerDelegate>
@property(nonatomic,weak) id<BeaconManagerDelegate>delegate;
- (id)initWithUUID:(NSString*)UUID;

@end
