//
//  NSDictionary+Data.h
//  AddictAid
//
//  Created by Justin Rowe on 8/28/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (glossaryDictionary)

//From definitions JSON array
-(NSArray *)glossaryArray;
-(NSString *)termsString;
-(NSString *)definitionsString;

//From locations JSON array
-(NSArray *)locationsArray;
-(NSString *)dayString;
-(NSString *)timeString;
-(NSString *)groupNameString;
-(NSString *)addressString;
-(NSString *)cityString;

@end