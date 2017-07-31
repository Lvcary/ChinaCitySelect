//
//  ChinaCitySelectView.m
//  ChinaCitySelect
//
//  Created by 刘康蕤 on 2017/7/31.
//  Copyright © 2017年 lkr. All rights reserved.
//

#import "ChinaCitySelectView.h"



@interface ChinaCitySelectView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView * pickView;

// 省份数组
@property (nonatomic, strong) NSMutableArray * provinceArray;
// 选择哪个省份
@property (nonatomic, assign) NSInteger proinceIndex;
// 省份id 和 name
@property (nonatomic, strong) NSDictionary * proinceDictionary;


// 城市数组
@property (nonatomic, strong) NSMutableArray * cityArray;
// 选择哪个城市
@property (nonatomic, assign) NSInteger cityIndex;
// 城市id 和 name
@property (nonatomic, strong) NSDictionary * cityDictionary;


// 地区数组
@property (nonatomic, strong) NSMutableArray * regionArray;
// 选择哪个地区
@property (nonatomic, assign) NSInteger regionIndex;
// 地区id 和 name
@property (nonatomic, strong) NSDictionary * regionDictionary;

@end

@implementation ChinaCitySelectView

- (id)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
        _pickView.dataSource = self;
        _pickView.delegate = self;
        [self addSubview:_pickView];
        
        [self initSource];
        
    }
    return self;
}

#pragma mark /***** setter ******/
- (NSMutableArray *)dataSource {
    if (!_provinceArray) {
        _provinceArray = [[NSMutableArray alloc] init];
    }
    return _provinceArray;
}

#pragma mark /***** dataSource *****/
- (void)initSource {
    
    _proinceIndex = 0;
    _cityIndex = 0;
    _regionIndex = 0;
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"address"
                                                          ofType:@"plist"];
    NSArray * array  = [NSArray arrayWithContentsOfFile:filePath];
    
    NSLog(@"arrar = %@",array);
    _provinceArray = [NSMutableArray arrayWithArray:array];
    _cityArray = [NSMutableArray arrayWithArray:[[_provinceArray objectAtIndex:_proinceIndex] objectForKey:@"cityList"]];
    _regionArray = [NSMutableArray arrayWithArray:[[_cityArray objectAtIndex:_cityIndex] objectForKey:@"regionList"]];
    
    // 设置最初的城市
    _proinceDictionary = @{@"provinceId":[_provinceArray[_proinceIndex] objectForKey:@"provinceId"],@"provinceName":[_provinceArray[_proinceIndex] objectForKey:@"provinceName"]};
    _cityDictionary = @{@"cityId":[_cityArray[_cityIndex] objectForKey:@"cityId"],@"cityName":[_cityArray[_cityIndex] objectForKey:@"cityName"]};
    _regionDictionary = @{@"regionId":[_regionArray[_regionIndex] objectForKey:@"regionId"],@"regionName":[_regionArray[_regionIndex] objectForKey:@"regionName"]};
    
    [_pickView reloadAllComponents];
    
}


#pragma mark /****picker DelegateAndDataSource ****/
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
        {
            return _provinceArray.count;
        }
            break;
        case 1:
        {
            return _cityArray.count;
        }
            break;
        case 2:
        {
            return _regionArray.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}


/*
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
        {
            return [_provinceArray[row] objectForKey:@"provinceName"];
        }
            break;
        case 1:
        {
            return [_cityArray[row] objectForKey:@"cityName"];
        }
            break;
        case 2:
        {
            return [_regionArray[row] objectForKey:@"regionName"];
        }
            break;
            
        default:
            return @"";
            break;
    }
    return @"";
}
 */


// 自定义文字空间大小，修改文字字体
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 44)];
    myView.font = [UIFont systemFontOfSize:15];
    myView.textAlignment = NSTextAlignmentCenter;
    
    switch (component) {
        case 0:
        {
            myView.text = [_provinceArray[row] objectForKey:@"provinceName"];
        }
            break;
        case 1:
        {
            myView.text = [_cityArray[row] objectForKey:@"cityName"];
        }
            break;
        case 2:
        {
            myView.text = [_regionArray[row] objectForKey:@"regionName"];
        }
            break;
            
        default:
            myView.text = @"";
            break;
    }
    
    return myView;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    switch (component) {
        case 0:
        {
            _proinceIndex = row;
            _cityIndex = 0;
            _regionIndex = 0;
            self.cityArray = [_provinceArray[_proinceIndex] objectForKey:@"cityList"];
            self.regionArray = [_cityArray[_cityIndex] objectForKey:@"regionList"];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            
            _proinceDictionary = @{@"provinceId":[_provinceArray[_proinceIndex] objectForKey:@"provinceId"],@"provinceName":[_provinceArray[_proinceIndex] objectForKey:@"provinceName"]};
            _cityDictionary = @{@"cityId":[_cityArray[_cityIndex] objectForKey:@"cityId"],@"cityName":[_cityArray[_cityIndex] objectForKey:@"cityName"]};
            _regionDictionary = @{@"regionId":[_regionArray[_regionIndex] objectForKey:@"regionId"],@"regionName":[_regionArray[_regionIndex] objectForKey:@"regionName"]};
            
        }
            break;
        case 1:
        {
            _cityIndex = row;
            _regionIndex = 0;
            self.regionArray = [_cityArray[_cityIndex] objectForKey:@"regionList"];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            
            _cityDictionary = @{@"cityId":[_cityArray[_cityIndex] objectForKey:@"cityId"],@"cityName":[_cityArray[_cityIndex] objectForKey:@"cityName"]};
            _regionDictionary = @{@"regionId":[_regionArray[_regionIndex] objectForKey:@"regionId"],@"regionName":[_regionArray[_regionIndex] objectForKey:@"regionName"]};
        }
            break;
        case 2:
        {
            _regionIndex = row;
            _regionDictionary = @{@"regionId":[_regionArray[_regionIndex] objectForKey:@"regionId"],@"regionName":[_regionArray[_regionIndex] objectForKey:@"regionName"]};
        }
            break;
            
        default:
            break;
    }
    NSLog(@"--------------------------------");
    NSLog(@"省份：%@",[_proinceDictionary objectForKey:@"provinceName"]);
    NSLog(@"城市：%@",[_cityDictionary objectForKey:@"cityName"]);
    NSLog(@"地区：%@",[_regionDictionary objectForKey:@"regionName"]);
}



@end
