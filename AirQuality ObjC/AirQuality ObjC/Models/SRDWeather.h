//
//  SRDWeather.h
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRDWeather : NSObject

@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger windSpeed;

- (instancetype) initWithTemperature:(NSInteger)temperature
                            humidity:(NSInteger)humidity
                           windspeed:(NSInteger)windSpeed;

@end

@interface SRDWeather (JSONConvertible)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
