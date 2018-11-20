//
//  GJTCommonTool.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/15.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 查找当前正在显示的conroller */
UIViewController* GJTVisibalController(void);
/** 计算文本高度/宽度 */
CGSize GJTTextSizeWithText(NSString* text,UIFont* font,CGSize contentSize);
/** 清除tableView 多余的cell */
void GJTClearExtendCellLineForTableView(UITableView* tableView);
/** 按角度旋转view */
void GJTRotateView(UIView* view,int angle,float duration);
/** 根据颜色生成图片 */
UIImage* GJTImageFromColor(UIColor* color,CGSize size);
/** 删除指定字符 */
NSString* GJTDeleteCharacter(NSString* oldString,NSString* charcter);
/** 压缩图片 */
NSData *GJTCompressImage(UIImage *image,NSInteger maxFileSize);
/** 颠倒数组元素位置 */
NSArray* GJTUpToDownArray(NSArray* array);
/** 随机生成一个长度的中文 */
NSString* GJTRandomSingleChineseString(void);
/** 随机生成指定长度的中文 */
NSString* GJTRandomChineseString(NSUInteger length);
/** 拨打电话 */
void GJTCallPhoneInView(NSString* phone,UIView* inView);
/** 重绘图片，指定大小 */
UIImage* GJTReDrawImageWithImage(UIImage* image,CGSize size);
/** 替换图片背景颜色 */
UIImage* GJTReDrawImageBackgroundColor(UIImage* image,UIColor* backgroudColor);

NSString* GJTReplaceString(NSString* string,NSString* occurrencesString,NSString* replaceString);

NSString* GJTRandomUUID(void);

UIImage* GJTResourceImageWithName(NSString* imageName);

UIColor* GJTColorForHex(NSString* hexColor);

@interface GJTCommonTool : NSObject

@end
