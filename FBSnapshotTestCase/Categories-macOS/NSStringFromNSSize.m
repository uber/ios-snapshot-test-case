//
//  NSStringFromNSSize.m
//  FBSnapshotTestCase macOS
//
//  Created by Ivan Misuno on 12/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <FBSnapshotTestCase/NSStringFromNSSize.h>

NSString *NSStringFromNSSize(NSSize size) {
  return [NSString stringWithFormat: @"{%lf,%lf}", size.width, size.height];
}
