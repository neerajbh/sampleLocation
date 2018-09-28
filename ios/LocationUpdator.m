//
//  LocationUpdator.m
//  project
//
//  Created by neeraj bhatt on 26/09/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

//@implementation LocationUpdator: NSObject
//
//RCT_EXPORT_MODULE();
//
//RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location){}
//RCT_EXPORT_METHOD(locationUpdate){}
//
//@end


@interface RCT_EXTERN_MODULE(LocationUpdator, NSObject)



RCT_EXTERN_METHOD(methodQueue)
RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location)
RCT_EXTERN_METHOD(locationUpdate)
@end
