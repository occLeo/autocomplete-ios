//
//  Request.h
//  Request
//
//  Created by Javier Sanchez on 2/21/18.
//  Copyright © 2018 OCCMundial. All rights reserved.
//
// Librería Request v1.0
//
// Realliza peticiones a los servicios con NSURLSession

#import <Foundation/Foundation.h>

@interface Request : NSObject

/*
 METHOD
 requestResource ** Realiza petición al servicio con los parámetros recibidos, regresa la respuesta por completion handler.
 
 PARAMETERS
 resource ** NSString ** requerido ** El servicio al cual se hará la petición, debe incluir el recurso y en su caso la instancia * ej. /aais/v1_0/authentication_token/
 
 domain ** NSString ** requerido ** El dominio al cual se hará la petición ** ej. https://api.occ.com.mx
 
 method ** NSString ** requerido ** El método que hará la petición ** ej. GET POST etc.
 
 parameters ** NSDictionary ** requerido ** Los parámetros que incluye la petición
 
 body ** NSString ** posiblemente nil ** Cadena que se mandaen el body de la petición, si el parámetro data no es nil, se descarta el parámetro body.
 
 data ** NSData ** posiblemente nil ** Data que se manda en el body de la petición, si el parámetro data no es nil, se descarta el parámetro body. ** ej. Por lo general se usa para enviar un archivo como la foto.
 
 contentType ** NSString ** posiblemente nil ** El content type de la petición.
 
 appKey ** NSString ** requerido ** El token key de la aplicación que solicita la petición.
 
 appSecretKey ** NSString ** requerido ** El token key secreto de la aplicación que solicita la petición.
 
 version ** NSString ** requerido ** Versión de la aplicación que solicita la petición.
 
 time ** NSTimeInterval ** requerido, time <= 0.0 toma el default 25.0 ** Tiempo máximo para espera de respuesta de la petición.
 
 RETURN
 data ** NSData ** Contiene los datos de respuesta de la petición.
 
 response ** NSURLResponse ** Contiene la respuesta de la petición. ** ej. Status code.
 
 error ** NSError ** Contiene el error al enviar la petición, en caso de que suceda.
 */
+ (void)requestResource:(NSString *)resource domain:(NSString *)domain method:(NSString *)method parameters:(NSDictionary *)parameters body:(NSString *)body data:(NSData *)data contentType:(NSString *)contentType appKey:(NSString *)appKey appSecretKey:(NSString *)appSecretKey version:(NSString *)version time:(NSTimeInterval)time completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@end
