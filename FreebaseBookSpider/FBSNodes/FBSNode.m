//
//  FBSNode.m
//  FreebaseBookSpider
//
//  Created by Raffaele Bua on 21/04/14.

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

#import "FBSNode.h"

@implementation FBSNode
@synthesize nodeId;
@synthesize lang;
@synthesize mid;
@synthesize name;
@synthesize notableId;
@synthesize notableName;


-(id)initWithId:(NSString *)anodeId lang:(NSString *)aLang mid:(NSString *)aMid name:(NSString *)aName notableId:(NSString *)aNotableId notableName:(NSString *)aNotableName
{
    self = [super init];
    if(self){
        nodeId = (anodeId)?[anodeId retain]:@"";
        lang = (aLang)?[aLang retain]:@"";
        mid = (aMid)?[aMid retain]:@"";
        name = (aName)?[aName retain]:@"";
        notableId = (aNotableId)?[aNotableId retain]:@"";
        notableName = (aNotableName)?[aNotableName retain]:@"";
    }
    return self;
}

-(id)initWithFBSNode:(FBSNode *)aNode
{
    self = [super init];
    if(self){
        nodeId = [aNode.nodeId retain];
        lang = (aNode.lang)?[aNode.lang retain]:@"";
        mid = (aNode.mid)?[aNode.mid retain]:@"";
        name = (aNode.name)?[aNode.name retain]:@"";
        notableId = (aNode.notableId)?[aNode.notableId retain]:@"";
        notableName = (aNode.notableName)?[aNode.notableName retain]:@"";
    }
    return self;
}

-(id)initWithId:(NSString *)anodeId name:(NSString *)aName{
    self = [self initWithId:anodeId lang:nil mid:nil name:aName notableId:nil notableName:nil];
    return self;
}

-(void)dealloc
{
    [nodeId release];
    [lang release];
    [mid release];
    [name release];
    [notableId release];
    [notableName release];
    [super dealloc];
}

@end
