//
//  UrlRepository.h
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

#import <Foundation/Foundation.h>

@interface FBSResources : NSObject
{
    NSDictionary * freebaseUrls;
    NSDictionary * mqlQueries;
    NSString * nodesByKeywordBaseUrl;
    NSString * nodePropertiesByIdBaseUrl;
    NSString * imageBaseUrl;
}

-(void)loadResources;

#pragma mark query parameters
-(NSDictionary* )getFreebaseBaseUrls;
-(NSDictionary* )getMQLQueries;

#pragma mark urls
-(NSString*) getBaseUrl;
-(NSString* )getRunMqlQueryUrl;

#pragma mark main protocol
-(NSURL *)getBookNodesUrlByKeyword:(NSString * )keyword;
-(NSURL *)getNodePropertiesUrlById:(NSString * )nodeId;
-(NSURL *)getImageUrlById:(NSString * )imageId;


@end
