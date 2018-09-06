//
//  MoneyConsVC.m
//  new_YundiPiano_student
//
//  Created by Apple on 2018/5/28.
//  Copyright © 2018年 chen. All rights reserved.
//

#import "MoneyConsVC.h"

@interface MoneyConsVC ()

@property (weak, nonatomic) IBOutlet UIButton *AliSelectBtn;

@property (weak, nonatomic) IBOutlet UIButton *WXSelectBtn;


@property (weak, nonatomic) IBOutlet UIButton *moneyBtn0;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn1;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn2;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn3;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn4;

@property (weak, nonatomic) IBOutlet UIButton *otherBtn;

@property (nonatomic,strong) NSArray *btnArray;



@end

@implementation MoneyConsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.moneyBtn0 setBackgroundImage:[UIImage resizableImageWithName:@"hotBtn"] forState:UIControlStateNormal];
    
    self.btnArray = @[self.moneyBtn0,self.moneyBtn1,self.moneyBtn2,self.moneyBtn3,self.moneyBtn4];

    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",@"1000元"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0]}];
    
    NSAttributedString *time = [[NSAttributedString alloc] initWithString:@"充1000送200" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor colorWithRed:231/255.0 green:31/255.0 blue:51/255.0 alpha:1.0]}];
    
    [title appendAttributedString:time];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:2];
    paraStyle.alignment = NSTextAlignmentCenter;
    [title addAttributes:@{NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, title.length)];
    
    [self.moneyBtn0 setAttributedTitle:title forState:UIControlStateNormal];
}

- (IBAction)btn0:(UIButton *)sender {
    
    for (int i = 0; i < self.btnArray.count; i++) {
        
        UIButton *btn = self.btnArray[i];
        

        
        
        if (btn.tag == sender.tag) {
            
            if (btn.tag == 0) {
                
                
                NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",@"1000元"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
                
                NSAttributedString *time = [[NSAttributedString alloc] initWithString:@"充1000送200" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor whiteColor]}];
                
                [title appendAttributedString:time];
                
                NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
                [paraStyle setLineSpacing:2];
                paraStyle.alignment = NSTextAlignmentCenter;
                [title addAttributes:@{NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, title.length)];
                
                [btn setAttributedTitle:title forState:UIControlStateNormal];
                
                
            }else{
                
                
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }
            
            btn.backgroundColor = [UIColor myColorWithHexString:@"#e71f33"];


            
        }else{
            
            
            if (btn.tag == 0) {
                
                NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",@"1000元"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0]}];
                
                NSAttributedString *time = [[NSAttributedString alloc] initWithString:@"充1000送200" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor colorWithRed:231/255.0 green:31/255.0 blue:51/255.0 alpha:1.0]}];
                
                [title appendAttributedString:time];
                
                NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
                [paraStyle setLineSpacing:2];
                paraStyle.alignment = NSTextAlignmentCenter;
                [title addAttributes:@{NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, title.length)];
                
                [btn setAttributedTitle:title forState:UIControlStateNormal];
                
                
            }else{
                
                [btn setTitleColor:[UIColor myColorWithHexString:@"#404040"] forState:UIControlStateNormal];

            }
            
            btn.backgroundColor = [UIColor whiteColor];


        }
        
        
    }
    
    
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        self.AliSelectBtn.selected = YES;
        self.WXSelectBtn.selected = NO;
        
    }else{
        
        self.AliSelectBtn.selected = NO;
        self.WXSelectBtn.selected = YES;
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
