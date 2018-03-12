/*
 *  Copyright (c) 2015, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <FBSnapshotTestCase/NSImage+Snapshot.h>
#import <FBSnapshotTestCase/NSApplication+StrictKeyWindow.h>

@implementation NSImage (Snapshot)

+ (NSImage *)fb_imageForLayer:(CALayer *)layer
{
  NSRect bounds = layer.bounds;
  NSInteger width = bounds.size.width;
  NSInteger height = bounds.size.height;
  NSAssert1(width, @"Zero width for layer %@", layer);
  NSAssert1(height, @"Zero height for layer %@", layer);

  NSBitmapImageRep * imageRepresentation = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil pixelsWide:width pixelsHigh:height bitsPerSample:8 samplesPerPixel:4 hasAlpha:true isPlanar:false colorSpaceName:NSDeviceRGBColorSpace bytesPerRow:0 bitsPerPixel:0];
  imageRepresentation.size = bounds.size;

  NSGraphicsContext * context = [NSGraphicsContext graphicsContextWithBitmapImageRep: imageRepresentation];
  [layer layoutIfNeeded];
  [layer renderInContext: context.CGContext];

  return [[NSImage alloc] initWithCGImage:imageRepresentation.CGImage size:bounds.size];
}

+ (NSImage *)fb_imageForViewLayer:(NSView *)view
{
  [view layoutSubtreeIfNeeded];
  return [self fb_imageForLayer:view.layer];
}

+ (NSImage *)fb_imageForView:(NSView *)view
{
  // If the input view is already a UIWindow, then just use that. Otherwise wrap in a window.
  NSWindow *window = [view isKindOfClass:[NSWindow class]] ? (NSWindow *)view : view.window;
  BOOL removeFromSuperview = NO;
  if (!window) {
    window = [[NSApplication sharedApplication] fb_strictKeyWindow];
  }
  if (!view.window && (NSWindow *)view != window) {
    [window.contentView addSubview:view];
    removeFromSuperview = YES;
  }
  [view layoutSubtreeIfNeeded];

  NSRect bounds = view.bounds;
  NSAssert1(CGRectGetWidth(bounds), @"Zero width for view %@", view);
  NSAssert1(CGRectGetHeight(bounds), @"Zero height for view %@", view);

  NSSize viewSize = bounds.size;

  NSBitmapImageRep * bir = [view bitmapImageRepForCachingDisplayInRect:bounds];
  bir.size = viewSize;

  [view cacheDisplayInRect:bounds toBitmapImageRep:bir];

  NSImage* rv = [[NSImage alloc] initWithSize:viewSize];
  [rv addRepresentation:bir];

  if (removeFromSuperview) {
    [view removeFromSuperview];
  }

  return rv;
}

@end
