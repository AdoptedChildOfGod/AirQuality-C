//
//  SRDCityAirQuality.h
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRDWeather;
@class SRDPollution;

NS_ASSUME_NONNULL_BEGIN

@interface SRDCityAirQuality : NSObject

@property (nonatomic, readonly, copy) NSString *city;
@property (nonatomic, readonly, copy) NSString *state;
@property (nonatomic, readonly, copy) NSString *country;
@property (nonatomic, readonly, copy) SRDWeather *weather;
@property (nonatomic, readonly, copy) SRDPollution *pollution;

- (instancetype) initWithCity:(NSString *)city
                        state:(NSString *)state
                      country:(NSString *)country
                      weather:(SRDWeather *)weather
                    pollution:(SRDPollution *)pollution;

@end

@interface SRDCityAirQuality (JSONConvertible)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
