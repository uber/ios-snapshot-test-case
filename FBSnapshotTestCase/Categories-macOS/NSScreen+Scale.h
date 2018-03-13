//
//  NSScreen+Scale.h
//  FBSnapshotTestCase macOS
//
//  Created by Ivan Misuno on 12/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSScreen (Scale)

@property (nonatomic, readonly) CGFloat scale;

@end
