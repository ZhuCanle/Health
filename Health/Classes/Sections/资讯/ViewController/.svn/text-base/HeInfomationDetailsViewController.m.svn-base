//
//  HeInfomationDetailsViewController.m
//  Health
//
//  Created by 快摇002 on 2017/6/21.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeInfomationDetailsViewController.h"
#import "HeInfomationDetailToolBar.h"
#import "HeInfomationDetailCommentCell.h"
#import "HeInfomationDetailHeaderView.h"
#import <DTCoreText.h>
#import <DTCoreText/DTAttributedTextView.h>
#import <DTCoreText/DTLazyImageView.h>
#import "HeInformationDetailTopCell.h"
#import "HePostCommentView.h"
#import "HeSharePopView.h"
#import "Xbox.h"

@interface HeInfomationDetailsViewController ()<UITableViewDelegate,
UITableViewDataSource,
DTAttributedTextContentViewDelegate,
UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>
{
    DTAttributedTextView *_textView;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) HeInfomationDetailToolBar *toolBar;
@property (strong, nonatomic) HeInfomationDetaillModel *infomationDetails;

@property (strong, nonatomic) HePostCommentView *commentView;

@property (assign, nonatomic) NSInteger page;

@property (assign, nonatomic) CGFloat height;

//对新闻进行评论
@property (assign, nonatomic) BOOL postCommentToInfomation;
@property (strong, nonatomic) HeSquareCommentModel *selectdComment;//记录选择的评论

@end

@implementation HeInfomationDetailsViewController


#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setup];

    self.toolBar.y = HEIGHT - self.toolBar.height;
    [self.view addSubview:self.toolBar];

    [self.view addSubview:self.tableView];

    [self sendInfomationDetailsRequest];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setGreenNavigationBarStatus];
}

#pragma mark - Private

- (void)setup
{
    self.navigationItem.title = @"新闻详情页";
    [self.navigationItem setHidesBackButton:TRUE animated:NO];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - NSNotification

- (void)keyboardWillChangeFrame:(NSNotification *)notic
{
    __weak typeof(self)weakSelf = self;
    CGFloat duration = [[notic.userInfo valueForKey:@"UIKeyboardAnimationDurationUserInfoKey"]doubleValue];
    CGRect rect = [[notic.userInfo valueForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        weakSelf.commentView.bottom = rect.origin.y;
    } completion:^(BOOL finished) {

    }];
}

- (void)sendInfomationDetailsRequest
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    HeInfoDetailData *data = [[HeInfoDetailData alloc]init];
    data.information_id = self.information_id;
    data.page_index = @"";
    data.page_count = @"";
    request.data = data;
    @weakify(self);
    [MBProgressHUD showLoadingToView:self.view];
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appinformationmanager/infordetail?" successBlock:^(HeRespone *respone) {
        @strongify(self);
        if (respone.state == 1)
        {
            self.infomationDetails = [HeInfomationDetaillModel mj_objectWithKeyValues:respone.responeObject];
            self.toolBar.model = self.infomationDetails;
            [self initCoreText:self.infomationDetails.infor.information_content];
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showText:@"没有更多数据" withTime:1.5];
        }
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideLoadingToView:self.view];
        [MBProgressHUD hideLoadingToView:self.view];
    } failureBlock:^(NSError *error)
     {
         [self.tableView.mj_header endRefreshing];
         [MBProgressHUD hideLoadingToView:self.view];
     } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
     }];
}

- (void)sendCommentListReqeust
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    HeInfomationDetailCommentData *data = [[HeInfomationDetailCommentData alloc]init];
    data.comment_article_id = self.infomationDetails.infor.information_id;
    data.comment_type = 1;
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    data.page_index = [NSString stringWithFormat:@"%ld",self.page];
    data.page_count = @"10";
    request.data = data;
    [MBProgressHUD showLoadingToView:self.view];
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appcomment/listcomment?" successBlock:^(HeRespone *respone) {
        if (respone.state == 1)
        {
            NSMutableArray *comments = [HeSquareCommentModel mj_objectArrayWithKeyValuesArray:respone.data];
            [self.infomationDetails.commentInfor addObjectsFromArray:comments];
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showText:@"没有更多的数据" withTime:1.5];
            if (self.page != 1) {
                self.page -= 1;
            }
        }
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideLoadingToView:self.view];
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideLoadingToView:self.view];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}

- (void)sendInfomationPriaseActionRquest
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    HeinfomationPriaseData *data = [[HeinfomationPriaseData alloc]init];
    data.information_id = self.infomationDetails.infor.information_id;
    data.information_thump_up_number = self.infomationDetails.infor.information_thump_up_number + 1;
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    request.data = data;
    [MBProgressHUD showLoadingToView:self.view];
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appinformationmanager/inforeditthumbup?" successBlock:^(HeRespone *respone) {
        if (respone.state == 1)
        {
            [MBProgressHUD showText:@"点赞成功" withTime:1.5];
            self.infomationDetails.isPriase = YES;
            self.toolBar.model = self.infomationDetails;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showText:@"点赞失败" withTime:1.5];
        }
        [MBProgressHUD hideLoadingToView:self.view];
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingToView:self.view];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}

- (void)sendInfomationCommentPriaseAction:(HeSquareCommentModel *)comment
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    HePriaseData *data = [[HePriaseData alloc]init];

    data.comment_article_id = self.infomationDetails.infor.information_id;
    data.comment_thump_up_number = comment.comment_thump_up_number + 1;
    data.comment_id = comment.comment_id;
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    request.data = data;
    [MBProgressHUD showLoadingToView:self.view];
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appcomment/appthumbup?" successBlock:^(HeRespone *respone) {
        if (respone.state == 1)
        {
            [MBProgressHUD showText:@"点赞成功" withTime:1.5];
            comment.isPrase = YES;
            comment.comment_thump_up_number = comment.comment_thump_up_number +=1;
            [self.tableView reloadData];
        }else
        {
            if (respone.state == 2) {
                [MBProgressHUD showText:@"已经点赞" withTime:1.5];
            }
        }
        [MBProgressHUD hideLoadingToView:self.view];
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingToView:self.view];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}


- (void)sendInfomationCollectionActionRquest
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    HeCollectionInfomationData *data = [[HeCollectionInfomationData alloc]init];
    data.user_id = @"902d61365a974e55b2ccea6b3ca0eb61";
    data.collection_information_type = 1;
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    request.data = data;
    [MBProgressHUD showLoadingToView:self.view];
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appcollection/appcollectionpaper?" successBlock:^(HeRespone *respone) {
        if (respone.state == 1)
        {
            [MBProgressHUD showText:@"收藏成功" withTime:1.5];
            self.infomationDetails.isCollection = YES;
            self.toolBar.model = self.infomationDetails;
            [self.tableView reloadData];
        }else
        {
            if (respone.state == 2) {
                [MBProgressHUD showText:@"已收藏" withTime:1.5];
                self.infomationDetails.isCollection = YES;
                self.toolBar.model = self.infomationDetails;
            }
        }
        [MBProgressHUD hideLoadingToView:self.view];
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingToView:self.view];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}

- (void)sendInfomationCommentsActionRquestWith:(NSString *)text image:(UIImage *)image
{
    [MBProgressHUD showLoadingToView:self.view];

    //拿到图片
    UIImage *imagesave = [self resizeImage:image];
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/post.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];

    NSString *string = [NSString stringWithFormat:@"{\"information_id\":\"%ld\",\"comment_type\":\"%@\",\"critics_user_id\":\"%@\",\"comment_content\":\"%@\",\"quote_comment_id\":\"\"}",self.infomationDetails.infor.information_id,@"1",@"6c1d4ee126da43bc90c5c99f4bdcb947",text];

    NSDictionary *parameters = @{@"sign":@"637586292ebf2c5fabab863734fc6a12",@"data":string,@"file":@"MultipartFile"};
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]init];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@healthssm/appcomment/appaddcomments?",DOMAIN_PATH] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(image != nil)
        {
            //            NSData *imageData = UIImagePNGRepresentation(image);
            //            [formData appendPartWithFormData:imageData name:@"file"];
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:imagePath] name:@"file" error:nil];
        }
    } error:nil];

    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          [MBProgressHUD hideLoadingToView:self.view];
                      } else {
                          NSLog(@"responseObject =  %@", responseObject);

                          NSDictionary *responeDict = (NSDictionary *)responseObject;
                          NSInteger status = [[responeDict valueForKey:@"state"]integerValue];
                          if (status == 1) {
                              [MBProgressHUD showText:@"评论发布成功" withTime:1.5];
                              {
                                  //                                  imginfor =     {
                                  //                                      "comment_app_img" =         {
                                  //                                          height = 498;
                                  //                                          img = "http://182.92.102.79:80/uploadFiles/uploadImgs/comment_img/20170627/health_552149.png";
                                  //                                          width = 746;
                                  //                                      };
                                  //                                      "comment_id" = 1352;
                                  //                                      "comment_img" = "http://182.92.102.79:80/uploadFiles/uploadImgs/comment_img/20170627/health_552149.png";
                                  //                                  };
                                  //                                  quoteinfor =     {
                                  //                                      "quote_comment_content" = "";
                                  //                                      "quote_comment_img" = "";
                                  //                                  };
                                  //                                  state = 1;
                                  NSDictionary *dict = [responeDict valueForKey:@"imginfor"];

                                  HeSquareCommentModel *model = [[HeSquareCommentModel alloc]init];
                                  model.critics_user_nickname = @"为情所困";
                                  model.critics_user_head_img = @"http://182.92.102.79:80/uploadFiles/uploadImgs/comment_img/20170627/health_678049.png";
                                  HeImageModel *comment_app_img = [[HeImageModel alloc]init];

                                  NSDictionary *comment_app_img_dict = [dict valueForKey:@"comment_app_img"];

                                  comment_app_img.height = [[comment_app_img_dict valueForKey:@"height"]floatValue];
                                  comment_app_img.width = [[comment_app_img_dict valueForKey:@"width"]floatValue];
                                  comment_app_img.img = [comment_app_img_dict valueForKey:@"img"];
                                  model.comment_app_img = comment_app_img;

                                  model.comment_id = [[dict valueForKey:@"comment_id"]integerValue];
                                  model.comment_content = text;

                                  [self.infomationDetails.commentInfor addObject:model];
                                  [self.tableView reloadData];
                                  [self scrollTableToFoot:YES];
                              }
                          }else
                          {
                              [MBProgressHUD showText:@"评论发布失败" withTime:1.5];
                          }
                          [MBProgressHUD hideLoadingToView:self.view];
                      }
                  }];
    [uploadTask resume];
}

- (void)sendInfomationComment
{
    [self.commentView dismissWithCallBlock:^{

    }];
    [self sendInfomationCommentsActionRquestWith:_commentView.text image:_commentView.image];
}

- (void)sendCommentToUserCommentWith:(HeSquareCommentModel *)comment
{
    [MBProgressHUD showLoadingToView:self.view];
    [self.commentView dismissWithCallBlock:nil];
    UIImage *imagesave = [self resizeImage:_commentView.image];
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/post.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];

    NSString *string = [NSString stringWithFormat:@"{\"information_id\":\"%ld\",\"comment_type\":\"%@\",\"critics_user_id\":\"%@\",\"comment_content\":\"%@\",\"by_critics_user_id\":\"%@\",\"quote_comment_id\":\"%ld\"}",self.infomationDetails.infor.information_id,@"1",@"6c1d4ee126da43bc90c5c99f4bdcb947",_commentView.text,comment.critics_user_id,comment.comment_id];

    NSDictionary *parameters = @{@"sign":@"637586292ebf2c5fabab863734fc6a12",@"data":string,@"file":@"MultipartFile"};
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]init];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@healthssm/appcomment/appaddcomments?",DOMAIN_PATH] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(imagesave != nil)
        {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:imagePath] name:@"file" error:nil];
        }
    } error:nil];

    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                          [MBProgressHUD hideLoadingToView:self.view];
                      } else {
                          NSLog(@"responseObject =  %@", responseObject);

                          NSDictionary *responeDict = (NSDictionary *)responseObject;
                          NSInteger status = [[responeDict valueForKey:@"state"]integerValue];
                          if (status == 1) {
                              [MBProgressHUD showText:@"评论发布成功" withTime:1.5];
                              {
                                  //                                  responseObject =  {
                                  //                                      imginfor =     {
                                  //                                          "comment_app_img" =         {
                                  //                                              height = 750;
                                  //                                              img = "http://182.92.102.79:80/uploadFiles/uploadImgs/comment_img/20170627/health_355102.png";
                                  //                                              width = 750;
                                  //                                          };
                                  //                                          "comment_id" = 1367;
                                  //                                          "comment_img" = "http://182.92.102.79:80/uploadFiles/uploadImgs/comment_img/20170627/health_355102.png";
                                  //                                      };
                                  //                                      quoteinfor =     {
                                  //                                          "quote_comment_content" = 666666666;
                                  //                                          "quote_comment_img" = "";
                                  //                                      };
                                  //                                      state = 1;
                                  //                                  }

                                  NSDictionary *dict = [responeDict valueForKey:@"imginfor"];

                                  NSDictionary *quoteinfor = [responeDict valueForKey:@"quoteinfor"];
                                  HeSquareCommentModel *model = [[HeSquareCommentModel alloc]init];

                                  model.critics_user_nickname = @"哈哈哈哈";
                                  model.critics_user_head_img = @"http://182.92.102.79:80/uploadFiles/uploadImgs/comment_img/20170627/health_678049.png";

                                  model.by_critics_user_id = comment.critics_user_id;
                                  model.by_critics_user_nickname = comment.critics_user_nickname;
                                  model.by_critics_user_head_img = comment.critics_user_head_img;
                                  model.comment_content = _commentView.text;

                                  model.quote_comment_content = [quoteinfor valueForKey:@"quote_comment_content"];

                                  HeImageModel *comment_app_img = [[HeImageModel alloc]init];
                                  NSDictionary *comment_app_img_dict = [dict valueForKey:@"comment_app_img"];
                                  comment_app_img.height = [[comment_app_img_dict valueForKey:@"height"]floatValue];
                                  comment_app_img.width = [[comment_app_img_dict valueForKey:@"width"]floatValue];
                                  comment_app_img.img = [comment_app_img_dict valueForKey:@"img"];
                                  model.comment_app_img = comment_app_img;
                                  model.comment_id = [[dict valueForKey:@"comment_id"]integerValue];
                                  [self.infomationDetails.commentInfor addObject:model];
                                  [self.tableView reloadData];
                                  [self scrollTableToFoot:YES];
                              }
                          }else
                          {
                              [MBProgressHUD showText:@"评论发布失败" withTime:1.5];
                          }
                          [MBProgressHUD hideLoadingToView:self.view];
                      }
                  }];
    [uploadTask resume];
}

- (void)scrollTableToFoot:(BOOL)animated
{
    NSInteger s = [self.tableView numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.tableView numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}

/// 初始化富文本控件
-(void) initCoreText:(NSString *) inforContent
{
    CGRect frame = CGRectMake(0.0, 0.0, 0, 0);
    _textView = [[DTAttributedTextView alloc] initWithFrame:frame];
    //    [_textView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
    _textView.contentInset =  UIEdgeInsetsMake(10, 10, 10, 10);
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth & UIViewAutoresizingFlexibleHeight;
    _textView.attributedString = [self _attributedStringForSnippetUsingiOS6Attributes:YES inforContent:inforContent];
    _textView.shouldDrawImages = YES;
    _textView.shouldDrawLinks = YES; // we draw them in DTLinkButton
    _textView.textDelegate = self; // delegate for custom sub views
    [_textView setNeedsLayout];
    _textView.scrollEnabled = NO;

    DTAttributedTextContentView *attrTextView = [DTAttributedTextContentView new];
    attrTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth & UIViewAutoresizingFlexibleHeight;
    attrTextView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    [attrTextView setAttributedString:[self _attributedStringForSnippetUsingiOS6Attributes:YES inforContent:inforContent]];
    CGSize textSize = [attrTextView suggestedFrameSizeToFitEntireStringConstraintedToWidth:WIDTH];

    self.height = textSize.height + 40;
//    NSLog(@"%@%f",@"cccccccc-",self.height);
    _textView.frame = CGRectMake(0, 0, WIDTH, self.height);
    [self.tableView reloadData];
}

- (NSAttributedString *)_attributedStringForSnippetUsingiOS6Attributes:(BOOL)useiOS6Attributes inforContent:(NSString *) inforContent
{
    NSData *data = [inforContent dataUsingEncoding:NSUTF8StringEncoding];
    CGSize maxImageSize = CGSizeMake(WIDTH - 20, MAXFLOAT);
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };

    // 设置字体
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.2], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Heiti SC", DTDefaultFontFamily,  @"Heiti SC", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, nil];

    if (useiOS6Attributes)
    {
        [options setObject:[NSNumber numberWithBool:YES] forKey:DTUseiOS6Attributes];
    }

    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    return string;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;

        // sets the image if there is one
        imageView.image = [(DTImageTextAttachment *)attachment image];

        // url for deferred loading
        imageView.url = attachment.contentURL;
        return imageView;

    }
    else if ([attachment isKindOfClass:[DTIframeTextAttachment class]])
    {
        //        DTWebVideoView *videoView = [[DTWebVideoView alloc] initWithFrame:frame];
        //        videoView.attachment = attachment;
        //
        //        return videoView;

    }
    else if ([attachment isKindOfClass:[DTObjectTextAttachment class]])
    {
        // somecolorparameter has a HTML color
        NSString *colorName = [attachment.attributes objectForKey:@"somecolorparameter"];
        UIColor *someColor = DTColorCreateWithHTMLName(colorName);

        UIView *someView = [[UIView alloc] initWithFrame:frame];
        someView.backgroundColor = someColor;
        someView.layer.borderWidth = 1;
        someView.layer.borderColor = [UIColor blackColor].CGColor;

        someView.accessibilityLabel = colorName;
        someView.isAccessibilityElement = YES;

        return someView;
    }

    return nil;
}

- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(frame,1,1) cornerRadius:10];

    CGColorRef color = [textBlock.backgroundColor CGColor];
    if (color)
    {
        CGContextSetFillColorWithColor(context, color);
        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextFillPath(context);

        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
        CGContextStrokePath(context);
        return NO;
    }

    return YES; // draw standard background
}


- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
{
    NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
    NSURL *URL = [attributes objectForKey:DTLinkAttribute];
    NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
    DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
    button.URL = URL;
    button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
    button.GUID = identifier;
    // get image with normal link text
    UIImage *normalImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDefault];
    [button setImage:normalImage forState:UIControlStateNormal];
    // get image for highlighted link text
    UIImage *highlightImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDrawLinksHighlighted];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    // use normal push action for opening URL
    //    [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
    // demonstrate combination with long press
    //    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
    //    [button addGestureRecognizer:longPress];
    return button;
}

- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSURL *url = lazyImageView.url;
    CGSize imageSize = size;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    BOOL didUpdate = NO;
    // update all attachments that match this URL (possibly multiple images with same size)
    for (DTTextAttachment *oneAttachment in [_textView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
    {
        // update attachments that have no original size, that also sets the display size
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero))
        {
            oneAttachment.originalSize = imageSize;
            didUpdate = YES;
        }
    }
    if (didUpdate)
    {
        // layout might have changed due to image sizes
        // do it on next run loop because a layout pass might be going on
        dispatch_async(dispatch_get_main_queue(), ^{
            [_textView relayoutText];
        });
    }
}

- (void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView didDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context{

    CGFloat h = layoutFrame.frame.size.height;
    if(self.height < h){
        self.height = h + 40;
        NSLog(@"%@%f",@"ddddd-",self.height);
        _textView.frame = CGRectMake(0, 0, WIDTH, self.height);
        [self.tableView reloadData];
    }
//    NSLog(@"%@%f",@"aaaaaa---1--",h);
}

- (void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView willDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context{

    CGFloat h = layoutFrame.frame.size.height;
//    NSLog(@"%@%f",@"bbbbbb-",h);
    //    NSLog(@"%@","bbbbb");
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.infomationDetails == nil) {
        return 0;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }else
    {
        return self.infomationDetails.commentInfor.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            HeInformationDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeInformationDetailTopCell"];
            cell.information = self.infomationDetails.infor;
            return cell;
        }else
        {
            //            DTAttributedTextCell *dtcell = (DTAttributedTextCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
            //            return dtcell;
            static NSString *cellId = @"cellId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell.contentView addSubview:_textView];
            return cell;
        }
    }else
    {
        HeInfomationDetailCommentCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HeInfomationDetailCommentCell"];
        HeSquareCommentModel *model = [self.infomationDetails.commentInfor objectAtIndex:indexPath.row];
        cell.comment = model;
        cell.levelString = [NSString stringWithFormat:@"%ld楼",indexPath.row+1];
        [cell setCommentCellDidClick:^(NSInteger index){
            if (index == 0)
            {
                //                [MBProgressHUD showText:@"评论用户的评论" withTime:1.5];
                self.postCommentToInfomation = NO;
                [self.commentView showInView:self.view];
                self.selectdComment = model;
            }else
            {
                if (!model.isPrase) {
                    [self sendInfomationCommentPriaseAction:model];
                }
                //                [MBProgressHUD showText:@"给用户点赞" withTime:1.5];
            }
        }];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.01f;
    }else
    {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else
    {
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        HeInfomationDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeInfomationDetailHeaderView"];
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        return headerView;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return [tableView fd_heightForCellWithIdentifier:@"HeInformationDetailTopCell" cacheByIndexPath:indexPath configuration:^(HeInformationDetailTopCell *cell) {
                cell.information = self.infomationDetails.infor;
            }];
        }else
        {
            return self.height;
        }
    }else
    {
        HeSquareCommentModel *model = [self.infomationDetails.commentInfor objectAtIndex:indexPath.row];
        return [tableView fd_heightForCellWithIdentifier:@"HeInfomationDetailCommentCell" cacheByIndexPath:indexPath configuration:^(HeInfomationDetailCommentCell *cell) {
            cell.comment = model;
            cell.levelString = [NSString stringWithFormat:@"%ld楼",indexPath.row+1];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        HeSquareCommentModel *model = [self.infomationDetails.commentInfor objectAtIndex:indexPath.row];
        self.postCommentToInfomation = NO;
        [self.commentView showInView:self.view];
        self.selectdComment = model;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)openImgeaPickerWith:(UIImagePickerControllerSourceType)type
{
    if ([UIImagePickerController isSourceTypeAvailable:type])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = type;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        NSLog(@"您的设备不支持该功能");
    }
}

- (void)reloadSubmitImageView:(UIImage *)image
{
    self.commentView.image = image;
}

- (UIImage *)resizeImage:(UIImage *)orignalImage
{
    CGFloat width = orignalImage.size.width;
    CGFloat height = orignalImage.size.height;
    CGFloat scale = width/height;
    CGSize size = CGSizeMake(0, 0);

    if (width <= 1280 && height <= 1280) {
        return orignalImage;
    }else if (width > 1280 || height >1280)
    {
        if (scale <= 2 && scale > 1) {
            CGFloat newWidth = 1280;
            CGFloat newHeight = newWidth/scale;
            size = CGSizeMake(newWidth, newHeight);
        }else if (scale >= 0.5 && scale <1)
        {
            CGFloat newHeight = 1280;
            CGFloat newWidth = newHeight *scale;
            size = CGSizeMake(newWidth, newHeight);
        }else if (width > 1280 && height > 1280)
        {
            if (scale > 2)
            {
                CGFloat newHeight = 1280;
                CGFloat newWidth = newHeight *scale;
                size = CGSizeMake(newWidth, newHeight);
            }else if (scale < 0.5)
            {
                CGFloat newWidth = 1280;
                CGFloat newHeight = newWidth / scale;
                size = CGSizeMake(newWidth, newHeight);
            }
        }else
        {
            return orignalImage;
        }
    }
    UIGraphicsBeginImageContext(size);

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width = size.width;
    thumbnailRect.size.height = size.height;
    [orignalImage drawInRect:thumbnailRect];
    UIImage *changeImage = UIGraphicsGetImageFromCurrentImageContext();

    if(changeImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return changeImage;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{
            [self openImgeaPickerWith:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        }
        case 1:{
            [self openImgeaPickerWith:UIImagePickerControllerSourceTypeCamera];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info [UIImagePickerControllerEditedImage];
    image = [Xbox fixOrientation:image];

    [self reloadSubmitImageView:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazyload

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - self.toolBar.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[HeInfomationDetailCommentCell loadNib] forCellReuseIdentifier:@"HeInfomationDetailCommentCell"];
        [_tableView registerNib:[HeInfomationDetailHeaderView loadNib] forHeaderFooterViewReuseIdentifier:@"HeInfomationDetailHeaderView"];
        [_tableView registerNib:[HeInformationDetailTopCell loadNib] forCellReuseIdentifier:@"HeInformationDetailTopCell"];
        _tableView.separatorColor = UIColorFromRGB(0xf1f1f1);

        @weakify(self);
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //            @strongify(self);
        //            [self sendInfomationDetailsRequest];
        //        }];

        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page += 1;
            [self sendCommentListReqeust];
        }];
    }
    return _tableView;
}

- (HeInfomationDetailToolBar *)toolBar
{
    if (_toolBar == nil) {
        _toolBar = [HeInfomationDetailToolBar toolBar];
        @weakify(self);
        [_toolBar setToolBarClickType:^(ToolBarButtonType type){
            @strongify(self);
            if (type == ToolBarButtonBack) {
                [self.navigationController popViewControllerAnimated:YES];
            }else if (type == ToolBarButtonInput)
            {
                self.postCommentToInfomation = YES;
                [self.commentView showInView:self.view];
            }else if (type == ToolBarButtonShare)
            {
                HeSharePopView *share = [HeSharePopView getSharePopView];
                [share show];
            }else if (type == ToolBarButtonPriase)
            {
                if (!self.infomationDetails.isPriase) {
                    [self sendInfomationPriaseActionRquest];
                }
            }else if (type == ToolBarButtonCollection)
            {
                if (!self.infomationDetails.isCollection) {
                    [self sendInfomationCollectionActionRquest];
                }
            }
        }];
    }
    return _toolBar;
}

- (HePostCommentView *)commentView
{
    if (_commentView == nil) {
        _commentView = [HePostCommentView commentView];
        @weakify(self);
        [_commentView setPostCommentViewClick:^(PostCommentButtonType type){
            @strongify(self);
            if (type == PostCommentButtonSend)
            {
                if (self.postCommentToInfomation) {
                    [self sendInfomationComment];
                }else
                {
                    [self sendCommentToUserCommentWith:self.selectdComment];
                }
            }else if(type == ToolBarButtonPhoto)
            {
                UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择本地相册",@"拍摄新照片", nil];
                [actionSheet showInView:self.view];
            }
        }];
    }
    return _commentView;
}
@end
