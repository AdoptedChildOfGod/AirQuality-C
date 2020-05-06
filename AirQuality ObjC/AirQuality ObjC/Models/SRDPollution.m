//
//  SRDPollution.m
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "SRDPollution.h"

static NSString * const airQualityKey = @"aqius";

@implementation SRDPollution

- (instancetype)initWithAirQuality:(NSInteger)airQuality
{
    self = [super init];
    if (self)
    {
        _airQuality = airQuality;
    }
    return self;
}

@end

@implementation SRDPollution (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger airQuality = [dictionary[airQualityKey] integerValue];
    
    return [self initWithAirQuality:airQuality];
}

@end
