//
//  ViewController.m
//  题库Demo
//
//  Created by MaTsonga on 2017/4/17.
//  Copyright © 2017年 MaTsonga. All rights reserved.
//

#import "ViewController.h"
#import "TiKuCell.h"

@interface ViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)TiKuCell * tiKuCell;

@property (strong, nonatomic) NSMutableArray *selectIndexsArray;//多选选中行 数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    _selectIndexsArray = [NSMutableArray array];
    
    [self createTableView];
   
    
}

- (void)createTableView
{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(
                                                                   0,
                                                                   64,
                                                                   self.view.bounds.size.width,
                                                                   self.view.bounds.size.height - 64)
                                                  style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TiKuCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    view.backgroundColor = [UIColor darkGrayColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TiKuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //取消cell的选中效果
    
    cell.selectLabel.text = [NSString stringWithFormat:@"第%zi列,第%zi行",indexPath.section, indexPath.row];
 
    //注 ： 选中和非选中，如果在controller页面中对选中态进行操作，可能会因为复用导致选中态滑动的时候出现问题。
    
       for (NSIndexPath *index in _selectIndexsArray) { //遍历数组中的行 与刷新的行进行判断
    
        if (index == indexPath) {//当前行与数组中的匹配改变选择状态
            
            [cell.selectBtn setImage:[UIImage imageNamed:@"caijiyou_h"] forState:UIControlStateNormal];
            cell.selectBtn.selected = YES;
            break;
        }
        else {
            
            [cell.selectBtn setImage:[UIImage imageNamed:@"caijiyou_n"] forState:UIControlStateNormal];
            cell.selectBtn.selected = NO;
               
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TiKuCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //获取到点击的cell
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //取消cell的选中效果

    if (cell.selectBtn.selected ) { //选中状态 将选中行添加到数组中
        
        [cell.selectBtn setImage:[UIImage imageNamed:@"caijiyou_n"] forState:UIControlStateNormal];
        
        [_selectIndexsArray removeObject:indexPath];
        cell.selectBtn.selected = NO;
        
        NSLog(@"未选中--%ld",_selectIndexsArray.count);
        
    }else { //未选中状态 将选中行从数组中移除
        
        [cell.selectBtn setImage:[UIImage imageNamed:@"caijiyou_h"] forState:UIControlStateNormal];
        
        [_selectIndexsArray addObject:indexPath];
        cell.selectBtn.selected = YES;
        
        NSLog(@"选中--%ld",_selectIndexsArray.count);

    }

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
