

#import "TabBarController.h"
#import "BarButton.h"
#import "Navigation.h"
#import "ViewController.h"

#import "XMGTabBar.h"
#import "UIImage+Image.h"

//#import "MeViewController.h"

#import "UIImage+Common.h"


#import "HomeVC.h"
#import "MeVC.h"

#import "MeetingVC.h"
#import "ContactsVC.h"
#import "RecordVC.h"
#import "ScheduleVC.h"


@interface TabBarController ()<UITabBarControllerDelegate>


//@property (nonatomic ,strong) MidVideo *midVideo;


@end

@implementation TabBarController


// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor myColorWithHexString:@"#404040"];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];

    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrsNor[NSForegroundColorAttributeName] = [UIColor myColorWithHexString:@"#888888"];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    
    // Do any additional setup after loading the view.
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    // 2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    
    // 3.自定义tabBar
    [self setupTabBar];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginedSuccess) name:loginFromMyClassBaseTabbar object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(midVideoBtnClick) name:midBtnClik object:nil];
}

#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    XMGTabBar *tabBar = [[XMGTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    //修改背景颜色 （还可以加view）
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor myColorWithHexString:@"#f9f9f9"]]];
    
    [UITabBar appearance].translucent = NO;
    
}

//- (void)LoginedSuccess{
//
//    [self setSelectedViewController:[self.viewControllers objectAtIndex:1]];
//
//}

//- (void)midVideoBtnClick{
//
//    if ([UserCenter isLogin]) {
//
////        MidVideo *vc = [[MidVideo alloc]init];
////        self.midVideo = vc;
//
//        BOOL isAuthor =  [ImagePickerManger isHaveAlbumAuthorWithFirstAgreeBlock:^{
//
//            [self toMidVideo];
//
//        } rejectAgree:^{
//
//            return;
//        }];
//
//        if (isAuthor) {
//
//            [self toMidVideo];
//        }
//
//
//
//    }else{
//
//        [self ToLoginVCWithFromMyClass:NO];
//    }
//
//}

- (void)toMidVideo{

//    [MidVideo presentPopMidVideoControllerAnimated:YES  completion:^(NSInteger index) {
//
//        NSLog(@"%ld",(long)index);
//
//        if (index == 0) {
//
//            //拍短视频
//            XHFilterVideoVC *vc = [[XHFilterVideoVC alloc]init];
//            Navigation *nav = [[Navigation alloc]initWithRootViewController:vc];
//            [self presentViewController:nav animated:YES completion:^{
//
//            }];
//
//        }else if (index == 1){
//
//            //选择视频
//            myCustomerVideoPickerVC *vc = [[myCustomerVideoPickerVC alloc]init];
//            Navigation *nav = [[Navigation alloc]initWithRootViewController:vc];
//            [self presentViewController:nav animated:YES completion:^{ }];
//
//
//        }
//
//    }];
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
        
//    if(viewController == [tabBarController.viewControllers objectAtIndex:1])
//    {
//        if ([UserCenter isLogin]) {
//            
//            return YES;
//        }else{
//            
//            [self ToLoginVCWithFromMyClass:YES];
//            return NO;
//        }
//    }
    return YES;
}


- (void)ToLoginVCWithFromMyClass:(BOOL)isFrom{

//    LoginViewController *VC = [[LoginViewController alloc] init];
//    VC.isComeFromeBaseTabbar = isFrom;
//    Navigation *nav = [[Navigation alloc]initWithRootViewController:VC];
//
//    [self presentViewController:nav animated:YES completion:nil];

    
}

/*
 Changing the delegate of a tab bar 【managed by a tab bar controller】 is not allowed.
 被UITabBarController所管理的UITabBar的delegate是不允许修改的
 */

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{

    //
//    HomeVC *newVc = [[HomeVC alloc] init];
//    Navigation *nav = [[Navigation alloc] initWithRootViewController:newVc];
//    [self addChildViewController:nav];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MeetingVC *vc = [storyBoard instantiateViewControllerWithIdentifier:@"MeetingVC"];
    Navigation *nav = [[Navigation alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    
        RecordVC *record = [[RecordVC alloc] init];
        Navigation *nav1 = [[Navigation alloc] initWithRootViewController:record];
        [self addChildViewController:nav1];
    
    
        ContactsVC *contacts = [[ContactsVC alloc] init];
        Navigation *nav2 = [[Navigation alloc] initWithRootViewController:contacts];
        [self addChildViewController:nav2];
    
    
        ScheduleVC *schedule = [[ScheduleVC alloc] init];
        Navigation *nav3 = [[Navigation alloc] initWithRootViewController:schedule];
        [self addChildViewController:nav3];
    
    
        MeVC *meVc = [[MeVC alloc] init];
        Navigation *nav4 = [[Navigation alloc] initWithRootViewController:meVc];
        [self addChildViewController:nav4];

    // 我

    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"MeVC_ID"];
//    Navigation *nav4 = [[Navigation alloc] initWithRootViewController:vc];
//    [self addChildViewController:nav4];
}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton
{
    
    // 0:nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"会议";
    nav.tabBarItem.image = [UIImage imageOriginalWithName:@"日历2"];
    // 快速生成一个没有渲染图片
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"日历1"];
    
    
    // 4.我
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"通话";
    nav1.tabBarItem.image = [UIImage imageOriginalWithName:@"我的2"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"我的1"];
    
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"联系人";
    nav2.tabBarItem.image = [UIImage imageOriginalWithName:@"我的2"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"我的1"];
    
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"日程";
    nav3.tabBarItem.image = [UIImage imageOriginalWithName:@"我的2"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"我的1"];
    
    UINavigationController *nav4 = self.childViewControllers[4];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageOriginalWithName:@"我的2"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"我的1"];
}


//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//
//    for (UIView *view in self.view.subviews) {
//        if ([view isKindOfClass:[UITabBar class]]) {
//            //此处注意设置 y的值 不要使用屏幕高度 - 49 ，因为还有tabbar的高度 ，用当前tabbarController的View的高度 - 49即可
//            view.frame = CGRectMake(view.frame.origin.x, self.view.bounds.size.height-49, view.frame.size.width, 49);
//        }
//    }
//    // 此处是自定义的View的设置 如果使用了约束 可以不需要设置下面,_bottomView的frame
////    _bottomView.frame = self.tabBar.bounds;
//}

@end
