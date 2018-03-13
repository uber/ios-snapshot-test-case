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

@interface NSApplication (StrictKeyWindow)

/**
  @return The receiver's @c keyWindow. Raises an assertion if @c nil.
 */
- (NSWindow *)fb_strictKeyWindow;

@end
