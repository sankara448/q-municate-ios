//
//  QMAttachmentsMemoryStorage.m
//  Pods
//
//  Created by Injoit on 3/25/17.
//  Copyright © 2017 QuickBlox. All rights reserved.
//

#import "QMAttachmentsMemoryStorage.h"

@interface QMAttachmentsMemoryStorage()

@property (strong, nonatomic) NSMutableDictionary *attachmentsStorage;

@end

@implementation QMAttachmentsMemoryStorage

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _attachmentsStorage = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addAttachment:(QBChatAttachment *)attachment
         forMessageID:(NSString *)messageID {

    NSMutableOrderedSet *datasource = [self dataSourceWithMessageID:messageID];
    
    NSUInteger indexOfMessage = [datasource indexOfObject:attachment];
    
    if (indexOfMessage != NSNotFound) {
        
        [datasource replaceObjectAtIndex:indexOfMessage withObject:attachment];
        
    }
    else {
        
        [datasource addObject:attachment];
    }
}

- (void)updateAttachment:(QBChatAttachment *)attachment
            forMessageID:(NSString *)messageID {
    
    [self addAttachment:attachment
           forMessageID:messageID];
}

- (void)deleteAttachment:(QBChatAttachment *)attachment
            forMessageID:(NSString *)messageID {
    
    NSMutableOrderedSet *datasource = [self dataSourceWithMessageID:messageID];
    [datasource removeObject:attachment];
}


- (QBChatAttachment *)attachmentWithID:(NSString *)attachmentID
                         fromMessageID:(NSString *)messageID {
    
    NSParameterAssert(attachmentID != nil);
    NSParameterAssert(messageID != nil);
    
    NSMutableOrderedSet *attachments = [self dataSourceWithMessageID:messageID];
    
    for (QBChatAttachment *attachment in attachments) {
        
        if ([attachment.ID isEqualToString:attachmentID]) {
            
            return attachment;
        }
    }
    
    return nil;
}

#pragma mark - QMMemeoryStorageProtocol

- (BOOL)isEmpty {
    return self.attachmentsStorage.count == 0;
}

- (void)free {
    
    [self.attachmentsStorage removeAllObjects];
}

- (NSMutableOrderedSet *)dataSourceWithMessageID:(NSString *)messageID {
    
    NSMutableOrderedSet *attachments = self.attachmentsStorage[messageID];
    
    if (!attachments) {
        attachments = [NSMutableOrderedSet orderedSet];
        self.attachmentsStorage[messageID] = attachments;
    }
    
    return attachments;
}

@end
