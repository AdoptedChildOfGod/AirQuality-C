//
//  SRDWeather.m
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "SRDWeather.h"

@implementation SRDWeather

static NSString * const temperatureKey = @"tp";
static NSString * const humidityKey = @"hu";
static NSString * const windSpeedKey = @"ws";

- (instancetype)initWithTemperature:(NSInteger)temperature humidity:(NSInteger)humidity windspeed:(NSInteger)windSpeed
{
    self = [super init];
    if (self)
    {
        _temperature = temperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
    }
    return self;
}

@end

@implementation SRDWeather (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger temperature = [dictionary[temperatureKey] integerValue];
    NSInteger humidity = [dictionary[humidityKey] integerValue];
    NSInteger windSpeed = [dictionary[windSpeedKey] integerValue];
    
    return [self initWithTemperature:temperature humidity:humidity windspeed:windSpeed];
}

@end
