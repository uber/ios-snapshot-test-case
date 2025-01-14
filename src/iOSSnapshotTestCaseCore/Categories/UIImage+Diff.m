//
//  Created by Gabriel Handford on 3/1/09.
//  Copyright 2009-2013. All rights reserved.
//  Created by John Boiles on 10/20/11.
//  Copyright (c) 2011. All rights reserved
//  Modified by Felix Schulze on 2/11/13.
//  Copyright 2013. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#if SWIFT_PACKAGE
#import "UIImage+Diff.h"
#else
#import <FBSnapshotTestCase/UIImage+Diff.h>
#endif

@implementation UIImage (Diff)

- (UIImage *)fb_diffWithImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }

    CGFloat scaleFactor = self.scale / (MAX(self.scale, image.scale));
    CGAffineTransform scaleTransform = CGAffineTransformScale(CGAffineTransformIdentity, scaleFactor, scaleFactor);
    CGSize scaledSize = CGSizeApplyAffineTransform(self.size, scaleTransform);

    CGFloat imageScaleFactor = image.scale / (MAX(self.scale, image.scale));
    CGAffineTransform imageScaleTransform = CGAffineTransformScale(CGAffineTransformIdentity, imageScaleFactor, imageScaleFactor);
    CGSize imageScaledSize = CGSizeApplyAffineTransform(image.size, imageScaleTransform);

    CGSize imageSize = CGSizeMake(MAX(scaledSize.width, imageScaledSize.width), MAX(scaledSize.height, imageScaledSize.height));
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInRect:CGRectMake(0, 0, scaledSize.width, scaledSize.height)];
    CGContextSetAlpha(context, 0.5);
    CGContextBeginTransparencyLayer(context, NULL);
    [image drawInRect:CGRectMake(0, 0, imageScaledSize.width, imageScaledSize.height)];
    CGContextSetBlendMode(context, kCGBlendModeDifference);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, scaledSize.width, scaledSize.height));
    CGContextEndTransparencyLayer(context);
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

@end
