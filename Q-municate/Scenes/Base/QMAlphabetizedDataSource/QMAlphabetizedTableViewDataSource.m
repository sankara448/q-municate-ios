//
//  QMAlphabetizedDataSource.m
//  Q-municate
//
//  Created by Injoit on 3/19/16.
//  Copyright © 2016 QuickBlox. All rights reserved.
//

#import "QMAlphabetizedTableViewDataSource.h"
#import "QMAlphabetizer.h"

@interface QMAlphabetizedTableViewDataSource ()

@property (copy, nonatomic) NSString *keyPath;

@property (strong, nonatomic) NSDictionary *alphabetizedDictionary;
@property (strong, nonatomic) NSArray *sectionIndexTitles;

@end

@implementation QMAlphabetizedTableViewDataSource

//MARK: - Construction

- (instancetype)initWithKeyPath:(NSString *)keyPath {
    
    self = [super init];
    if (self) {
        
        _keyPath = [keyPath copy];
    }
    
    return self;
}

- (instancetype)initWithSearchDataProvider:(QMSearchDataProvider *)searchDataProvider usingKeyPath:(NSString *)keyPath {
    
    self = [super initWithSearchDataProvider:searchDataProvider];
    if (self) {
        
        _keyPath = [keyPath copy];
    }
    
    return self;
}

//MARK: - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.isEmpty ? @"" : self.sectionIndexTitles[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.isEmpty ? 1 : self.sectionIndexTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isEmpty) {
        
        return 1;
    }
    
    NSString *sectionKey = self.sectionIndexTitles[section];
    NSArray *itemsForSection = self.alphabetizedDictionary[sectionKey];
    
    return itemsForSection.count;
}

//MARK: - methods

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *sectionIndexTitle = self.sectionIndexTitles[indexPath.section];
    return self.alphabetizedDictionary[sectionIndexTitle][indexPath.row];
}

- (NSIndexPath *)indexPathForObject:(id)object {
    NSArray *keys = self.sectionIndexTitles;
    for (NSUInteger i = 0; i < keys.count; i++) {
        NSUInteger idx = [self.alphabetizedDictionary[keys[i]] indexOfObject:object];
        if (idx != NSNotFound) {
            return [NSIndexPath indexPathForRow:idx inSection:i];
        }
    }
    return nil;
}

//MARK: - getters

- (BOOL)isEmpty {
    
    return self.sectionIndexTitles.count == 0;
}

//MARK: - setters

- (void)addItems:(NSArray *)items {
    
    [self replaceItems:items];
}

- (void)replaceItems:(NSArray *)items {
    NSAssert(self.keyPath != nil, @"Keypath must not be nil!");
    
    self.alphabetizedDictionary = [QMAlphabetizer alphabetizedDictionaryFromObjects:items usingKeyPath:self.keyPath];
    self.sectionIndexTitles = [QMAlphabetizer indexTitlesFromAlphabetizedDictionary:self.alphabetizedDictionary];
}

- (void)setItems:(NSMutableArray *)items {
    
    [self replaceItems:[items copy]];
}

- (NSMutableArray *)items {
    
    return [self.alphabetizedDictionary.allValues mutableCopy];
}

@end
