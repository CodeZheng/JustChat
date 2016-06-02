//
//  MessageTableViewController.m
//  JustChat
//
//  Created by admin on 5/27/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import "MessageTableViewController.h"
#import "EMClient.h"
#import "EMChatManagerDelegate.h"
#import "MessageTableViewCell.h"
#import "NSDate+FromString.h"
#import "ChatViewController.h"
@interface MessageTableViewController ()<EMChatManagerDelegate>
@property (nonatomic, strong) NSMutableArray *conversationsArr;
@end

@implementation MessageTableViewController
- (NSMutableArray *)conversationsArr{
    if (!_conversationsArr) {
        self.conversationsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _conversationsArr;
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.conversationsArr = [[[EMClient sharedClient].chatManager getAllConversations]mutableCopy];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMessages:(NSArray *)aMessages{
    self.conversationsArr = [[[EMClient sharedClient].chatManager getAllConversations]mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conversationsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    EMConversation *conversation = self.conversationsArr[indexPath.row];
    EMMessageBody *mb = conversation.latestMessage.body;
    if (mb.type == EMMessageBodyTypeText) {
        EMTextMessageBody *body = (EMTextMessageBody *)mb;
        cell.lastMessageLabel.text = body.text;
    }else if (mb.type == EMMessageBodyTypeImage){
        cell.lastMessageLabel.text = @"[图片]";
    }else if (mb.type == EMMessageBodyTypeLocation){
        cell.lastMessageLabel.text = @"[位置]";
    }else if (mb.type == EMMessageBodyTypeVideo){
        cell.lastMessageLabel.text = @"[视频]";
    }else if (mb.type == EMMessageBodyTypeFile){
        cell.lastMessageLabel.text = @"[文件]";
    }else if (mb.type == EMMessageBodyTypeVoice){
        cell.lastMessageLabel.text = @"[语音]";
    }
    
    cell.friendNameLabel.text = conversation.latestMessage.from;
    cell.timeMessageLabel.text = [NSDate convertDateFromDate:[NSDate dateWithTimeIntervalSince1970:conversation.latestMessage.timestamp/1000]];
    cell.headImageV.image = [UIImage imageNamed:@"touxiang"];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.hidesBottomBarWhenPushed = YES;
    ChatViewController *cVC = [[UIStoryboard storyboardWithName:@"Chat" bundle:nil]instantiateViewControllerWithIdentifier:@"cc"];
    [self.navigationController pushViewController:cVC animated:YES];
    EMConversation *conversation = self.conversationsArr[indexPath.row];
    cVC.title = conversation.latestMessage.from;
//    self.hidesBottomBarWhenPushed = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.conversationsArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

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
