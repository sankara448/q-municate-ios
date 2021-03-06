//
//  Created by Injoit on 3/11/10.
//  Copyright © 2015 QuickBlox. All rights reserved.
//

#import "QMCDRecordInternal.h"
#import "QMCDRecordStack.h"

@implementation QMCDRecord

+ (NSString *)defaultStoreName
{
    NSString *defaultName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(id)kCFBundleNameKey];

    if (defaultName == nil)
    {
        defaultName = @"CoreDataStore.sqlite";
    }

    if (![defaultName hasSuffix:@"sqlite"])
    {
        defaultName = [defaultName stringByAppendingPathExtension:@"sqlite"];
    }

    return defaultName;
}

@end
