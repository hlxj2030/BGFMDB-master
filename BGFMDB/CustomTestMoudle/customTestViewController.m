//
//  customTestViewController.m
//  BGFMDB
//
//  Created by 浩霖 on 2018/5/22.
//  Copyright © 2018年 Biao. All rights reserved.
//


#import "customTestViewController.h"
#import "TestPeople.h"
@interface customTestViewController ()

@property (nonatomic) NSInteger currentInt;

@property (weak, nonatomic) IBOutlet UISwitch *intoType;

@property (weak, nonatomic) IBOutlet UITextField *searchNumLable;
@property (weak, nonatomic) IBOutlet UITextField *changeName;
@property (weak, nonatomic) IBOutlet UITextField *deleltIndexLabel;
@property (nonatomic, strong) TestPeopleModel *currentPeople;
@property (nonatomic, copy) NSString *tableStr;

@end

@implementation customTestViewController

- (void)dealloc{
    [[NSUserDefaults standardUserDefaults] setObject:@(self.currentInt) forKey:@"currentNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentInt = 0;
    NSNumber *oldNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentNum"];
    self.currentInt = [oldNum integerValue];
}


- (IBAction)changeListData:(id)sender {
    
    if (self.intoType.isOn) {
        self.tableStr = @"testPeople";
    }else{
        self.tableStr = nil;
    }
    NSLog(@"当前数据库表明%@",self.tableStr ? : @"");
    
}

- (NSString *)dogName{
    
    int currentIndex = arc4random() % 6;
    return [@[@"小号",@"小黑",@"小心",@"小虎",@"小花",@"小丑"] objectAtIndex:currentIndex];
    
}

- (NSString *)userName{
    
    int currentIndex = arc4random() % 7;
    return [@[@"张三",@"李四",@"王五",@"王麻子",@"小春",@"李逵",@"无锡"] objectAtIndex:currentIndex];

}

- (TestPeopleModel *)getPeople{
    
    TestPeopleModel *people = [TestPeopleModel new];
    people.name = [self userName];
    people.age = @(self.currentInt + 10);
    people.userID = self.currentInt;
    people.AddStr = @"测试地址啊哈哈";
    NSLog(@"新建用户ID为%ld",(long)self.currentInt);
    DogModle *dogOne = [DogModle bg_objectWithKeyValues:@{@"dogName":[self dogName],@"dogNum":[NSString stringWithFormat:@"狗带%d",self.currentInt+1]}];
    DogModle *dogTwo = [DogModle bg_objectWithKeyValues:@{@"dogName":[self dogName],@"dogNum":[NSString stringWithFormat:@"狗带%ld",(self.currentInt+1)]}];
    if (self.tableStr != nil && self.tableStr.length > 0) {
        people.bg_tableName = self.tableStr;
    }
    self.currentInt ++;
    people.dogs = @[dogOne,dogTwo];
    return people;

}

#pragma mark -  **************************基本操作 ********************
- (IBAction)intoData:(id)sender {
    
    TestPeopleModel *people = [self getPeople];

    [people bg_save];

    NSArray *totelNumArr = [TestPeopleModel bg_findAll:self.tableStr];
    NSLog(@"当前类名库数据个数为%ld",(long)totelNumArr.count);
    for(TestPeopleModel* currentPeople in totelNumArr){
        NSLog(@"主键 = %@, 表名 = %@, 创建时间 = %@, 更新时间 = %@, 用户名 = %@,用户ID = %ld,用户年龄 = %@,用户地址 = %@",currentPeople.bg_id,currentPeople.bg_tableName,currentPeople.bg_createTime,currentPeople.bg_updateTime,currentPeople.name,(long)currentPeople.userID,currentPeople.age,currentPeople.AddStr);
    }
    

    
}

- (IBAction)findData:(id)sender {

    NSArray *totelNumArr = [TestPeopleModel bg_findAll:self.tableStr];
    NSLog(@"当前类名库数据个数为%ld",(long)totelNumArr.count);
    NSInteger searchIndex = 0;
    if (self.searchNumLable.text.length != 0) {
        searchIndex = [self.searchNumLable.text integerValue];
    }
    TestPeopleModel *currentPeople = [TestPeopleModel bg_object:self.tableStr row:searchIndex];
    NSLog(@"主键 = %@, 表名 = %@, 创建时间 = %@, 更新时间 = %@, 用户名 = %@,用户ID = %ld,用户年龄 = %@,用户地址 = %@",currentPeople.bg_id,currentPeople.bg_tableName,currentPeople.bg_createTime,currentPeople.bg_updateTime,currentPeople.name,(long)currentPeople.userID,currentPeople.age,currentPeople.AddStr);
    self.currentPeople = currentPeople;

}


- (IBAction)modificationData:(id)sender {
    
    NSInteger searchIndex = 0;
    if (self.changeName.text.length != 0) {
        searchIndex = [self.changeName.text integerValue];
    }
    TestPeopleModel *currentPeople = [TestPeopleModel bg_object:self.tableStr row:searchIndex];
    NSLog(@"主键 = %@, 表名 = %@, 创建时间 = %@, 更新时间 = %@, 用户名 = %@,用户ID = %ld,用户年龄 = %@,用户地址 = %@",currentPeople.bg_id,currentPeople.bg_tableName,currentPeople.bg_createTime,currentPeople.bg_updateTime,currentPeople.name,(long)currentPeople.userID,currentPeople.age,currentPeople.AddStr);
    currentPeople.name = [NSString stringWithFormat:@"测试AA"];
    [currentPeople bg_saveOrUpdate];
    TestPeopleModel *netPeople = [TestPeopleModel bg_object:self.tableStr row:searchIndex];
    NSLog(@"主键 = %@, 表名 = %@, 创建时间 = %@, 更新时间 = %@, 用户名 = %@,用户ID = %ld,用户年龄 = %@,用户地址 = %@",netPeople.bg_id,netPeople.bg_tableName,netPeople.bg_createTime,netPeople.bg_updateTime,netPeople.name,(long)netPeople.userID,netPeople.age,currentPeople.AddStr);
}


- (IBAction)deleData:(id)sender {
    
    NSArray *totelNumArr = [TestPeopleModel bg_findAll:self.tableStr];
    NSLog(@"当前类名库数据个数为%ld",(long)totelNumArr.count);
    NSInteger searchIndex = 1;
    if (self.deleltIndexLabel.text.length != 0) {
        searchIndex = [self.deleltIndexLabel.text integerValue];
    }
    [TestPeopleModel bg_delete:self.tableStr row:searchIndex];

    NSArray *newtotelNumArr = [TestPeopleModel bg_findAll:self.tableStr];
    NSLog(@"当前类名库数据个数为%ld",(long)newtotelNumArr.count);
    

}

- (IBAction)coverInto:(id)sender {
    
    if (self.currentPeople) {
        self.currentPeople.name = @"已经覆盖了";
        self.currentPeople.age = @23;
        [self.currentPeople bg_cover];
    }
    
    NSArray *newtotelNumArr = [TestPeopleModel bg_findAll:self.tableStr];
    NSLog(@"当前类名库数据个数为%ld",(long)newtotelNumArr.count);
    
    
}


- (IBAction)coverSearch:(id)sender {
    
       NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"name"),bg_sqlValue(@"张三")];
        NSArray* arr = [TestPeopleModel bg_find:self.tableStr where:where];
    for(TestPeopleModel* pp in arr){
        NSLog(@"主键 = %@, 表名 = %@, 创建时间 = %@, 更新时间 = %@, 用户名 = %@,用户ID = %ld,用户年龄 = %@,用户地址 = %@",pp.bg_id,pp.bg_tableName,pp.bg_createTime,pp.bg_updateTime,pp.name,(long)pp.userID,pp.age,pp.AddStr);
    }
    
}


- (IBAction)updateVerSionNum:(id)sender {
    
    NSInteger version = [TestPeopleModel bg_version:self.tableStr];
    NSLog(@"当前数据库版本号%ld",(long)version);
    [TestPeopleModel bg_update:self.tableStr version:version + 1];
    NSInteger versionOne = [TestPeopleModel bg_version:self.tableStr];
    NSLog(@"升级后的版本号数据库版本号%ld",(long)versionOne);
    
}

- (IBAction)findAll:(id)sender {
    
    NSArray *totelNumArr = [TestPeopleModel bg_findAll:self.tableStr];
    NSLog(@"当前类名库数据个数为%ld",(long)totelNumArr.count);
    for(TestPeopleModel* currentPeople in totelNumArr){
        NSLog(@"主键 = %@, 表名 = %@, 创建时间 = %@, 更新时间 = %@, 用户名 = %@,用户ID = %ld,用户年龄 = %@,用户地址 = %@",currentPeople.bg_id,currentPeople.bg_tableName,currentPeople.bg_createTime,currentPeople.bg_updateTime,currentPeople.name,(long)currentPeople.userID,currentPeople.age,currentPeople.AddStr);
    }
    
}


- (IBAction)clearData:(id)sender {
    [TestPeopleModel bg_clear:self.tableStr];
}

- (IBAction)dataAtransport:(id)sender {
    
    [TestPeopleModel bg_copy:nil toTable:self.tableStr keyDict:@{@"name":@"name",@"age":@"age",@"userID":@"userID",@"AddStr":@"AddStr"} append:YES];
    
    
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
