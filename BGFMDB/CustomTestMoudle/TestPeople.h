//
//  TestPeople.h
//  BGFMDB
//
//  Created by 浩霖 on 2018/5/22.
//  Copyright © 2018年 Biao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h" //添加该头文件,本类就具有了存储功能.



@interface DogModle : NSObject

@property (nonatomic, copy) NSString *dogName;
@property (nonatomic) NSInteger  dogNum;




@end


@interface TestPeopleModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic ) NSInteger userID;
@property (nonatomic, strong) NSArray * dogs;
@property (nonatomic, copy) NSString *AddStr;



@end
