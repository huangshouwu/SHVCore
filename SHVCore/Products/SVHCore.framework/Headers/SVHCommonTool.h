//
//  SVHCommonTool.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/6/15.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 查找当前正在显示的conroller */
UIViewController* SVHVisibalController(void);
/** 计算文本高度/宽度 */
CGSize SVHTextSizeWithText(NSString* text,UIFont* font,CGSize contentSize);
/** 清除tableView 多余的cell */
void SVHClearExtendCellLineForTableView(UITableView* tableView);
/** 按角度旋转view */
void SVHRotateView(UIView* view,int angle,float duration);
/** 根据颜色生成图片 */
UIImage* SVHmageFromColor(UIColor* color,CGSize size);
/** 删除指定字符 */
NSString* SVHDeleteCharacter(NSString* oldString,NSString* charcter);
/** 压缩图片 */
NSData *SVHCompressImage(UIImage *image,NSInteger maxFileSize);
/** 颠倒数组元素位置 */
NSArray* SVHUpToDownArray(NSArray* array);
/** 随机生成一个长度的中文 */
NSString* SVHRandomSingleChineseString(void);
/** 随机生成指定长度的中文 */
NSString* SVHRandomChineseString(NSUInteger length);
/** 拨打电话 */
NSString* SVHCallPhoneInView(NSString* phone,UIView* inView);
/** 重绘图片，指定大小 */
UIImage* SVHReDrawImageWithImage(UIImage* image,CGSize size);
/** 替换图片背景颜色 */
UIImage* SVHReDrawImageBackgroundColor(UIImage* image,UIColor* backgroudColor);

NSString* SVHReplaceString(NSString* string,NSString* occurrencesString,NSString* replaceString);

NSString* SVHRandomUUID(void);

UIImage* SVHResourceImageWithName(NSString* imageName);

UIColor* SVHColorForHex(NSString* hexColor);
