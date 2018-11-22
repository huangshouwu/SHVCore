//
//  UIImage+BackgroundColor.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/8/15.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "UIImage+BackgroundColor.h"

@implementation UIImage (BackgroundColor)

void rgbToHSV(float *rgb, float *hsv) {
    float min, max, delta;
    float r = rgb[0], g = rgb[1], b = rgb[2];
    float *h = hsv, *s = hsv + 1, *v = hsv + 2;
    min = fmin(fmin(r, g), b );
    max = fmax(fmax(r, g), b );
    *v = max;
    delta = max - min;
    if( max != 0 )
        *s = delta / max;
    else {
        *s = 0;
        *h = -1;
        return;
    }
    if( r == max )
        *h = ( g - b ) / delta;
    else if( g == max )
        *h = 2 + ( b - r ) / delta;
    else
        *h = 4 + ( r - g ) / delta;
    *h *= 60;
    if( *h < 0 )
        *h += 360;
}

- (UIImage *)removeColorWithMinHueAngle:(float)minHueAngle maxHueAngle:(float)maxHueAngle{
    CIImage *image = [CIImage imageWithCGImage:self.CGImage];
    CIContext *context = [CIContext contextWithOptions:nil];// kCIContextUseSoftwareRenderer : CPURender
    /** 注意
     * UIImage 通过CIimage初始化，得到的并不是一个通过类似CGImage的标准UIImage
     * 所以如果不用context进行渲染处理，是没办法正常显示的
     */
    CIImage *renderBgImage = [self outputImageWithOriginalCIImage:image minHueAngle:minHueAngle maxHueAngle:maxHueAngle];
    CGImageRef renderImg = [context createCGImage:renderBgImage fromRect:image.extent];
    UIImage *renderImage = [UIImage imageWithCGImage:renderImg];
    return renderImage;
}
struct CubeMap {
    int length;
    float dimension;
    float *data;
};

- (CIImage *)outputImageWithOriginalCIImage:(CIImage *)originalImage minHueAngle:(float)minHueAngle maxHueAngle:(float)maxHueAngle{
    
    struct CubeMap map = createCubeMap(minHueAngle, maxHueAngle);
    const unsigned int size = 64;
    // Create memory with the cube data
    NSData *data = [NSData dataWithBytesNoCopy:map.data
                                        length:map.length
                                  freeWhenDone:YES];
    CIFilter *colorCube = [CIFilter filterWithName:@"CIColorCube"];
    [colorCube setValue:@(size) forKey:@"inputCubeDimension"];
    // Set data for cube
    [colorCube setValue:data forKey:@"inputCubeData"];
    
    [colorCube setValue:originalImage forKey:kCIInputImageKey];
    CIImage *result = [colorCube valueForKey:kCIOutputImageKey];
    
    return result;
}
struct CubeMap createCubeMap(float minHueAngle, float maxHueAngle) {
    const unsigned int size = 64;
    struct CubeMap map;
    map.length = size * size * size * sizeof (float) * 4;
    map.dimension = size;
    float *cubeData = (float *)malloc (map.length);
    float rgb[3], hsv[3], *c = cubeData;
    
    for (int z = 0; z < size; z++){
        rgb[2] = ((double)z)/(size-1); // Blue value
        for (int y = 0; y < size; y++){
            rgb[1] = ((double)y)/(size-1); // Green value
            for (int x = 0; x < size; x ++){
                rgb[0] = ((double)x)/(size-1); // Red value
                rgbToHSV(rgb,hsv);
                // Use the hue value to determine which to make transparent
                // The minimum and maximum hue angle depends on
                // the color you want to remove
                float alpha = (hsv[0] > minHueAngle && hsv[0] < maxHueAngle) ? 0.0f: 1.0f;
                // Calculate premultiplied alpha values for the cube
                c[0] = rgb[0] * alpha;
                c[1] = rgb[1] * alpha;
                c[2] = rgb[2] * alpha;
                c[3] = alpha;
                c += 4; // advance our pointer into memory for the next color value
            }
        }
    }
    map.data = cubeData;
    return map;
}

@end
