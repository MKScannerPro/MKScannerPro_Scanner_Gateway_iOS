//
//  MKSPAFilterConditionModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/7/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPAFilterConditionModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

@implementation MKSPAFilterRawAdvDataModel
@end

@implementation MKSPAFilterConditionModel

- (void)updateModelWithJson:(NSDictionary *)json {
    if (!ValidDict(json)) {
        return;
    }
    self.rssiValue = [json[@"rssi"] integerValue];
    self.enableFilterConditions = ([json[@"rule_switch"] integerValue] == 1);
    
    self.macIson = ([json[@"mac"][@"flag"] integerValue] > 0);
    self.macWhiteListIson = ([json[@"mac"][@"flag"] integerValue] == 2);
    self.macValue = json[@"mac"][@"rule"];
    
    self.advNameIson = ([json[@"name"][@"flag"] integerValue] > 0);
    self.advNameWhiteListIson = ([json[@"name"][@"flag"] integerValue] == 2);
    self.advNameValue = json[@"name"][@"rule"];
    
    self.uuidIson = ([json[@"uuid"][@"flag"] integerValue] > 0);
    self.uuidWhiteListIson = ([json[@"uuid"][@"flag"] integerValue] == 2);
    self.uuidValue = json[@"uuid"][@"rule"];
    
    self.majorIson = ([json[@"major"][@"flag"] integerValue] > 0);
    self.majorWhiteListIson = ([json[@"major"][@"flag"] integerValue] == 2);
    self.majorMinValue = [NSString stringWithFormat:@"%ld",(long)[json[@"major"][@"min"] integerValue]];
    self.majorMaxValue = [NSString stringWithFormat:@"%ld",(long)[json[@"major"][@"max"] integerValue]];
    
    self.minorIson = ([json[@"minor"][@"flag"] integerValue] > 0);
    self.minorWhiteListIson = ([json[@"minor"][@"flag"] integerValue] == 2);
    self.minorMinValue = [NSString stringWithFormat:@"%ld",(long)[json[@"minor"][@"min"] integerValue]];
    self.minorMaxValue = [NSString stringWithFormat:@"%ld",(long)[json[@"minor"][@"max"] integerValue]];
    
    self.rawDataIson = ([json[@"raw"][@"flag"] integerValue] > 0);
    self.rawDataWhiteListIson = ([json[@"raw"][@"flag"] integerValue] == 2);
    NSArray *tempList = json[@"raw"][@"rule"];
    NSMutableArray *list = [NSMutableArray array];
    for (NSInteger i = 0; i < tempList.count; i ++) {
        NSDictionary *dataDic = tempList[i];
        NSDictionary *dic = @{
            @"dataType":dataDic[@"type"],
            @"minIndex":[NSString stringWithFormat:@"%ld",(long)[dataDic[@"start"] integerValue]],
            @"maxIndex":[NSString stringWithFormat:@"%ld",(long)[dataDic[@"end"] integerValue]],
            @"rawData":dataDic[@"data"],
            @"index":@(i),
        };
        [list addObject:dic];
    }
    self.rawDataList = list;
}

- (NSDictionary *)filterName {
    mk_spa_filterRules rules = mk_spa_filterRules_off;
    if (self.advNameIson) {
        rules = (self.advNameWhiteListIson ? mk_spa_filterRules_reverse : mk_spa_filterRules_forward);
    }
    return @{
        MKSPAFilterRulesKey:@(rules),
        @"name":SafeStr(self.advNameValue)
    };
}

- (NSDictionary *)filterMacAddress {
    mk_spa_filterRules rules = mk_spa_filterRules_off;
    if (self.macIson) {
        rules = (self.macWhiteListIson ? mk_spa_filterRules_reverse : mk_spa_filterRules_forward);
    }
    return @{
        MKSPAFilterRulesKey:@(rules),
        @"mac":SafeStr(self.macValue)
    };
}

- (NSDictionary *)filterUUID {
    mk_spa_filterRules rules = mk_spa_filterRules_off;
    if (self.uuidIson) {
        rules = (self.uuidWhiteListIson ? mk_spa_filterRules_reverse : mk_spa_filterRules_forward);
    }
    return @{
        MKSPAFilterRulesKey:@(rules),
        @"uuid":SafeStr(self.uuidValue)
    };
}

- (NSDictionary *)filterMajor {
    mk_spa_filterRules rules = mk_spa_filterRules_off;
    if (self.majorIson) {
        rules = (self.majorWhiteListIson ? mk_spa_filterRules_reverse : mk_spa_filterRules_forward);
    }
    return @{
        MKSPAFilterRulesKey:@(rules),
        @"max":@([self.majorMaxValue integerValue]),
        @"min":@([self.majorMinValue integerValue])
    };
}

- (NSDictionary *)filterMinor {
    mk_spa_filterRules rules = mk_spa_filterRules_off;
    if (self.minorIson) {
        rules = (self.minorWhiteListIson ? mk_spa_filterRules_reverse : mk_spa_filterRules_forward);
    }
    return @{
        MKSPAFilterRulesKey:@(rules),
        @"max":@([self.minorMaxValue integerValue]),
        @"min":@([self.minorMinValue integerValue])
    };
}

- (NSDictionary *)filterRawDatas:(NSArray <MKSPAFilterRawAdvDataModel *>*)rawList {
    mk_spa_filterRules rules = mk_spa_filterRules_off;
    if (self.rawDataIson) {
        rules = (self.rawDataWhiteListIson ? mk_spa_filterRules_reverse : mk_spa_filterRules_forward);
    }
    return @{
        MKSPAFilterRulesKey:@(rules),
        @"dataList":rawList,
    };
}

- (NSDictionary *)filterConditions:(NSArray <MKSPAFilterRawAdvDataModel *>*)rawList {
    if (![self validParams:rawList]) {
        return @{
            @"code":@(0),
            @"message":@"Opps！Save failed. Please check the input characters and try again."
        };
    }
    
    NSDictionary *dataDic = @{
        MKSPAFilterConditionsStatusKey:@(self.enableFilterConditions),
        MKSPAFilterByRssiKey:@(self.rssiValue),
        MKSPAFilterByAdvNameKey:[self filterName],
        MKSPAFilterByDeviceMacKey:[self filterMacAddress],
        MKSPAFilterByiBeaconUUIDKey:[self filterUUID],
        MKSPAFilterByiBeaconMajorKey:[self filterMajor],
        MKSPAFilterByiBeaconMinorKey:[self filterMinor],
        MKSPAFilterByRawDataKey:[self filterRawDatas:rawList]
    };
    return @{
        @"code":@(1),
        @"data":dataDic
    };
}

- (BOOL)validParams:(NSArray *)list {
    if (self.macIson) {
        if (self.macValue.length % 2 != 0 || self.macValue.length == 0 || self.macValue.length > 12) {
            return NO;
        }
    }
    if (self.advNameIson) {
        if (!ValidStr(self.advNameValue) || self.advNameValue.length > 10) {
            return NO;
        }
    }
    if (self.uuidIson) {
        if (![self.uuidValue regularExpressions:isHexadecimal] || self.uuidValue.length % 2 != 0) {
            return NO;
        }
    }
    if (self.majorIson) {
        if (!ValidStr(self.majorMaxValue) || [self.majorMaxValue integerValue] < 0 || [self.majorMaxValue integerValue] > 65535) {
            return NO;
        }
        if (!ValidStr(self.majorMinValue) || [self.majorMinValue integerValue] < 0 || [self.majorMinValue integerValue] > 65535) {
            return NO;
        }
        if ([self.majorMaxValue integerValue] < [self.majorMinValue integerValue]) {
            return NO;
        }
    }
    if (self.minorIson) {
        if (!ValidStr(self.minorMaxValue) || [self.minorMaxValue integerValue] < 0 || [self.minorMaxValue integerValue] > 65535) {
            return NO;
        }
        if (!ValidStr(self.minorMinValue) || [self.minorMinValue integerValue] < 0 || [self.minorMinValue integerValue] > 65535) {
            return NO;
        }
        if ([self.minorMaxValue integerValue] < [self.minorMinValue integerValue]) {
            return NO;
        }
    }
    if (self.rawDataIson && !ValidArray(list)) {
        //打开了原始数据过滤
        return NO;
    }
    
    return YES;
}

@end
