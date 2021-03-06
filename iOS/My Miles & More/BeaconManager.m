//
//  BeaconManager.m
//  My Miles & More
//
//  Created by Mateusz Glapiak on 10/26/13.
//  Copyright (c) 2013 Mateusz Glapiak. All rights reserved.
//

#import "BeaconManager.h"

@interface BeaconManager()
@property (nonatomic) CBCentralManager *btManager;
@property (nonatomic,assign) BOOL processing;
@property (nonatomic,copy) NSString* UUID;
@property (nonatomic) NSMutableSet* foundDevices;

@end

@implementation BeaconManager
- (id)initWithUUID:(NSString*)UUID
{
    self = [super init];
    
    if(self)
    {
        _btManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_queue_create("My Queue",NULL)];
        _UUID = UUID;
        _processing = NO;
        _foundDevices = [NSMutableSet set];
    }
    
    return self;
}

#pragma mark CBPeripheralManagerDelegate methods
- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    NSLog(@"didRetrieve");
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals
{
    NSLog(@"didRetrieveConnected");
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"didConnect");
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"didFailToConnect");
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"didDisconnect");
}



- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSLog(@"Central Manager did change state %@", central.description);
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            [self.btManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, peripheral.UUID);
    CFRelease(theUUID);
    NSString *UUID = (__bridge_transfer NSString *)string;
    
    
    if(![self.foundDevices containsObject:UUID])
    {
        [self.foundDevices addObject:UUID];
        [self.delegate performSelector:@selector(foundDeviceWithUUID:) withObject:UUID];
    }
    
}


@end
