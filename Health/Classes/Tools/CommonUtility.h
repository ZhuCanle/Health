//
//  CommonUtility.h
//  ToHow
//
//  Created by maple on 15-5-6.
//  Copyright (c) 2015年 maple. All rights reserved.
//
//提供简易调用的方法集合


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


/**
 * 描述：判断屏幕是否为retain屏幕
 * 参数：
 * 返回值：YES为真，NO为否
 *
 */
CG_INLINE BOOL isRetinaScreen(){
    CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
	if (((screenSize.width >= 639.9f))
		&& (screenSize.height >= 959.9f)){
        return YES;
	}
    return NO;
}

/**
 * 描述：获取设备版本
 * 参数：
 * 返回值：版本号
 *
 */
CG_INLINE NSString *currentSystemVersion() {
    CGFloat versionNumber = 0.f;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if(version){
        versionNumber = [version floatValue];
    }
    return [NSString stringWithFormat:@"%.1f",versionNumber];
}


/**
 * 描述：设备版本比较
 * 参数：比较的版本大小
 * 返回值：YES为小过比较版本，NO反之
 *
 */
CG_INLINE BOOL versionIsLowerThan(CGFloat targetVersion) {
    CGFloat versionNumber = 0.f;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if(version){
        versionNumber = [version floatValue];
    }
    return versionNumber <= targetVersion;
}

/**
 * 描述：获取字符串长度
 * 参数：字符串
 * 返回值：字符串长度
 *
 */
CG_INLINE NSInteger getStringLength(NSString *string) {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *da = [string dataUsingEncoding:enc];
    return [da length];
}

/**
 * 描述：返回一位有效数字
 * 参数：数字
 * 返回值：字符串
 *
 */

CG_INLINE NSString *judgeFloatIsValid(float money) {
    if (fmodf(money, 1) == 0) {
        return [NSString stringWithFormat:@"%.0f",money];
    }else {
        return [NSString stringWithFormat:@"%.1f",money];
    }
}

/**
 * 描述：根据label的文字自适应label的高度
 * 参数：要自适应的label
 * 返回值：自适应后label的高度
 *
 */
CG_INLINE CGFloat fitLabelHeight(UILabel *label) {
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, 0)];
    [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect rct = label.frame;
    rct.size.height = size.height;
    label.frame = rct;
    
    return label.frame.size.height;
}


/**
 * 描述：根据label的文字自适应label的宽度
 * 参数：要自适应的label
 * 返回值：自适应后label的宽度
 *
 */
CG_INLINE CGFloat fitLabelWidth(UILabel *label) {
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeMake(0, label.frame.size.height)];
    [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rct = label.frame;
    rct.size.width = size.width;
    label.frame = rct;
    
    return label.frame.size.width;
}

/**
 * 描述：获取字符串的字符长度
 * 参数：字符串
 * 返回值：字符长度
 *
 */
CG_INLINE int getWordCount(NSString *word) {
    int i,n=[word length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[word characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}


/**
 * 描述：将16进制颜色转化为颜色
 * 参数：16进制颜色  例如:#008833
 * 返回值：转化后的颜色
 *
 */
CG_INLINE UIColor *getColor(NSString *hexColor) {
    if(!hexColor || [hexColor isEqualToString:@""] || [hexColor length] < 7){
        if (hexColor.length != 4) {
            return [UIColor whiteColor];
        }
    }
    
    if (hexColor.length == 4) {
        hexColor = [NSString stringWithFormat:@"#%c%c%c%c%c%c",[hexColor characterAtIndex:1],[hexColor characterAtIndex:1],[hexColor characterAtIndex:2],[hexColor characterAtIndex:2],[hexColor characterAtIndex:3],[hexColor characterAtIndex:3]];
    }
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

/**
 * 描述：判断字符串是否为空
 * 参数：字符串
 * 返回值：空为真，不空为假
 *
 */
CG_INLINE BOOL stringIsEmpty(NSString *string) {
    if([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return YES;
    }
    return NO;
}

/**
 * 描述：判断数值是否为空
 * 参数：数值
 * 返回值：空为真，不空为假
 *
 */
CG_INLINE BOOL numberIsEmpty(NSNumber *number) {
    if([number isKindOfClass:[NSNull class]] || (number==nil)){
        return YES;
    }
    return NO;
}


/**
 * 描述：为请求路径加上http://
 * 参数：
 * 返回值：正确的请求路径
 *
 */
CG_INLINE NSString *appendHttp(NSString *string) {
    if(!stringIsEmpty(string)){
        NSArray *results = [string componentsSeparatedByString:@"http://"];
        if([results count] < 2){
            return [NSString stringWithFormat:@"http://%@",string];
        }
    }
    return string;
}

/**
 * 描述：判断数组是否为空（包括nil，数组count为0）
 * 参数：数组
 * 返回值：空为真，不空为假
 *
 */
CG_INLINE BOOL arrayIsEmpty(NSArray *array) {
    if([array isKindOfClass:[NSNull class]]){
        return YES;
    }
    if([array count]==0 || array == nil){
        return YES;
    }
    return NO;
}

/**
 * 描述：判断字典是否为空（包括nil，数组count为0）
 * 参数：字典
 * 返回值：空为真，不空为假
 *
 */
CG_INLINE BOOL dictionaryIsEmpty(NSDictionary *dictionary) {
    if([dictionary isKindOfClass:[NSNull class]]){
        return YES;
    }
    if([dictionary count]==0 || dictionary == nil){
        return YES;
    }
    return NO;
}

/**
 * 描述：去掉字符串的空格
 * 参数：字符串
 * 返回值：去掉空格后的字符串
 *
 */
CG_INLINE NSString *trimString(NSString *string) {
    if(!stringIsEmpty(string)){
        NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return text;
    }
    return string;
}

/**
 * 描述：验证字段是否存在中文字符
 * 参数：要验证的字段
 * 返回值：真为符合，假为不符合
 *
 */
CG_INLINE BOOL existChineseWord(NSString *text) {
    for(int i=0; i< [text length];i++){
        int a = [text characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

/**
 * 描述：验证密码格式是否正确
 * 参数：password:要验证的密码  maxLength:最大的字符长度   minLength:最小的字符长度
 * 返回值：
 *
 */
CG_INLINE BOOL validatePassword(NSString *password,int minLength,int maxLength) {
    
    if (password.length<minLength||password.length>maxLength) {
        return NO;
    }
    return YES;
}


/**
 * 描述：验证字符串是否为邮箱
 * 参数：邮箱的字符串
 * 返回值：真为符合，假为不符合
 *
 */
CG_INLINE BOOL validateEmail(NSString *email) {
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length)) {
        
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        //使用compare option 来设定比较规则，如
        //NSCaseInsensitiveSearch是不区分大小写
        //NSLiteralSearch 进行完全比较,区分大小写
        //NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray){
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray){
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;
}

/**
 * 描述：验证字符串长度是否过长
 * 参数：字符串  maxLength:最大的长度
 * 返回值：真为不过长，假为超出最大长度
 *
 */
CG_INLINE BOOL validateLength(NSString *string,NSInteger maxLength) {
    if([string length] > maxLength){
        return NO;
    }
    return YES;
}

/**
 * 描述：验证字符串中是否存在特殊字符
 * 参数：字符串
 * 返回值：真为是，假为否
 *
 */
CG_INLINE BOOL validateSpecailWord(NSString *text) {
    
    NSString *regexString = @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€";
    NSRange urgentRange = [text rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:regexString]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}



/**
 * 描述：从字符串中得到NSInteger类型数值
 * 参数：字符串
 * 返回值：NSInteger类型数值
 *
 */
CG_INLINE NSInteger getIntFromString(NSString *string) {
    if([string isKindOfClass:[NSNull class]]){
        return 0;
    }
    if(!string){
        return 0;
    }
    if([string isKindOfClass:[NSString class]]){
        if(stringIsEmpty(string)){
            return 0;
        }
    }
    if([string isKindOfClass:[NSString class]]){
        if([[string lowercaseString] isEqualToString:@"<null>"] || [[string lowercaseString] isEqualToString:@"null"]){
            return 0;
        }
    }
    return [string intValue];
}

/**
 * 描述：从字符串中得到CGFloat类型数值
 * 参数：字符串
 * 返回值：CGFloat类型数值
 *
 */
CG_INLINE CGFloat getFloatFromString(NSString *string) {
    if([string isKindOfClass:[NSNull class]]){
        return 0.0f;
    }
    if(!string){
        return 0.0f;
    }
    if([string isKindOfClass:[NSString class]]){
        if(stringIsEmpty(string)){
            return 0.0f;
        }
    }
    if([string isKindOfClass:[NSString class]]){
        if([[string lowercaseString] isEqualToString:@"<null>"] || [[string lowercaseString] isEqualToString:@"null"]){
            return 0.0f;
        }
    }
    return [string floatValue];
}

/**
 * 描述：从字符串中得到Double类型数值
 * 参数：字符串
 * 返回值：Double类型数值
 *
 */
CG_INLINE CGFloat getDoubleFromString(NSString *string) {
    if([string isKindOfClass:[NSNull class]]){
        return 0.0f;
    }
    if(!string){
        return 0.0f;
    }
    if([string isKindOfClass:[NSString class]]){
        if(stringIsEmpty(string)){
            return 0.0f;
        }
    }
    if([string isKindOfClass:[NSString class]]){
        if([[string lowercaseString] isEqualToString:@"<null>"] || [[string lowercaseString] isEqualToString:@"null"]){
            return 0.0f;
        }
    }
    return [string doubleValue];
}


/**
 * 描述：判断链接是否为图片链接
 * 参数：字符串
 * 返回值：真为是图片链接 假为不是
 *
 */
CG_INLINE BOOL urlIsImageUrl(NSString *imageUrl){
    if(!stringIsEmpty(imageUrl)){
        NSString *format = @"png";
        NSString *temp = [imageUrl lowercaseString];
        if([temp hasSuffix:format]){
            return YES;
        }
        format = @"jpg";
        if([temp hasSuffix:format]){
            return YES;
        }
        format = @"bmp";
        if([temp hasSuffix:format]){
            return YES;
        }
        format = @"gif";
        if([temp hasSuffix:format]){
            return YES;
        }
        format = @"jpeg";
        if([temp hasSuffix:format]){
            return YES;
        }
        format = @"tiff";
        if([temp hasSuffix:format]){
            return YES;
        }
    }
    return NO;
}

/**
 * 描述：获取文件在document的路径
 * 参数：文件名
 * 返回值：路径
 *
 */
CG_INLINE NSString *getDocumentFilePath(NSString *filename) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:filename];
}


/**
 * 描述：将图片写入到文件里面
 * 参数：image：图片   toPath；文件路径
 * 返回值：真为写入成功  加为写入失败
 *
 */
CG_INLINE BOOL writeImage(UIImage *image,NSString *toPath) {
    if((!image) || (!toPath) || ([toPath isEqualToString:@""])){
        return NO;
    }
    
    @try {
        
        NSData *imageData = nil;
        NSString *ext = [toPath pathExtension];
        if ([ext isEqualToString:@"png"]) {
            imageData = UIImagePNGRepresentation(image);
            
        }else{
            imageData = UIImageJPEGRepresentation(image, 0);
            
        }
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        [imageData writeToFile:toPath atomically:YES];
        return YES;
    }
    @catch (NSException *e) {
        NSLog(@"create thumbnail exception.");
    }
    return NO;
}

/**
 * 描述：将图片数据写入到文件里面
 * 参数：imageData：图片数据   toPath；文件路径
 * 返回值：真为写入成功  假为写入失败
 *
 */
CG_INLINE BOOL writeImageData(NSData *imageData,NSString *toPath) {
    if((!imageData) || (!toPath) || ([toPath isEqualToString:@""])){
        return NO;
    }
    @try {
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        [imageData writeToFile:toPath atomically:YES];
        return YES;
    }
    @catch (NSException *e) {
        NSLog(@"create thumbnail exception.");
    }
    return NO;
}
/**
 * 描述：删除文件
 * 参数：filePath：文件路径
 * 返回值：真为删除成功  假为删除失败
 *
 */

CG_INLINE BOOL removeFromDocuments(NSString *filePath) {
    
    BOOL isdir = NO;
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isdir]) {
        return [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
    }
    return NO;
}

//身份证号
CG_INLINE BOOL validateIdentityCard(NSString *identityCard){
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


/**
 * 描述：截图
 * 参数：要截图的内容
 * 返回值：截取成功后的图片
 *
 */
CG_INLINE UIImage *viewToImage(UIView *view) {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 1);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return uiImage;
}

/**
 * 描述：调整好图片自身的方向
 * 参数：要调整的图片
 * 返回值：调整后图片
 *
 */
CG_INLINE UIImage* fixOrientation(UIImage *aImage) {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/**
 * 描述：对字段进行空值过滤
 * 参数：value：字段
 * 返回值：不为空的字符串
 */
CG_INLINE NSString *filterEmptyValue(NSString* value){
    if(stringIsEmpty(value)){
        return @"";
    }
    return value;
}

/**
 * 描述：对webView进行计算
 * 返回值：
 */
CG_INLINE void scaleSizeOfWebView(UIWebView *webView,BOOL bounces) {
    for(id subview in webView.subviews){
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]){
            UIScrollView *scrollView = (UIScrollView *)subview;
            scrollView.bounces = bounces;
            [webView setFrame:CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, scrollView.contentSize.height)];
        }
    }
}

/**
 * 描述：删除字符创的html标签
 * 返回值：
 */
CG_INLINE NSString *removeHtmlTags(NSString *html) {
    @try {
        NSError *error = nil;
        NSMutableString *dest = [NSMutableString stringWithCapacity:0];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<.+?>(.+?)</.+?>" options:NSRegularExpressionCaseInsensitive error:&error]; //<.+?>(.+?)</.+?>
        NSRegularExpression *regex2 = [[NSRegularExpression alloc] initWithPattern:@"(?<=>).*?(?=</.+?>)" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:html options:0 range:NSMakeRange(0, [html length])];
        
        if (numberOfMatches != 0) {
            [dest appendString:html];
            [regex enumerateMatchesInString:html options:0 range:NSMakeRange(0, [html length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                NSString *resultString = [html substringWithRange:[result range]];
                NSString *link = [resultString substringWithRange:[[regex2 firstMatchInString:resultString options:0 range:NSMakeRange(0, [resultString length])] range]];
                [dest replaceCharactersInRange:[result range] withString:link];
            }
             ];
            
            return [dest stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
        }
        else {
            return [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return html;
}

CG_INLINE NSString *htmlEntityDecode(NSString *string) {
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    string = [string stringByReplacingOccurrencesOfString:@"&hellip;" withString:@"……"];
    string = [string stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    string = [string stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    string = [string stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"’"];
    string = [string stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"‘"];
    return string;
}


CG_INLINE NSNumber *heightForTextView(UITextView *textView,NSString *strText){
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
    
    CGSize size = [strText sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    float fHeight = size.height + 16.0;
    
    return [NSNumber numberWithFloat:fHeight];
}


CG_INLINE void TTAlertNoTitle(NSString *message){
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

