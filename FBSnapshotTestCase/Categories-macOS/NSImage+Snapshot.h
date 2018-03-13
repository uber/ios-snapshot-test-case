/*
 *  Copyright (c) 2015, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <AppKit/AppKit.h>

@interface NSImage (Snapshot)

/// Uses renderInContext: to get a snapshot of the layer.
+ (NSImage *)fb_imageForLayer:(CALayer *)layer;

/// Uses renderInContext: to get a snapshot of the view layer.
+ (NSImage *)fb_imageForViewLayer:(NSView *)view;

/// Uses drawViewHierarchyInRect: to get a snapshot of the view and adds the view into a window if needed.
+ (NSImage *)fb_imageForView:(NSView *)view;

@end
