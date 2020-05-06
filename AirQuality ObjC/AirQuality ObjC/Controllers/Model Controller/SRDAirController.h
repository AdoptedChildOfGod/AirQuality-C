//
//  SRDAirController.h
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRDCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRDAirController : NSObject

+ (void) fetchSupportedCountries:(void (^)(NSArray<NSString *> *countries))completion;

+ (void) fetchSupportedStatesInCountry:(NSString *)country
                            completion:(void (^)(NSArray<NSString *> *states))completion;

+ (void) fetchSupportedCitiesInState:(NSString *)state
                             country:(NSString *)country
                          completion:(void (^)(NSArray<NSString *> *cities))completion;

+ (void) fetchDataForCity:(NSString *)city
                    state:(NSString *)state
                  country:(NSString *)country
               completion:(void (^)(SRDCityAirQuality *cityAirQuality))completion;

@end

NS_ASSUME_NONNULL_END
