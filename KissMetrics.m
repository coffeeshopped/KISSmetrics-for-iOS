//
//  KissMetrics.m
//  KISSmetrics-for-iOS
//
//  Created by Chadwick Wood on 1/28/11.
//  Copyright 2011 Coffeeshopped LLC. All rights reserved.
//

#import "KissMetrics.h"

@implementation KissMetrics

@synthesize apiKey, identity;

- (id)initWithKey:(NSString *)k {
	self = [super init];
	if (self) {
		self.apiKey = k;
	}
	return self;
}

# pragma mark KISSmetrics API 

- (void)record:(NSString *)name properties:(NSDictionary *)properties {
	// TODO throw exception if not yet identified
	
	NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:properties];
	[data setObject:self.identity forKey:@"_p"];
	[data setObject:name forKey:@"_n"];
	
	[self sendRequest:[self urlForAction:@"e" data:data]];
}


- (void)set:(NSDictionary *)properties {
	// throw exception if not yet identified
	
	NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:properties];
	[data setObject:self.identity forKey:@"_p"];
	
	[self sendRequest:[self urlForAction:@"s" data:data]];
}


- (void)identify:(NSString *)identity1 {
	identity = [identity1 copy];
}

- (void)alias:(NSString *)identity1 withIdentity:(NSString *)identity2 {
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
												identity1, @"_p",
												identity2, @"_n",
												nil];
	
	[self sendRequest:[self urlForAction:@"a" data:data]];
}


#pragma mark Utility methods

- (NSURL *)urlForAction:(NSString *)action data:(NSDictionary *)data {
	NSMutableArray* parts = [NSMutableArray arrayWithCapacity:[data count]];
  for (NSString* key in data) {
    [parts addObject:[NSString stringWithFormat:@"%@=%@",
											[key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
											[[[data objectForKey:key] description] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
  }
	NSString *urlString = [NSString stringWithFormat:@"http://trk.kissmetrics.com/%@?_k=%@&%@",
												 action, self.apiKey, [parts componentsJoinedByString:@"&"]];
	return [NSURL URLWithString:urlString];
}

- (void)sendRequest:(NSURL *)url {
	NSURLRequest *r = [NSURLRequest requestWithURL:url 
																		 cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
																 timeoutInterval:60.0];

	// connection will be released in callback methods
	[[NSURLConnection alloc] initWithRequest:r delegate:self];
}


#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[connection release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
}

- (void)dealloc {
	self.apiKey = nil;
	[identity release];
	
	[super dealloc];
}

@end
