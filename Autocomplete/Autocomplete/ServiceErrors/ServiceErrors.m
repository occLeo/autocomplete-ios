//
//  ServiceErrors.m
//  RCS
//
//  Created by Leonardo Carrillo on 05/03/18.
//  Copyright © 2018 Leonardo Carrillo. All rights reserved.
//

#import "ServiceErrors.h"

@implementation ServiceErrors

+ (NSDictionary*)errorResponseForServiceError:(NSDictionary*)serviceError {
    
    NSString    *serviceErrorCode    =    serviceError[@"code"];
	NSDictionary	*answer	=	[self serviceUnavailableError];
	
	NSDictionary	*error	=	[self errorsCatalog][serviceErrorCode];
	NSLog(@"SE_errorResponseForServiceError	:	%@",	error);
	
	if (error) {
		
		answer	=	@{
					  @"code":error[@"code"],
					  @"description":error[@"description"],
					  @"detail":serviceError
					  };
	}
	
	return answer;
}

#pragma mark -

+ (NSDictionary*)serviceUnavailableError {
    
    return @{
             @"code":@"2",
             @"description":@"service unavailable",
             @"detail":@"request error"
             };
}

#pragma mark -

+ (NSDictionary*)errorsCatalog	{
	
	NSDictionary	*catalog	=	@{};
	return catalog;
}

@end
