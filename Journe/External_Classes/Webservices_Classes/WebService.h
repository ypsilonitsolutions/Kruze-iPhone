//
//  WebService.h
//
//  Created by MaheshDhakad on 08/07/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#include "Constant.h"

#import <Foundation/Foundation.h>

typedef enum {
    resultData=0,
    
    errorData,
    
    timeOut,
    
    resultOk
    
} MDDataTypes;

@interface WebService : NSObject

-(void)call_API:(NSDictionary *)dict andURL:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock;

-(void)call_API:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock;

-(void)call_API:(NSDictionary *)dict andImage:(UIImage*)image andURL:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock;

@end
