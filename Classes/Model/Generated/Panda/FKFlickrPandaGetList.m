//
//  FKFlickrPandaGetList.m
//  FlickrKit
//
//  Generated by FKAPIBuilder on 12 Jun, 2013 at 17:19.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrPandaGetList.h" 

@implementation FKFlickrPandaGetList

- (BOOL) needsLogin {
    return NO;
}

- (BOOL) needsSigning {
    return NO;
}

- (FKPermission) requiredPerms {
    return -1;
}

- (NSString *) name {
    return @"flickr.panda.getList";
}

- (BOOL) isValid:(NSError **)error {
    BOOL valid = YES;
	NSMutableString *errorDescription = [[NSMutableString alloc] initWithString:@"You are missing required params: "];

	if(error != NULL) {
		if(!valid) {	
			NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorDescription};
			*error = [NSError errorWithDomain:FKFlickrKitErrorDomain code:FKErrorInvalidArgs userInfo:userInfo];
		}
	}
    return valid;
}

- (NSDictionary *) args {
    NSMutableDictionary *args = [NSMutableDictionary dictionary];

    return [args copy];
}

- (NSString *) descriptionForError:(NSInteger)error {
    switch(error) {
		case FKFlickrPandaGetListError_InvalidAPIKey:
			return @"Invalid API Key";
		case FKFlickrPandaGetListError_ServiceCurrentlyUnavailable:
			return @"Service currently unavailable";
		case FKFlickrPandaGetListError_FormatXXXNotFound:
			return @"Format \"xxx\" not found";
		case FKFlickrPandaGetListError_MethodXXXNotFound:
			return @"Method \"xxx\" not found";
		case FKFlickrPandaGetListError_InvalidSOAPEnvelope:
			return @"Invalid SOAP envelope";
		case FKFlickrPandaGetListError_InvalidXMLRPCMethodCall:
			return @"Invalid XML-RPC Method Call";
		case FKFlickrPandaGetListError_BadURLFound:
			return @"Bad URL found";
  
		default:
			return @"Unknown error code";
    }
}

@end
