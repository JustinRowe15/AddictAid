//
//  NSDictionary+Data.m
//  AddictAid
//
//  Created by Justin Rowe on 8/28/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "NSDictionary+Data.h"

@implementation NSDictionary (glossaryDictionary)

-(NSArray *)glossaryArray
{
    return [self objectForKey:@"glossary"];
}

-(NSArray *)alcoholArray
{
    return [self objectForKey:@"alcohol"];
}

-(NSArray *)drugsArray
{
    return [self objectForKey:@"drugs"];
}

-(NSString *)termsString
{
    return [self objectForKey:@"Term"];
}

-(NSString *)definitionsString
{
    return [self objectForKey:@"Definition"];
}

-(NSArray *)locationsArray
{
    return [self objectForKey:@"locations"];
}

-(NSString *)dayString
{
    return [self objectForKey:@"Day"];
}

-(NSString *)timeString
{
    return [self objectForKey:@"Time"];
}

-(NSString*)groupNameString
{
    return [self objectForKey:@"Group Name"];
}

-(NSString *)addressString
{
    return [self objectForKey:@"Address"];
}

-(NSString *)cityString
{
    return [self objectForKey:@"City"];
}

-(NSArray *)quotesArray
{
    return [self objectForKey:@"quotes"];
}

-(NSString *)authorString
{
    return [self objectForKey:@"Author"];
}

-(NSString *)quoteString
{
    return [self objectForKey:@"Quote"];
}

@end
