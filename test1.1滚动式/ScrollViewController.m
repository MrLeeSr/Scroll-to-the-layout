//
//  ScrollViewController.m
//  test1.1滚动式
//
//  Created by qf on 15/10/8.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView * scrollView;
@property (nonatomic , strong) UIImageView * imageView;
@property (nonatomic , strong) UIScrollView * topScrollView;
@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建scrollView
    [self createScrollView];
    
    //创建按钮条
    [self createBar];
}

//创建scrollview将子视图控制器的视图添加到Scrollview上面
- (void)createScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.scrollView];
    
    //    设置contentSize
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.viewControllers.count, self.view.bounds.size.height);
    for (int i = 0; i<self.viewControllers.count; i++) {
        //修改VC坐标
        UIViewController * vc = self.viewControllers[i];
        vc.view.frame = CGRectMake(i*self.view.bounds.size.width, 70, self.view.bounds.size.width, self.view.bounds.size.height-70);
        [self.scrollView addSubview:vc.view];
    }
    
    //设置滚动视图属性
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
}

//创建按钮条
- (void)createBar{
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 40)];
    self.topScrollView.backgroundColor = [UIColor grayColor];
    self.topScrollView.contentSize = CGSizeMake(self.viewControllers.count * self.view.bounds.size.width/3.0 , 40);
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.bounces = NO;
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.view.bounds.size.width/3.0 * i, 0, self.view.bounds.size.width/3.0, 38);
        [button setTitle:[NSString stringWithFormat:@"测试%d",i+1] forState:UIControlStateNormal];
        button.tag = i + 100;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:button];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, self.view.bounds.size.width/3.0, 2)];
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self.topScrollView addSubview:self.imageView];
    [self.view addSubview:self.topScrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int a =  scrollView.contentOffset.x / self.view.bounds.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.frame = CGRectMake(self.view.bounds.size.width/3.0 * a, 38, self.view.bounds.size.width/3.0, 2);
    }];
    [self.topScrollView scrollRectToVisible:CGRectMake((self.view.bounds.size.width/3.0) * (scrollView.contentOffset.x / self.view.bounds.size.width)-(self.view.bounds.size.width/3.0) ,0, self.view.bounds.size.width, 40) animated:YES];
}

- (void)buttonClick:(UIButton *)button{
    self.scrollView.contentOffset = CGPointMake((button.tag - 100) * self.view.bounds.size.width, 0);
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.frame = CGRectMake(self.view.bounds.size.width/3.0 * (button.tag - 100), 38, self.view.bounds.size.width/3.0, 2);
    }];
    [self.topScrollView scrollRectToVisible:CGRectMake((self.view.bounds.size.width/3.0) *(self.scrollView.contentOffset.x / 320)-(self.view.bounds.size.width/3.0) ,0, self.view.bounds.size.width, 40) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
