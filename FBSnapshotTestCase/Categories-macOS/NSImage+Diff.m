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

#import <FBSnapshotTestCase/NSImage+Diff.h>

@implementation NSImage (Diff)

- (NSImage *)fb_diffWithImage:(NSImage *)image
{
  if (!image) {
    return nil;
  }
  CGSize imageSize = CGSizeMake(MAX(self.size.width, image.size.width), MAX(self.size.height, image.size.height));
  NSImage *resultImage = [[NSImage alloc] initWithSize:imageSize];
  NSBitmapImageRep* rep = [[NSBitmapImageRep alloc]
                           initWithBitmapDataPlanes:NULL
                           pixelsWide:imageSize.width
                           pixelsHigh:imageSize.height
                           bitsPerSample:8
                           samplesPerPixel:4
                           hasAlpha:YES
                           isPlanar:NO
                           colorSpaceName:NSCalibratedRGBColorSpace
                           bytesPerRow:0
                           bitsPerPixel:0];
  [resultImage addRepresentation:rep];
  [resultImage lockFocus];

  CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
  [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
  CGContextSetAlpha(context, 0.5);
  CGContextBeginTransparencyLayer(context, NULL);
  [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
  CGContextSetBlendMode(context, kCGBlendModeDifference);
  CGContextSetFillColorWithColor(context,[NSColor whiteColor].CGColor);
  CGContextFillRect(context, CGRectMake(0, 0, self.size.width, self.size.height));
  CGContextEndTransparencyLayer(context);
  [resultImage unlockFocus];

  return resultImage;
}

@end
