//
//  SRDAirController.m
//  AirQuality ObjC
//
//  Created by Shannon Draeker on 5/6/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "SRDAirController.h"
#import "SRDCityAirQuality.h"

static NSString * const apiKey = @"key";
static NSString * const apiKeyValue = @"abf39a51-0191-43f9-b3a4-a718bf3e0a2b";
static NSString * const baseURLString = @"https://api.airvisual.com/";
static NSString * const versionComponent = @"v2";
static NSString * const countryComponent = @"countries";
static NSString * const stateComponent = @"states";
static NSString * const citiesComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const dataKey = @"data";
static NSString * const countryKey = @"country";
static NSString * const stateKey = @"state";
static NSString * const cityKey = @"city";

@implementation SRDAirController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable countries))completion
{
    // Create the base url
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:versionComponent];
    baseURL = [baseURL URLByAppendingPathComponent:countryComponent];
    
    // Add the API key
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:apiKey value:apiKeyValue]];
    
    // Get the final URL
    NSURL *finalURL = urlComponents.URL;
    
    // Make the call to the server
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { return completion(nil); }
        
        if (!data) { return completion(nil); }
        
        // Convert the data to a JSON dictionary
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        if (![jsonDictionary isKindOfClass:[NSDictionary class]]) { return completion(nil); }
        
        // Initialize the array to return
        NSMutableArray *countries = [NSMutableArray new];
        
        // Loop through the array of dictionaries to get the country names
        NSArray *dataArray = jsonDictionary[dataKey];
        for (NSDictionary *countryDictionary in dataArray)
        {
            [countries addObject:countryDictionary[countryKey]];
        }
        return completion(countries);
        
    }] resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable states))completion
{
    // Create the base url
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:versionComponent];
    baseURL = [baseURL URLByAppendingPathComponent:stateComponent];
    
    // Add the country and API keys
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:apiKey value:apiKeyValue];
    NSURLQueryItem *countryQuery = [NSURLQueryItem queryItemWithName:countryKey value:country];
    urlComponents.queryItems = @[apiQuery, countryQuery];
    
    // Get the final URL
    NSURL *finalURL = urlComponents.URL;
    
    // Make the call to the server
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { return completion(nil); }
        
        if (!data) { return completion(nil); }
        
        // Convert the data to a JSON dictionary
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        if (![jsonDictionary isKindOfClass:[NSDictionary class]]) { return completion(nil); }
        
        // Initialize the array to return
        NSMutableArray *states = [NSMutableArray new];
        
        // Loop through the array of dictionaries to get the country names
        NSArray *dataArray = jsonDictionary[dataKey];
        for (NSDictionary *stateDictionary in dataArray)
        {
            [states addObject:stateDictionary[stateKey]];
        }
        return completion(states);
        
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable cities))completion
{
    // Create the base url
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:versionComponent];
    baseURL = [baseURL URLByAppendingPathComponent:citiesComponent];
    
    // Add the country, state, and API keys
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:apiKey value:apiKeyValue];
    NSURLQueryItem *countryQuery = [NSURLQueryItem queryItemWithName:countryKey value:country];
    NSURLQueryItem *stateQuery = [NSURLQueryItem queryItemWithName:stateKey value:state];
    urlComponents.queryItems = @[apiQuery, countryQuery, stateQuery];
    
    // Get the final URL
    NSURL *finalURL = urlComponents.URL;
    
    // Make the call to the server
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { return completion(nil); }
        
        if (!data) { return completion(nil); }
        
        // Convert the data to a JSON dictionary
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        if (![jsonDictionary isKindOfClass:[NSDictionary class]]) { return completion(nil); }
        
        // Initialize the array to return
        NSMutableArray *cities = [NSMutableArray new];
        
        // Loop through the array of dictionaries to get the country names
        NSArray *dataArray = jsonDictionary[dataKey];
        for (NSDictionary *stateDictionary in dataArray)
        {
            [cities addObject:stateDictionary[cityKey]];
        }
        return completion(cities);
        
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(SRDCityAirQuality * _Nullable cityAirQuality))completion
{
    // Create the base url
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:versionComponent];
    baseURL = [baseURL URLByAppendingPathComponent:cityDetailsComponent];
    
    // Add the country, state, and API keys
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:apiKey value:apiKeyValue];
    NSURLQueryItem *countryQuery = [NSURLQueryItem queryItemWithName:countryKey value:country];
    NSURLQueryItem *stateQuery = [NSURLQueryItem queryItemWithName:stateKey value:state];
    NSURLQueryItem *cityQuery = [NSURLQueryItem queryItemWithName:cityKey value:city];
    urlComponents.queryItems = @[apiQuery, countryQuery, stateQuery, cityQuery];
    
    // Get the final URL
    NSURL *finalURL = urlComponents.URL;
    
    // Make the call to the server
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { return completion(nil); }
        
        if (!data) { return completion(nil); }
        
        // Convert the data to a JSON dictionary
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        if (![jsonDictionary isKindOfClass:[NSDictionary class]]) { return completion(nil); }
        
        // Create the object from the JSON data
        SRDCityAirQuality *cityAirQuality = [[SRDCityAirQuality alloc] initWithDictionary:jsonDictionary];
        return completion(cityAirQuality);
        
    }] resume];
}

@end
