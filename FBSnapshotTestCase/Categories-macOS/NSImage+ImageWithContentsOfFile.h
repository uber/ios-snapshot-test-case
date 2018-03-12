//
//  NSImage+ImageWithContentsOfFile.h
//  FBSnapshotTestCase macOS
//
//  Created by Ivan Misuno on 12/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (ImageWithContentsOfFile)

+ (nullable instancetype)imageWithContentsOfFile:(NSString * _Nonnull)imageFilePath;

@end
