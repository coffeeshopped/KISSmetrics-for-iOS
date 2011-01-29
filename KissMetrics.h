//
//  KissMetrics.h
//  KISSmetrics-for-iOS
//
//  Created by Chadwick Wood on 1/28/11.
//  Copyright 2011 Coffeeshopped LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KissMetrics : NSObject {
	NSString *apiKey, *identity;
}

@property (nonatomic, copy) NSString *apiKey;
@property (readonly) NSString *identity;

- (void)record:(NSString *)name properties:(NSDictionary *)properties;
- (void)set:(NSDictionary *)properties;
- (void)identify:(NSString *)identity1;
- (void)alias:(NSString *)identity1 withIdentity:(NSString *)identity2;

- (NSURL *)urlForAction:(NSString *)action data:(NSDictionary *)data;
- (void)sendRequest:(NSURL *)url;

@end
