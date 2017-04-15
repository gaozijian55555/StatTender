//
//  STResourceDataManager.m
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STResourceDataManager.h"

@implementation STResourceDataManager

+ (NSMutableArray<STBaseItem *> *)fetchSourceData
{
    static NSUInteger errorCount = 0;
    static NSUInteger rightCount = 0;
    
    // 数据源数据 plist
    NSString *soursePath = [[NSBundle mainBundle] pathForResource:@"Tender2016" ofType:@"plist"];
    // 数据源承载数组
    NSMutableArray<STBaseItem *> *arrayAll = [NSMutableArray array];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:soursePath];
    
    NSString *string = [dict objectForKey:@"data_string"];
    
    NSArray *arrayAllRow = [string componentsSeparatedByString:@"\n"];
    
    for (NSString *eachRow in arrayAllRow) {
        NSArray *temArray = [eachRow componentsSeparatedByString:@"\t"];
        if (temArray.count < 6) {
            errorCount ++;
            continue;
        }
        STBaseItem *item = [[STBaseItem alloc] init];
        item.index =    temArray[0];
        item.name =     temArray[1];
        item.factory =  temArray[2];
        item.model =    temArray[3];
        item.unit =     temArray[4];
        item.price =    temArray[5];
        item.tip =      temArray.count == 7 ?temArray[6]:@"";
        [arrayAll addObject:item];
        rightCount ++;
    }
    NSLog(@"Data loading over, errorCount: %lu , all data count: %lu", errorCount, rightCount);

    return arrayAll;
}

+ (NSArray<NSString *> *)fetchFactoryNames
{
    return @[@"后英公司", @"中档一厂", @"中档二厂", @"中档三厂", @"中档四厂", @"高纯厂", @"水泉高新", @"水泉滑石矿", @"计划部", @"海英采矿", @"海英公司", @"海镁车队", @"三江源物业", @"三江源工地", @"三江源", @"大屯工地", @"铲车队", @"红达机械", @"后英车队", @"智胜", @"电熔美", @"安保部", @"特新一厂", @"特新二厂", @"高铁耐仲", @"四厂", @"五厂", @"六厂", @"七厂", @"后英第一城物业", @"房屋开发", @"生物工程", @"重烧一厂", @"重烧二厂", @"重烧三厂", @"公司化验室", @"热力", @"建材厂", @"搅拌站", @"大屯物业", @"三江源回迁楼", @"设备部", @"龙兴产业", @"质计部"];
}


@end
