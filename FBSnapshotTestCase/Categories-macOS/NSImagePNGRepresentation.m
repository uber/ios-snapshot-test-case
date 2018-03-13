//
//  NSImagePNGRepresentation.m
//  FBSnapshotTestCase macOS
//
//  Created by Ivan Misuno on 12/03/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Quartz/Quartz.h>
#import <FBSnapshotTestCase/NSImagePNGRepresentation.h>

NSData *NSImagePNGRepresentation(NSImage *image) {
  CGImageRef cgRef = [image CGImageForProposedRect:nil context:nil hints:nil];
  NSBitmapImageRep *newRep = [[NSBitmapImageRep alloc] initWithCGImage:cgRef];
  [newRep setSize:[image size]];   // if you want the same resolution
  NSData *pngData = [newRep representationUsingType:NSPNGFileType properties:@{}];
  return pngData;
}
