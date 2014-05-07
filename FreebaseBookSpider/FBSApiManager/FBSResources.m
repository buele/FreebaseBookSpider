//
//  UrlRepository.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 03/04/14.
/*****************************************************************************
 The MIT License (MIT)
 
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 *****************************************************************************/

#import "FBSResources.h"


@implementation FBSResources

static FBSResources * sharedResources_  = nil;

static NSString *  FREEBASE_URLS_FILE_NAME                      = @"freebase_urls";
static NSString *  FREEBASE_URLS_FILE_EXT                       = @"plist";
static NSString *  MQL_QUERIES_FILE_NAME                        = @"mql_queries";
static NSString *  MQL_QUERIES_FILE_EXT                         = @"plist";
static NSString *  FREEBASE_API_BASE_URL_KEY                    = @"api_base_url";
static NSString *  FREEBASE_RUN_QUERY_URL_KEY                   = @"run_query_url";
static NSString *  FREEBASE_ENTITIES_BY_KEYWORD_PARAMETERS_KEY  = @"entities_by_keyword_parameters";
static NSString *  FREEBASE_LANGUAGE_PARAMETER_KEY              = @"lang";
static NSString *  FREEBASE_QUERY_PARAMETER_KEY                 = @"query";
static NSString *  FREEBASE_SEARCH_PARAMETER_KEY                = @"search";
static NSString *  FREEBASE_TOPIC_PARAMETER_KEY                 = @"topic";
static NSString *  FREEBASE_IMAGE_PARAMETER_KEY                 = @"image";

-(id)init
{
    self = [super init];
    if(self){
        freebaseApiKey = nil;
        // load resources
        freebaseUrls =  [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:FREEBASE_URLS_FILE_NAME ofType:FREEBASE_URLS_FILE_EXT]];
        mqlQueries =  [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:MQL_QUERIES_FILE_NAME ofType:MQL_QUERIES_FILE_EXT]];
        // init urls
        nodesByKeywordBaseUrl = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@?%@&%@=",[self getBaseUrl],FREEBASE_SEARCH_PARAMETER_KEY, [self getNodesByKeywordParameters],FREEBASE_QUERY_PARAMETER_KEY] ];
        nodePropertiesByIdBaseUrl = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",[self getBaseUrl],FREEBASE_TOPIC_PARAMETER_KEY ]];
        imageBaseUrl = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",[self getBaseUrl],FREEBASE_IMAGE_PARAMETER_KEY ]];
    }
    return self;
}


-(NSString *) getBaseUrl
{
    return [freebaseUrls objectForKey:FREEBASE_API_BASE_URL_KEY];
}

-(NSString *)getRunMqlQueryUrl
{
    return [NSString stringWithFormat:@"%@%@",
            [self getBaseUrl],
            [freebaseUrls objectForKey:FREEBASE_RUN_QUERY_URL_KEY]];
}

-(NSString *)encodeUrl:(NSString*)url
{
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(NSString *)getNodesByKeywordParameters
{
    return  [NSString stringWithFormat:@"%@%@",[freebaseUrls objectForKey:FREEBASE_ENTITIES_BY_KEYWORD_PARAMETERS_KEY],[self getLanguageParameter]];
}

-(NSString *)getLanguageParameter
{
    return [NSString stringWithFormat: @"&%@=%@",FREEBASE_LANGUAGE_PARAMETER_KEY,@"en"];
}

#pragma mark main protocol
-(NSURL *)bookNodesUrlByKeyword:(NSString * )keyword 
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", nodesByKeywordBaseUrl,[self encodeUrl:[keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]]];
}

-(NSURL *)nodePropertiesUrlById:(NSString * )nodeId
{
    static NSString *  FREEBASE_ALL_PROPERTIES_FILTER_PARAMETER_KEY = @"filter=allproperties";
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@", nodePropertiesByIdBaseUrl,[self encodeUrl:nodeId],FREEBASE_ALL_PROPERTIES_FILTER_PARAMETER_KEY  ]];
}

-(NSURL *)imageUrlById:(NSString * )imageId
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageBaseUrl,imageId]];
}

-(void)setFreebaseApiKey:(NSString *)aFreebaseApiKey
{
    if(aFreebaseApiKey){
        if(freebaseApiKey){
            [aFreebaseApiKey retain];
            [freebaseApiKey release];
            freebaseApiKey = aFreebaseApiKey;
        }else{
            freebaseApiKey = [[NSString alloc]initWithString:aFreebaseApiKey];
        }
    }
}

#pragma mark static method
+ (FBSResources *) getSharedInstance {
    if (sharedResources_ == nil)
        sharedResources_ = [[FBSResources alloc] init];
    return sharedResources_;
}

-(void)dealloc
{
    [freebaseUrls release];
    [mqlQueries release];
    [nodesByKeywordBaseUrl release];
    [nodePropertiesByIdBaseUrl release];
    [imageBaseUrl release];
    if(freebaseApiKey)
        [freebaseApiKey release];
    [super dealloc];
}

@end
