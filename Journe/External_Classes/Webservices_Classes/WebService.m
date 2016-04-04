//
//  WebService.m
//
//  Created by MaheshDhakad on 08/07/15.
//  Copyright (c) 2015 admin. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "WebService.h"
#import "InternetAccess.h"


@implementation WebService : NSObject


-(void)call_API:(NSDictionary *)dict andURL:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock{
    
    
    InternetAccess  *access=[[InternetAccess alloc] init];
    
    if ([access checkInternet]==0) {
        
        NSMutableDictionary *res_dict = [[NSMutableDictionary alloc]init];
        
        [res_dict setValue:@"false" forKey:@"status"];
        
        [res_dict setValue:@"No network found Please retry or check your network settings." forKey:@"msg"];
        
        OnResultBlock(res_dict,resultData,@"failure");

    }else{

        NSURL *baseURL = [NSURL URLWithString:url];
        
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html",nil]];
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [client setDefaultHeader:@"Accept" value:@"application/json"];
        [client postPath:@"POST" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSMutableDictionary *dict = responseObject;
             OnResultBlock(dict,resultData,@"");
             
         }failure:^(AFHTTPRequestOperation *operation, NSError *error){
             
             NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
             
             [dict setValue:@"false" forKey:@"status"];
             
             [dict setValue:@"Connection timeout, try later!" forKey:@"msg"];
             OnResultBlock(dict,resultData,@"failure");
         }
         ];

    }
}
-(void)call_API:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock
{
    
    InternetAccess  *access=[[InternetAccess alloc] init];
    
    if ([access checkInternet]==0) {
        
        NSMutableDictionary *res_dict = [[NSMutableDictionary alloc]init];
        
        [res_dict setValue:@"false" forKey:@"status"];
        
        [res_dict setValue:@"No network found Please retry or check your network settings." forKey:@"msg"];
        
        OnResultBlock(res_dict,resultData,@"failure");
        
    }
    else
    {
    
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *baseUrl=[NSURL URLWithString:url];
        
        NSURLRequest *req=[NSURLRequest requestWithURL:baseUrl];
        
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:
         ^(NSURLResponse *resp, NSData *data, NSError *err)
         {
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) resp;
             NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
             NSString *code = [NSString stringWithFormat:@"%ld",(long)[httpResponse statusCode]];
             NSMutableDictionary *dictionary1 =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
             if (data == nil)
             {
                 NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                 
                 [dict setValue:@"false" forKey:@"status"];
                 
                 [dict setValue:@"Connection timeout, try later!" forKey:@"msg"];
                 OnResultBlock(dict,resultData,@"failure");
                 
             }
             else
             {
                 
                 OnResultBlock(dictionary1,resultData,code);
             }
             
         }];

    }
}




-(void)call_API:(NSDictionary *)dict andImage:(UIImage*)image andURL:(NSString *)url OnResultBlock:(void(^)(id,MDDataTypes ,NSString *))OnResultBlock{
    
    InternetAccess  *access=[[InternetAccess alloc] init];
    
    if ([access checkInternet]==0) {
        
        NSMutableDictionary *res_dict = [[NSMutableDictionary alloc]init];
        
        [res_dict setValue:@"false" forKey:@"status"];
        
        [res_dict setValue:@"No network found Please retry or check your network settings." forKey:@"msg"];
        
        OnResultBlock(res_dict,resultData,@"failure");
        
    }else{
   
        NSURL *baseURL = [NSURL URLWithString:url];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        
        NSData *imageData = UIImagePNGRepresentation(image);
        
        NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:dict constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
            if (image != nil) {
                [formData appendPartWithFileData:imageData name:@"user_image" fileName:@"image.png" mimeType:@"image/png"];
                NSLog(@"With Image");
            }else{
                NSLog(@"Without Image");
            }
        }];
        
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSError *error = nil;
            NSMutableDictionary *res = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                NSLog(@"Error serializing %@", error);
            }
            
            OnResultBlock(res,resultData,@"");
            
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            [dict setValue:@"false" forKey:@"status"];
            
            [dict setValue:@"Connection timeout, try later!" forKey:@"msg"];
            OnResultBlock(dict,resultData,@"failure");
        }];
        
        [operation start];
        
    }
}




@end


// For Call APi where you want



/*
 
 WebService *api = [WebService alloc];

[api call_API:dict andURL:GET_CATEGORY_API OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status) {
    
    NSDictionary *dic = response ;
    
    NSString *sts=[dic objectForKey:@"status"];
    
    if ([sts isEqualToString:@"true"]) {
        
    }else{
        
    }
}];
 
 */

