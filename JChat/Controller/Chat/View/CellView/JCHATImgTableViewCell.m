//
//  JCHATImgTableViewCell.m
//  JPush IM
//
//  Created by Apple on 14/12/30.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "JCHATImgTableViewCell.h"
#import "JChatConstants.h"
#import "MBProgressHUD+Add.h"
#import "Masonry.h"
#define headHeight 46


@implementation JCHATImgTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.headView = [UIImageView new];
    
    [self.headView setImage:[UIImage imageNamed:@"headDefalt_34.png"]];
    [self addSubview:self.headView];
    self.headView.layer.cornerRadius = 23;
    [self.headView.layer setMasksToBounds:YES];
    
    self.pictureImgView = [UIImageView new];
    self.pictureImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.pictureImgView];
    self.pictureImgView.layer.cornerRadius=6;
    [self.pictureImgView.layer setMasksToBounds:YES];

    [self setUserInteractionEnabled:YES];
    [self.pictureImgView setUserInteractionEnabled:YES];
    UIImage *tmpImg=nil;
    tmpImg =[UIImage imageNamed:@"mychatBg"];
    UIImage *newImg =[tmpImg resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 28, 20)];
    [self.pictureImgView setImage:newImg];
    [self.pictureImgView setBackgroundColor:[UIColor clearColor]];
    
    self.pictureImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    [self.pictureImgView addGestureRecognizer:gesture];

    self.percentLabel = [UILabel new];
    self.percentLabel.hidden = NO;
    self.percentLabel.font =[UIFont systemFontOfSize:18];
    self.percentLabel.textAlignment=NSTextAlignmentCenter;
    self.percentLabel.textColor=[UIColor whiteColor];
    [self.percentLabel setBackgroundColor:[UIColor clearColor]];
    
    [self.pictureImgView addSubview:self.percentLabel];
    
    self.circleView = [UIActivityIndicatorView new];
    
    [self addSubview:self.circleView];
    [self.circleView setBackgroundColor:[UIColor clearColor]];
    [self.circleView setHidden:NO];
    self.circleView.hidesWhenStopped=YES;
    
    self.downLoadIndicatorView = [UIActivityIndicatorView new];
    
    [self.pictureImgView addSubview:self.downLoadIndicatorView];
    [self.downLoadIndicatorView setBackgroundColor:[UIColor clearColor]];
    [self.downLoadIndicatorView setHidden:NO];
    self.downLoadIndicatorView.hidesWhenStopped=YES;
    
    self.sendFailView = [UIImageView new];
    [self addSubview:self.sendFailView];
    [self.sendFailView setUserInteractionEnabled:YES];
    [self.sendFailView setImage:[UIImage imageNamed:@"fail05"]];
    
    [self headAddGesture];
    [self initAutoLayout];
  }
  return self;
}

- (void)initAutoLayout {
  [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(headHeight, headHeight));
    make.right.mas_equalTo(self).with.offset(-5);
    make.top.mas_equalTo(self);
  }];
  [self.pictureImgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(50, 50));
    make.centerY.mas_equalTo(self);
    make.right.mas_equalTo(self.headView.mas_left).with.offset(-5);
  }];
  
  [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(20, 20));
    make.centerY.mas_equalTo(self);
    make.right.mas_equalTo(self.pictureImgView.mas_left).with.offset(-15);
  }];
  [self.sendFailView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(17, 15));
    make.centerY.mas_equalTo(self);
    make.right.mas_equalTo(self.pictureImgView.mas_left).with.offset(-15);
  }];
  [self.downLoadIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(20, 20));
    make.center.mas_equalTo(self.pictureImgView);
  }];
}


#pragma mark --发送消息响应
//- (void)sendMessageResponse:(NSNotification *)response {
//  DDLogDebug(@"Event - sendMessageResponse");
//
//  JPIMMAINTHEAD(^{
//        NSDictionary *responseDic = [response userInfo];
//        NSError *error = [responseDic objectForKey:JMSGSendMessageError];
//        JMSGImageMessage *message = [responseDic objectForKey:JMSGSendMessageObject];
//        if (error == nil) {
//        }else {
//            JPIMLog(@"Sent voiceMessage Response error:%@",error);
//        }
//        if (![message.messageId isEqualToString:_message.messageId]) {
//            return ;
//        }
//        [self.circleView stopAnimating];
////        self.contentImgView.alpha = 1;
//        self.pictureImgView.alpha = 1;
//        _model.isSending = NO;
//        if (error == nil) {
//            self.model.messageStatus = kJMSGStatusSendSucceed;
//            [self.sendFailView setHidden:YES];
//            [self.circleView stopAnimating];
//            [self.circleView setHidden:YES];
//        }else {
//            self.model.messageStatus = kJMSGStatusSendFail;
//            [self.sendFailView setHidden:NO];
//            [self.circleView stopAnimating];
//            [self.circleView setHidden:YES];
//            _sendFailImgMessage = [message copy];
//        }
//        [self updateFrame];
//
//    });
//}

- (void)headAddGesture {
    [self.headView setUserInteractionEnabled:YES];
//    [self.contentImgView setUserInteractionEnabled:YES];
    [self.pictureImgView setUserInteractionEnabled:YES];

    UITapGestureRecognizer *gesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPersonInfoCtlClick)];
    [self.headView addGestureRecognizer:gesture];
    UITapGestureRecognizer *messageFailGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reSendMessage)];
    [self.sendFailView addGestureRecognizer:messageFailGesture];
}

- (void)reSendMessage {
    UIAlertView *alerView =[[UIAlertView alloc] initWithTitle:nil message:@"是否重新发送消息"
                                                     delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alerView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.sendFailView setHidden:YES];
        [self.circleView setHidden:NO];
        [self.circleView startAnimating];
//        self.contentImgView.alpha = 0.5;
      self.pictureImgView.alpha = 0.5;
        _model.isSending = YES;
        self.model.messageStatus = kJMSGMessageStatusSending;
        __weak typeof(self)weakSelf = self;
        if (!self.sendFailImgMessage) {
         self.sendFailImgMessage = [self.conversation messageWithMessageId:self.model.messageId];

        }else {
          self.sendFailImgMessage.uploadHandler = ^(float percent){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            NSLog(@"huangmin  percent number is %f",percent*100);
            dispatch_async(dispatch_get_main_queue(), ^{
                            strongSelf.percentLabel.text=[NSString stringWithFormat:@"%d%%",(int)percent*100];
            });
          };
          [JMSGMessage sendMessage:self.sendFailImgMessage];
        }
    }
}

- (void)pushPersonInfoCtlClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectHeadView:)]) {
        [self.delegate selectHeadView:self.model];
    }
}

- (void)setCellData :(UIViewController *)controler chatModel :(JCHATChatModel *)chatModel message:(JMSGMessage *)message indexPath :(NSIndexPath *)indexPath {
  self.conversation = chatModel.conversation;
  self.model = chatModel;
  self.headViewFlag = chatModel.fromUser.username;
  _message= message;
  if (_model.isSending) {
    self.pictureImgView.alpha = 0.5;
  }else {
    self.pictureImgView.alpha = 1;
  }
  [self.circleView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
  if (self.model.messageStatus == kJMSGMessageStatusReceiveDownloadFailed) {
    [self.pictureImgView setImage:[UIImage imageNamed:@"receiveFail"]];
  } else if ([[NSFileManager defaultManager] fileExistsAtPath:self.model.pictureThumbImgPath]) {
    [self.pictureImgView setImage:[UIImage imageWithContentsOfFile:self.model.pictureThumbImgPath]];//!
  }else if (((JMSGImageContent *)message.content).thumbImagePath){
    [self.pictureImgView setImage:[UIImage imageWithContentsOfFile:((JMSGImageContent *)message.content).thumbImagePath]];
  }else {
  }
  self.delegate = (id)controler;
  self.cellIndex = indexPath;
  NSLog(@"huangmin  message  %@",_model.fromUser);
  [self.imageView setImage:[UIImage imageNamed:@"headDefalt_34"]];
  typeof(self) __weak weakSelf = self;
  
  if (_model.avatar == nil) {
    [_model.fromUser thumbAvatarData:^(NSData *data, NSString *objectId, NSError *error) {
      if (error == nil) {
        JPIMMAINTHEAD(^{
          if ([objectId isEqualToString:self.headViewFlag]) {
            [weakSelf.headView setImage:[UIImage imageWithData:data]];
          } else {
            DDLogDebug(@"该头像是异步乱序的头像");
          }
        });
      } else {
        DDLogDebug(@"Action -- get thumbavatar fail");
      }
    }];
  } else {
    [self.headView setImage:[UIImage imageWithData:_model.avatar]];
  }

  
  dispatch_async(dispatch_get_main_queue(),^{
    [self updateFrame];
  });

  if (!_model.sendFlag) {
    _model.sendFlag = YES;
    [self sendImageMessage];
    
  }
}

#pragma mark --上传图片
- (void)sendImageMessage {
  DDLogDebug(@"Action - sendImageMessage");
  [self.circleView setHidden:NO];
  [self.circleView startAnimating];
//  self.contentImgView.alpha = 0.5;
  self.pictureImgView.alpha = 0.5;
  _model.isSending = YES;
  self.model.messageStatus = kJMSGMessageStatusSending;
  self.model.messageId = _message.msgId;
  __weak typeof(self) weakSelf = self;
  _message.uploadHandler = ^(float percent) {
    dispatch_async(dispatch_get_main_queue(), ^{
      __strong __typeof(weakSelf)strongSelf = weakSelf;
      NSLog(@"huangmin    the percent value  %d%%  %@",(int) percent * 100,strongSelf.percentLabel.hidden?@"hidden ":@"no hidden ");
      strongSelf.percentLabel.text = [NSString stringWithFormat:@"%d%%", (int) percent * 100];
    });
  };
//  if (self.conversation.chatType == kJMSGConversationTypeSingle) {
//    _message.conversationType = kJMSGConversationTypeSingle;
//  }else {
//    _message.conversationType = kJMSGConversationTypeGroup;
//  }
//  _message.targetId = self.model.targetId;
//  _message.mediaData = self.model.mediaData;
  
  DDLogVerbose(@"The imageMessage - %@", _message);
  [JMSGMessage sendMessage:_message];
}

- (void)tapPicture:(UIGestureRecognizer *)gesture {
  
    NSLog(@"nslog  tap gesture");
    if (self.model.messageStatus == kJMSGMessageStatusReceiveDownloadFailed) {
      NSLog(@"正在下载缩略图");
      JPIMLog(@"Action");
      [self.downLoadIndicatorView setHidden:NO];
      [self.downLoadIndicatorView startAnimating];
      JMSGMessage *imageReceiveFailMessage = [self.conversation messageWithMessageId:self.model.messageId];
      NSLog(@"huangmin  %@",imageReceiveFailMessage);
    }else {
      if (self.delegate && [self.delegate respondsToSelector:@selector(tapPicture:tapView:tableViewCell:)]) {
        [self.delegate tapPicture:self.cellIndex tapView:(UIImageView *)gesture.view tableViewCell:self];
      }
    }

}

- (void)layoutSubviews
{
    [self updateFrame];
}

- (void)updateFrame {
  NSInteger imgHeight = 0;
  NSInteger imgWidth = 0;
  [self.percentLabel setHidden:NO];
  if (self.model.messageStatus == kJMSGMessageStatusReceiveDownloadFailed) {
    [self.downLoadIndicatorView setCenter:CGPointMake(self.pictureImgView.frame.size.width/2, self.pictureImgView.frame.size.height/2)];
  } else {
    [self.downLoadIndicatorView setHidden:YES];
    _model.isSending = NO;
    __block UIImage *showImg;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.model.pictureThumbImgPath]) {
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        showImg = [UIImage imageWithContentsOfFile:self.model.pictureThumbImgPath];
      });
    } else if (((JMSGImageContent *)self.message.content).thumbImagePath) {
      showImg = [UIImage imageWithContentsOfFile:((JMSGImageContent *)self.message.content).thumbImagePath];
    } else {
      showImg = [UIImage imageNamed:@"receiveFail"];
    }

  }
  
  imgHeight = _model.imageSize.height;
  imgWidth = _model.imageSize.width;
  if (self.model.messageStatus == kJMSGMessageStatusSending || self.model.messageStatus == kJMSGMessageStatusReceiving) {
    [self.circleView setHidden:NO];
    [self.sendFailView setHidden:YES];
  } else if (self.model.messageStatus == kJMSGMessageStatusSendSucceed || self.model.messageStatus == kJMSGMessageStatusReceiveSucceed)
  {
    [self.circleView setHidden:YES];
    [self.sendFailView setHidden:YES];
    [self.percentLabel setHidden:YES];
  } else if (self.model.messageStatus == kJMSGMessageStatusSendFailed)
  {
    [self.circleView setHidden:YES];
    [self.sendFailView setHidden:NO];
  } else {
    [self.circleView setHidden:YES];
    [self.sendFailView setHidden:YES];
  }

  if (self.model.isMyMessage) {//myself
    img =[UIImage imageNamed:@"mychatBg"];

    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(headHeight, headHeight));
      make.right.mas_equalTo(self).with.offset(-5);
      make.top.mas_equalTo(self);
    }];
    [self.pictureImgView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
      make.centerY.mas_equalTo(self);
      make.right.mas_equalTo(self.headView.mas_left).with.offset(-5);
    }];
    [self.circleView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(20, 20));
      make.centerY.mas_equalTo(self);
      make.right.mas_equalTo(self.pictureImgView.mas_left).with.offset(-15);
    }];
    [self.sendFailView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(17, 15));
      make.centerY.mas_equalTo(self);
      make.right.mas_equalTo(self.pictureImgView.mas_left).with.offset(-15);
    }];
    [self.downLoadIndicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(20, 20));
      make.center.mas_equalTo(self.pictureImgView);
    }];
    
    
  } else {
    img =[UIImage imageNamed:@"otherChatBg"];

    NSLog(@"huangmin  aself.frame.size.width %f",self.frame.size.width);
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(headHeight, headHeight));
      make.right.mas_equalTo(self).with.offset(5+headHeight-self.frame.size.width);
      make.top.mas_equalTo(self);
    }];
    [self.pictureImgView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
      make.centerY.mas_equalTo(self);
      make.right.mas_equalTo(self.headView.mas_left).with.offset(imgWidth + headHeight + 5);
    }];
    [self.circleView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(20, 20));
      make.centerY.mas_equalTo(self);
      make.right.mas_equalTo(self.pictureImgView.mas_left).with.offset(imgWidth + 15);
    }];
    [self.sendFailView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(17, 15));
      make.centerY.mas_equalTo(self);
      make.right.mas_equalTo(self.pictureImgView.mas_left).with.offset(imgWidth + 15);
    }];
    [self.downLoadIndicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(20, 20));
      make.center.mas_equalTo(self.pictureImgView);
    }];
  }

  [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(50, 50));
    make.center.mas_equalTo(self.pictureImgView);
  }];

  [self.downLoadIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(20, 20));//!
    make.center.mas_equalTo(self.pictureImgView);
  }];
  CALayer *imagemask = [CALayer layer];
  imagemask.contents = (__bridge id)(img.CGImage);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
