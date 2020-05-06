//
//  SRDPollution.h
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRDPollution : NSObject

@property (nonatomic, readonly) NSInteger airQuality;

- (instancetype) initWithAirQuality:(NSInteger)airQuality;

@end

@interface SRDPollution (JSONConvertible)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
