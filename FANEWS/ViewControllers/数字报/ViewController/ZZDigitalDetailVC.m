//
//  ZZDigitalDetailVC.m
//  FANEWS
//
//  Created by fanews on 2022/3/30.
//  Copyright © 2022 Fanews. All rights reserved.
//

#import "ZZDigitalDetailVC.h"

@interface ZZDigitalDetailVC ()<ChartViewDelegate, IChartAxisValueFormatter,IChartValueFormatter>

@property (nonatomic, strong) RadarChartView *chartView;
@property (nonatomic, strong) NSArray<NSString *> *activities;

@property (nonatomic, strong) NSArray<NSString *> *dataArr;
@end

@implementation ZZDigitalDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.activities = @[@"Burger", @"Steak", @"Salad", @"Pasta", @"Pizza" ];
    self.dataArr = @[@"30",@"40",@"66",@"87",@"4"];
    self.title = @"Radar Chart";
    
    _chartView = [[RadarChartView alloc]init];
    [self.view addSubview:self.chartView];
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 400));
    }];
    _chartView.delegate = self;
    _chartView.rotationEnabled = NO;//是否允许转动
    _chartView.highlightPerTapEnabled = YES;//是否能被选中
    _chartView.chartDescription.enabled = YES;
    _chartView.webLineWidth = 1.0;//主干线线宽
    _chartView.innerWebLineWidth = 1.0;//边线宽度
    _chartView.webColor = UIColor.redColor;
    _chartView.innerWebColor = UIColor.cyanColor;
    _chartView.webAlpha = 1.0;//透明度
    
//    RadarMarkerView *marker = (RadarMarkerView *)[RadarMarkerView viewFromXibIn:[NSBundle mainBundle]];
//    marker.chartView = _chartView;
//    _chartView.marker = marker;
    
    //设置X轴label样式
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    xAxis.xOffset = 0.0;
    xAxis.yOffset = 0.0;
    xAxis.valueFormatter = self;
    xAxis.labelTextColor = UIColor.blackColor;
    
    //设置y轴label样式
    ChartYAxis *yAxis = _chartView.yAxis;
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:9.f];
    yAxis.labelCount = 5;//label 个数
    yAxis.axisMinimum = 0.0;//最小值
    yAxis.axisMaximum = 80.0;//最大值
    yAxis.drawLabelsEnabled = NO;//是否显示 label
    yAxis.labelTextColor = [UIColor lightGrayColor];// label 颜色
    
    //数据标签
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;//图形自动充满
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.f];
    l.xEntrySpace = 12.0;
    l.yEntrySpace = 12.0;
    l.textColor = UIColor.orangeColor;
    
    [self updateChartData];//设置数据
    
    [_chartView animateWithXAxisDuration:1.4 yAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateChartData
{
    
  //  _chartView.data = nil;
    
    [self setChartData];
}

- (void)setChartData
{
    double mult = 80;
    double min = 20;
    NSInteger cnt = self.activities.count;//维度的个数
    
    NSMutableArray *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray *entries2 = [[NSMutableArray alloc] init];
    
    // NOTE: The order of the entries when being added to the entries array determines their position around the center of the chart.
    //每个维度的数值
    for (int i = 0; i < cnt; i++)
    {
        [entries1 addObject:[[RadarChartDataEntry alloc] initWithValue:[self.dataArr[i] doubleValue]]];
        [entries2 addObject:[[RadarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + min)]];
    }
    
    RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithEntries:entries1 label:@"Last Week"];
    [set1 setColor:kColor(153, 7, 176)];//数据折线颜色，标签颜色
    set1.fillColor = kColor(22, 145, 34);//填充颜色
    set1.drawFilledEnabled = YES;//是否填充颜色
    set1.fillAlpha = 0.7;//填充透明度
    set1.lineWidth = 2.0;
    set1.drawHighlightCircleEnabled = YES;
    [set1 setDrawHighlightIndicators:NO];

    RadarChartDataSet *set2 = [[RadarChartDataSet alloc] initWithEntries:entries2 label:@"This Week"];
    [set2 setColor:kColor(34, 153, 53)];//数据折线颜色，标签颜色
    set2.fillColor = kColor(122, 145, 4);//填充颜色
    set2.drawFilledEnabled = YES;//是否填充颜色
    set2.fillAlpha = 0.7;//填充透明度
    set2.lineWidth = 2.0;
    set2.drawHighlightCircleEnabled = YES;
    [set2 setDrawHighlightIndicators:NO];
    
    RadarChartData *data = [[RadarChartData alloc] initWithDataSets:@[set1,set2]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.f]];//数值字体
    [data setDrawValues:NO];//显示数值
    data.valueTextColor = UIColor.greenColor;//数值字体颜色
    
    _chartView.data = data;
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleXLabels"])
    {
        _chartView.xAxis.drawLabelsEnabled = !_chartView.xAxis.isDrawLabelsEnabled;
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleYLabels"])
    {
        _chartView.yAxis.drawLabelsEnabled = !_chartView.yAxis.isDrawLabelsEnabled;
        [_chartView setNeedsDisplay];
        return;
    }

    if ([key isEqualToString:@"toggleRotate"])
    {
        _chartView.rotationEnabled = !_chartView.isRotationEnabled;
        return;
    }
    
    if ([key isEqualToString:@"toggleFill"])
    {
        for (RadarChartDataSet *set in _chartView.data.dataSets)
        {
            set.drawFilledEnabled = !set.isDrawFilledEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleHighlightCircle"])
    {
        for (RadarChartDataSet *set in _chartView.data.dataSets)
        {
            set.drawHighlightCircleEnabled = !set.drawHighlightCircleEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"animateX"])
    {
        [_chartView animateWithXAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"animateY"])
    {
        [_chartView animateWithYAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"animateXY"])
    {
        [_chartView animateWithXAxisDuration:1.4 yAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"spin"])
    {
        [_chartView spinWithDuration:2.0 fromAngle:_chartView.rotationAngle toAngle:_chartView.rotationAngle + 360.f easingOption:ChartEasingOptionEaseInCubic];
        return;
    }

}



#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    
    for (int i = 0; i < self.dataArr.count; i ++) {
        if (entry.y == [self.dataArr[i] doubleValue]) {
            NSLog(@"%d",i);
        }
    }
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

#pragma mark - IAxisValueFormatter

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    return self.activities[(int) value % self.activities.count];
}




@end
