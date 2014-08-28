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

@end
