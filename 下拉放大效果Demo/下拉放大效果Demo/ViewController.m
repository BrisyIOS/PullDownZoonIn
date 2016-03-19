//
//  ViewController.m
//  下拉放大效果Demo
//
//  Created by zhangxu on 16/3/19.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kImageViewH 380
#define kImageViewTop 200

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *array;

@end

@implementation ViewController


// 懒加载
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)setData{
    
    for (int i = 0; i < 20; i++) {
        NSString *name = [NSString stringWithFormat:@"李 %d 正在看报纸",i];
        [self.array addObject:name];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor blueColor];
    self.tableView.contentInset = UIEdgeInsetsMake(kImageViewTop, 0, 0, 0);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageViewH, kScreenWidth, kImageViewH)];
    self.imageView.image = [UIImage imageNamed:@"1.jpg"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:self.imageView atIndex:0];
    
    
    [self setData];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}


#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat spacing = -kImageViewTop - scrollView.contentOffset.y;
    if (spacing < 0) {
        spacing = 0;
    }else{
        self.imageView.height = spacing + kImageViewH;
        self.imageView.y = -self.imageView.height;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
