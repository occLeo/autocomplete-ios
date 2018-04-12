//
//  Autocomplete.m
//  Autocomplete
//
//  Created by Leonardo Carrillo on 12/04/18.
//  Copyright © 2018 Leonardo Carrillo. All rights reserved.
//

#import "Autocomplete.h"

#import "Request.h"
#import "ServiceErrors.h"

#define kRCS_SERVICE_AUTOCOMPLETE    @"/api/{type}/autocomplete"

#define GS_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

@implementation Autocomplete

#pragma mark -

+ (NSString *)domain {
	
	NSString *domain = nil;
	NSDictionary *appInfo = [self occServiceInfo];
	if ([appInfo objectForKey:@"ACP_DOMAIN"]) {
		domain = [appInfo objectForKey:@"ACP_DOMAIN"];
	}	else if ([appInfo objectForKey:@"UNI_DOMAIN"])	{
		domain = [appInfo objectForKey:@"UNI_DOMAIN"];
	}
	return domain;
}

+ (NSString *)bundleVersion {
	return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appKey {
	NSDictionary *appInfo = [self occServiceInfo];
	return [appInfo objectForKey:@"APP_KEY"] ? [appInfo objectForKey:@"APP_KEY"] : nil;
}

+ (NSString *)appKeySecret {
	NSDictionary *appInfo = [self occServiceInfo];
	return [appInfo objectForKey:@"APP_KEY_SECRET"] ? [appInfo objectForKey:@"APP_KEY_SECRET"] : nil;
}

+ (NSDictionary *)occServiceInfo {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"OCCService-Info" ofType: @"plist"];
	return [NSDictionary dictionaryWithContentsOfFile: path];
}

#pragma  mark - Request

+ (void)performRequestWithResource:(NSString *)resource domain:(NSString *)domain method:(NSString *)method parameters:(NSDictionary *)parameters body:(NSString *)body data:(NSData *)data contentType:(NSString *)contentType time:(NSTimeInterval)time successCode:(int)successCode completionHandler:(void(^)(NSDictionary *response, NSDictionary *error))completionHandler {
	
	[Request requestResource:resource domain:domain method:method parameters:parameters body:body data:data contentType:contentType appKey:[self appKey] appSecretKey:[self appKeySecret] version:GS_VERSION time:25.0f completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		NSDictionary 	*dResponse = nil;
		NSDictionary	*dErrorResponse    =    nil;
		NSDictionary  	*serviceError    =    nil;
		
		if ([data length] > 0 && error == nil)    {
			
			NSString *sResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			NSDictionary *dJSON = [NSJSONSerialization JSONObjectWithData:[sResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
			NSArray	*errors	=	dJSON[@"errors"];
			
			NSInteger    iStatusCode = [(NSHTTPURLResponse *)response statusCode];
			
			NSLog(@"RCS_performRequestWithResource_response	:	%i,	%@",	(int)iStatusCode, sResponse);
			
			if (!errors || [errors count] == 0) {
				
				dResponse = dJSON;
				
			}	else 	{
				
				NSLog(@"RCS_performRequestWithResource_errors	:	%i,	%@",	(int)iStatusCode, errors);
				if ([errors count] > 0) serviceError	=	errors[0];
			}
		}
		
		if (!dResponse) {
			dErrorResponse	=	[ServiceErrors errorResponseForServiceError:serviceError];
		}
		
		completionHandler(dResponse, dErrorResponse);
	}];
}

#pragma  mark - Autocomplete

+ (void)getCategoryAutocompleteWithTerm:(NSString*)term completionHandler:(void(^)(NSDictionary *response, NSDictionary *error))completionHandler {
	
	//    https://empresas.occ.com.mx/api/cat/autocomplete?text={texto}
	
	if (!term) return;
	
	NSDictionary    *p    =    @{
								 @"text":term
								 };
	
	//    Service
	NSString    *service    =    kRCS_SERVICE_AUTOCOMPLETE;
	service    =    [service stringByReplacingOccurrencesOfString:@"{type}" withString:@"cat"];
	
	[self getAutocompleteWithParams:p service:service completionHandler:^(NSDictionary *response, NSDictionary *error) {
		completionHandler(response, error);
	}];
}

+ (void)getLocationAutocompleteWithTerm:(NSString*)term completionHandler:(void(^)(NSDictionary *response, NSDictionary *error))completionHandler {
	
	//    https://empresas.occ.com.mx/api/cat/autocomplete?text={texto}
	
	if (!term) return;
	
	NSDictionary    *p    =    @{
								 @"text":term,
								 @"emptyValues":@"false"
								 };
	
	//    Service
	NSString    *service    =    kRCS_SERVICE_AUTOCOMPLETE;
	service    =    [service stringByReplacingOccurrencesOfString:@"{type}" withString:@"gis"];
	
	[self getAutocompleteWithParams:p service:service completionHandler:^(NSDictionary *response, NSDictionary *error) {
		completionHandler(response, error);
	}];
}

+ (void)getAutocompleteWithParams:(NSDictionary*)params service:(NSString*)service  completionHandler:(void(^)(NSDictionary *response, NSDictionary *error))completionHandler {
	
	if (!params) return;
	
	NSString    *domain    =    [self occServiceInfo][@"ACP_DOMAIN"];
	
	[self performRequestWithResource:service domain:domain method:@"GET" parameters:params body:nil data:nil contentType:nil time:25.0f successCode:200 completionHandler:^(NSDictionary *response, NSDictionary *error) {
		
		completionHandler(response, error);
	}];
}

@end
