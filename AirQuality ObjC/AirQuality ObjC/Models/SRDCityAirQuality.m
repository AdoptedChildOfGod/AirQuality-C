//
//  SRDCityAirQuality.m
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "SRDCityAirQuality.h"
#import "SRDWeather.h"
#import "SRDPollution.h"

static NSString * const dataKey = @"data";
static NSString * const cityKey = @"city";
static NSString * const stateKey = @"state";
static NSString * const countryKey = @"country";
static NSString * const objectKey = @"current";
static NSString * const weatherKey = @"weather";
static NSString * const pollutionKey = @"pollution";

@implementation SRDCityAirQuality

- (instancetype) initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(SRDWeather *)weather pollution:(SRDPollution *)pollution
{
    self = [super init];
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}

@end

@implementation SRDCityAirQuality (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    NSDictionary *dataDictionary = dictionary[dataKey];
    NSString *city = dataDictionary[cityKey];
    NSString *state = dataDictionary[stateKey];
    NSString *country = dataDictionary[countryKey];
    
    NSDictionary *objectDictionary = dataDictionary[objectKey];
    SRDWeather *weather = [[SRDWeather alloc] initWithDictionary:objectDictionary[weatherKey]];
    SRDPollution *pollution = [[SRDPollution alloc] initWithDictionary:objectDictionary[pollutionKey]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
