//
//  NSScreen+Scale.m
//  FBSnapshotTestCase macOS
//
//  Created by Ivan Misuno on 12/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <FBSnapshotTestCase/NSScreen+Scale.h>

@implementation NSScreen (Scale)

- (CGFloat)scale {
  return self.backingScaleFactor;
}

@end
