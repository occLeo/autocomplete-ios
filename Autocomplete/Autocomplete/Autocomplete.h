//
//  Autocomplete.h
//  Autocomplete
//
//  Created by Leonardo Carrillo on 12/04/18.
//  Copyright © 2018 Leonardo Carrillo. All rights reserved.
//

//	Librería Autocomplete v 1.0
//
//  Códigos de error
//
//
//
//
//
//  OCCService-Info.plist   // requerido para la configuración de la librería
//
//  APP_KEY         // token de la app
//  APP_KEY_SECRET  // token secreto de la app
//  ACP_DOMAIN      // dominio del api solo para este servicio
//  UNI_DOMAIN      // dominio universal para todos los servicios

#import <Foundation/Foundation.h>

@interface Autocomplete : NSObject

+ (void)getCategoryAutocompleteWithTerm:(NSString*)term completionHandler:(void(^)(NSDictionary *response, NSDictionary *error))completionHandler;
+ (void)getLocationAutocompleteWithTerm:(NSString*)term completionHandler:(void(^)(NSDictionary *response, NSDictionary *error))completionHandler;

@end
