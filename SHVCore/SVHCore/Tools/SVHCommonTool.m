//
//  SVHCommonTool.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/15.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHCommonTool.h"


UIViewController* SVHFindTopModelViewController(UIViewController* vc){
    if (vc.presentedViewController) {
        while (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }
    }else {
        vc = nil;
    }
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController*)vc visibleViewController];
    }
    
    return vc;
}

UIViewController* SVHVisibalController(){
    UIViewController* appRootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    UIViewController* visibalVC = nil;
    if ([appRootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tableBarVC = (UITabBarController*)appRootViewController;
        if (tableBarVC.presentedViewController) {
            visibalVC = SVHFindTopModelViewController(tableBarVC);
        }else {
            UINavigationController* selectedNav = (UINavigationController*)tableBarVC.selectedViewController;
            
            if (selectedNav.presentedViewController) {
                visibalVC = SVHFindTopModelViewController(selectedNav);
            }else {
                visibalVC = selectedNav.topViewController;
            }
        }
    }else {
        if (appRootViewController.presentedViewController) {
            visibalVC = SVHFindTopModelViewController(appRootViewController);
        }else {
            visibalVC = appRootViewController;
        }
    }
    return visibalVC;
}

CGSize SVHTextSizeWithText(NSString* text,UIFont* font,CGSize contentSize){
    return [text boundingRectWithSize:contentSize
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{NSFontAttributeName:font}
                               context:nil].size;
}

void SVHClearExtendCellLineForTableView(UITableView* tableView){
    if (!tableView.tableFooterView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor clearColor];
        [tableView setTableFooterView:view];
    }
}

/** 按角度旋转view */
void SVHRotateView(UIView* view,int angle,float duration){
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [view layer].transform = CATransform3DMakeRotation(M_PI*angle/180.0, 0.0f, 0.0f, 1.0f);
    [UIView commitAnimations];
}

UIImage* SVHmageFromColor(UIColor* color,CGSize size){
    CGRect rect = CGRectMake(0, 0, size.width,size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/** 重绘图片，指定大小 */
UIImage* SVHReDrawImageWithImage(UIImage* image,CGSize size){
    CGFloat scale = image.scale;
    CGImageRef tempRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, size.width * scale, size.height * scale));
    UIImage * newImage = [UIImage imageWithCGImage:tempRef scale:scale orientation:UIImageOrientationUp];
    CGImageRelease(tempRef);
    return newImage;
}

NSString* SVHDeleteCharacter(NSString* oldString,NSString* charcter){
    if (!oldString.length) {
        return oldString;
    }
    NSMutableString* oldStr = [NSMutableString stringWithString:oldString];
    NSRange subRange = [oldStr rangeOfString:charcter];
    while (subRange.location!=NSNotFound) {
        [oldStr deleteCharactersInRange:subRange];
        subRange = [oldStr rangeOfString:charcter];
    }
    return oldStr;
}

NSData *SVHCompressImage(UIImage *image,NSInteger maxFileSize){
//    CGFloat compression = 0.3;
//    NSData *data = UIImageJPEGRepresentation(image, compression);
//    while (data.length > maxFileSize && compression > 0) {
//        compression -= 0.1;
//        data = UIImageJPEGRepresentation(image, compression);
//    }
    
//    NSData *fileData = UIImagePNGRepresentation(image);
//    NSLog(@"Before compress: %ld bytes", fileData.length);
//
//    uint8_t dstBuffer[fileData.length];
//    memset(dstBuffer, 0, fileData.length);
//    if (@available(iOS 9.0, *)) {
//        size_t compressResultLength = compression_encode_buffer(dstBuffer, fileData.length, [fileData bytes], fileData.length, NULL, COMPRESSION_LZFSE);
//        if(compressResultLength > 0) {
//            NSData *dataAfterCompress = [NSData dataWithBytes:dstBuffer length:compressResultLength];
//
//                    NSLog(@"Compress successfully. After compress：%ld bytes", dataAfterCompress.length);
//            if (dataAfterCompress) {
//                return dataAfterCompress;
//            }else {
//                return fileData;
//            }
//        } else {
//
//            CGFloat compression = 0.3;
//            NSData *data = UIImageJPEGRepresentation(image, compression);
//            while (data.length > maxFileSize && compression > 0) {
//                compression -= 0.1;
//                data = UIImageJPEGRepresentation(image, compression);
//            }
//            return data;
//        }
//    }
//    return fileData;
    
    //进行图像尺寸的压缩
    CGSize imageSize = image.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}
/** 颠倒数组元素位置 */
NSArray* SVHUpToDownArray(NSArray* array){
    if (array.count == 1) {
        return array;
    }
    NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = array.count-1; i>=0; i--) {
        [tempArray addObject:array[i]];
    }
    return tempArray;
}

NSString* SVHRandomSingleChineseString(){
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
    
    NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
    NSInteger number = (randomH<<8)+randomL;
    NSData *data = [NSData dataWithBytes:&number length:2];
    return [[NSString alloc] initWithData:data encoding:gbkEncoding];
}

NSString* SVHRandomChineseString(NSUInteger length){
    if (length >0) {
        NSMutableString *string = [[NSMutableString alloc] initWithCapacity:0];
        for (NSInteger i =0 ; i<length; i++) {
            [string appendString:SVHRandomSingleChineseString()];
        }
        return string;
    }else {
        return SVHRandomSingleChineseString();
    }
}

/** 拨打电话 */
NSString* SVHCallPhoneInView(NSString* phone,UIView* inView){
    NSString *strDeviceType = [UIDevice currentDevice].model;
    if([strDeviceType  isEqualToString:@"iPod touch"] || [strDeviceType  isEqualToString:@"iPad"] || [strDeviceType  isEqualToString:@"iPhone Simulator"]){
        return @"您的设备不支持拨打电话功能！";
    }else {
        NSURL* URL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
        if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
            [callPhoneWebVw loadRequest:[NSURLRequest requestWithURL:URL]];
            [inView addSubview:callPhoneWebVw];
        }else {
            return [NSString stringWithFormat:@"无法拨打电话:%@",phone];
        }
    }
    return nil;
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

/** 替换图片背景颜色 */
UIImage* SVHReDrawImageBackgroundColor(UIImage* image,UIColor* backgroudColor){
        // 分配内存
        const int imageWidth = image.size.width;
        const int imageHeight = image.size.height;
        CGImageRef imageRef = image.CGImage;
        size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
        uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
        // 创建context
    
        CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);//CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpace,
                                                     
                                                     kCGImageAlphaLast | kCGBitmapByteOrder32Little);
        
        CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), imageRef);
        // 遍历像素
        int pixelNum = imageWidth * imageHeight;
        uint32_t* pCurPtr = rgbImageBuf;
        for (int i = 0; i < pixelNum; i++, pCurPtr++){
            //接近粉色
            //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
            //分别取出RGB值后。进行判断需不需要设成透明。
            uint8_t* ptr = (uint8_t*)pCurPtr;
//             NSLog(@"1是%d,2是%d,3是%d",ptr[1],ptr[2],ptr[3]);
            if(ptr[1] == 255 && ptr[2] == 255 && ptr[3] == 255){
                ptr[0] = 0;
            }
        }
        // 将内存转成image
//        CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context);
    UIImage* decompressedImage = [UIImage imageWithCGImage:decompressedImageRef
                                                     scale:[[UIScreen mainScreen] scale]
                                               orientation:UIImageOrientationUp];
    CGImageRelease(decompressedImageRef);
    CGContextRelease(context);
//        CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,
//
//                                            kCGImageAlphaPremultipliedLast |kCGBitmapByteOrder32Little, dataProvider,
    
//                                            NULL, true,kCGRenderingIntentDefault);
//        CGDataProviderRelease(dataProvider);
//        UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
//        // 释放
        CGColorSpaceRelease(colorSpace);
        return decompressedImage;
}

NSString* SVHReplaceString(NSString* string,NSString* occurrencesString,NSString* replaceString){
    if (!string) {
        return @"";
    }
    return [string stringByReplacingOccurrencesOfString:occurrencesString withString:replaceString];
}

NSString* SVHRandomUUID(void){
    return [[NSUUID UUID] UUIDString];
}

UIImage* SVHResourceImageWithName(NSString* imageName){
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"SVHCore" ofType:@"bundle"];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageName];
    UIImage *img = [UIImage imageNamed:imagePath];
    return img;
}


UIColor* SVHColorForHex(NSString* hexColor){
    if (hexColor.length) {
        NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        // String should be 6 or 8 characters
        
        if ([cString length] < 6) return [UIColor blackColor];
        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
        if ([cString length] != 6) return [UIColor blackColor];
        
        // Separate into r, g, b substrings
        
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int r, g, b;
        
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    }else {
        return nil;
    }
}
