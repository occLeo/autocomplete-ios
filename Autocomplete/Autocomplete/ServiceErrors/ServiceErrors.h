//
//  ServiceErrors.h
//  RCS
//
//  Created by Leonardo Carrillo on 05/03/18.
//  Copyright © 2018 Leonardo Carrillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceErrors : NSObject
+ (NSDictionary*)errorResponseForServiceError:(NSDictionary*)serviceError;
@end
