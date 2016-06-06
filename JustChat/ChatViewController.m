//
//  ChatViewController.m
//  JustChat
//
//  Created by admin on 5/30/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import "ChatViewController.h"
#import "MyMessageTableViewCell.h"
#import "OtherMessageTableViewCell.h"
#import "EMClient.h"
#import "EMChatManagerDelegate.h"
#import "EMMessage.h"
#import "EMMessageBody.h"
@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *inputT;
@property (strong, nonatomic) NSMutableArray *messageArr;
@property (strong, nonatomic) NSMutableDictionary *cellHeightDic;
@end

@implementation ChatViewController

- (NSMutableArray *)messageArr{
    if (!_messageArr) {
        self.messageArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _messageArr;
}

- (NSMutableDictionary *)cellHeightDic{
    if (!_cellHeightDic) {
        self.cellHeightDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _cellHeightDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    // Do any additional setup after loading the view.
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:self.conversationID type:EMConversationTypeChat createIfNotExist:YES];
    [conversation markAllMessagesAsRead];
    NSDate *date = [NSDate date];
    NSArray *arr = [NSArray array];
    arr = [conversation loadMoreMessagesFrom:[[NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]] timeIntervalSince1970]*1000 + 1 to:[[NSDate date] timeIntervalSince1970]*1000 + 1 maxCount:10000];
    [self.messageArr addObjectsFromArray:arr];
    NSLog(@"%lu---%f",(unsigned long)arr.count,[date timeIntervalSince1970]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didReceiveMessages:(NSArray *)aMessages{
    [self.messageArr addObjectsFromArray:aMessages];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMMessage *message = self.messageArr[indexPath.row];
    if (message.direction == EMMessageDirectionReceive) {
        OtherMessageTableViewCell *oMCell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
        EMMessageBody *msgBody = message.body;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;
                oMCell.oMLabel.text = txt;
                CGFloat f = [oMCell setFrameOfCurrentCell:txt];
                [self.cellHeightDic setObject:@(f) forKey:indexPath];
                NSLog(@"f = %f",f);
                NSLog(@"收到的文字是 txt -- %@",txt);
            }
                break;
            case EMMessageBodyTypeImage:
            {
                // 得到一个图片消息body
                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"大图的secret -- %@"    ,body.secretKey);
                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                NSLog(@"大图的下载状态 -- %u",body.downloadStatus);
                
                
                // 缩略图sdk会自动下载
                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                NSLog(@"小图的下载状态 -- %u",body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                NSLog(@"纬度-- %f",body.latitude);
                NSLog(@"经度-- %f",body.longitude);
                NSLog(@"地址-- %@",body.address);
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                // 音频sdk会自动下载
                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                NSLog(@"音频的secret -- %@"        ,body.secretKey);
                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"音频文件的下载状态 -- %u"   ,body.downloadStatus);
                NSLog(@"音频的时间长度 -- %d"      ,body.duration);
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                
                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"视频的secret -- %@"        ,body.secretKey);
                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"视频文件的下载状态 -- %u"   ,body.downloadStatus);
                NSLog(@"视频的时间长度 -- %d"      ,body.duration);
                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                
                // 缩略图sdk会自动下载
                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                NSLog(@"缩略图的下载状态 -- %u"      ,body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeFile:
            {
                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"文件的secret -- %@"        ,body.secretKey);
                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"文件文件的下载状态 -- %u"   ,body.downloadStatus);
            }
                break;
                
            default:
                break;
        }
        return oMCell;
    }else{
        MyMessageTableViewCell *mMCell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
        return mMCell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat f = [self.cellHeightDic[indexPath] floatValue];
    NSLog(@"cellheight:%f",f);
    return f < 75 ? 75 : f;
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
