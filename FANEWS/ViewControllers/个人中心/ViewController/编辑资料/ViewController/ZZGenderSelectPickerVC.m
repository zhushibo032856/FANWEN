//
//  ZZGenderSelectPickerVC.m
//  FANEWS
//
//  Created by fanews on 2022/4/6.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZGenderSelectPickerVC.h"

@interface ZZGenderSelectPickerVC ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray *_titleArray;
    NSString *_gender;
}

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ZZGenderSelectPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPickerView];
}

- (void)initPickerView{
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    _gender = @"男";
    _titleArray = [NSArray arrayWithObjects:@"男",@"女", nil];
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureAction:(UIButton *)sender {
    _block(_gender);
    [self dismissViewControllerAnimated:YES completion:nil];
}


//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  2;
}

//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30.0f;
    
}

//返回指定列的宽度

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return  50;
    
}

//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    NSString *str = [_titleArray objectAtIndex:row];

    return str;

}

//选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _gender = [_titleArray objectAtIndex:row];
}

@end
