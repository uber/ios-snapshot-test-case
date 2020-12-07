/*
 *  Copyright (c) 2017-2018, Uber Technologies, Inc.
 *  Copyright (c) 2015-2018, Facebook, Inc.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <FBSnapshotTestCase/FBSnapshotTestController.h>

@implementation FBSnapshotTestCase {
    FBSnapshotTestController *_snapshotController;
}

#pragma mark - Overrides

- (void)setUp
{
    [super setUp];
    _snapshotController = [[FBSnapshotTestController alloc] initWithTestClass:[self class]];
}

- (void)tearDown
{
    _snapshotController = nil;
    [super tearDown];
}

- (BOOL)recordMode
{
    return _snapshotController.recordMode;
}

- (void)setRecordMode:(BOOL)recordMode
{
    NSAssert1(_snapshotController, @"%s cannot be called before [super setUp]", __FUNCTION__);
    _snapshotController.recordMode = recordMode;
}

- (FBSnapshotTestCaseFileNameIncludeOption)fileNameOptions
{
    return _snapshotController.fileNameOptions;
}

- (void)setFileNameOptions:(FBSnapshotTestCaseFileNameIncludeOption)fileNameOptions
{
    NSAssert1(_snapshotController, @"%s cannot be called before [super setUp]", __FUNCTION__);
    _snapshotController.fileNameOptions = fileNameOptions;
}

- (BOOL)usesDrawViewHierarchyInRect
{
    return _snapshotController.usesDrawViewHierarchyInRect;
}

- (void)setUsesDrawViewHierarchyInRect:(BOOL)usesDrawViewHierarchyInRect
{
    NSAssert1(_snapshotController, @"%s cannot be called before [super setUp]", __FUNCTION__);
    _snapshotController.usesDrawViewHierarchyInRect = usesDrawViewHierarchyInRect;
}

- (NSString *)folderName
{
    return _snapshotController.folderName;
}

- (void)setFolderName:(NSString *)folderName
{
    _snapshotController.folderName = folderName;
}

#pragma mark - Public API

- (NSString *)snapshotVerifyViewOrLayerOrImage:(id)viewOrLayerOrImage
                                    identifier:(NSString *)identifier
                                      suffixes:(NSOrderedSet *)suffixes
                              overallTolerance:(CGFloat)overallTolerance
                     defaultReferenceDirectory:(NSString *)defaultReferenceDirectory
                     defaultImageDiffDirectory:(NSString *)defaultImageDiffDirectory
{
    return [self snapshotVerifyViewOrLayerOrImage:viewOrLayerOrImage
                                       identifier:identifier
                                         suffixes:suffixes
                                perPixelTolerance:0
                                 overallTolerance:overallTolerance
                        defaultReferenceDirectory:defaultReferenceDirectory
                        defaultImageDiffDirectory:defaultImageDiffDirectory];
}

- (NSString *)snapshotVerifyViewOrLayerOrImage:(id)viewOrLayerOrImage
                                    identifier:(NSString *)identifier
                                      suffixes:(NSOrderedSet *)suffixes
                             perPixelTolerance:(CGFloat)perPixelTolerance
                              overallTolerance:(CGFloat)overallTolerance
                     defaultReferenceDirectory:(NSString *)defaultReferenceDirectory
                     defaultImageDiffDirectory:(NSString *)defaultImageDiffDirectory
{
    if (viewOrLayerOrImage == nil) {
        return @"Object to be snapshotted must not be nil";
    }

    NSString *referenceImageDirectory = [self getReferenceImageDirectoryWithDefault:defaultReferenceDirectory];
    if (referenceImageDirectory == nil) {
        return @"Missing value for referenceImagesDirectory - Set FB_REFERENCE_IMAGE_DIR as an Environment variable in your scheme.";
    }

    NSString *imageDiffDirectory = [self getImageDiffDirectoryWithDefault:defaultImageDiffDirectory];
    if (imageDiffDirectory == nil) {
        return @"Missing value for imageDiffDirectory - Set IMAGE_DIFF_DIR as an Environment variable in your scheme.";
    }

    if (suffixes.count == 0) {
        return [NSString stringWithFormat:@"Suffixes set cannot be empty %@", suffixes];
    }

    NSError *error = nil;
    NSMutableArray *errors = [NSMutableArray array];

    if (self.recordMode) {
        NSString *referenceImagesDirectory = [NSString stringWithFormat:@"%@%@", referenceImageDirectory, suffixes.firstObject];
        BOOL referenceImageSaved = [self _compareSnapshotOfViewOrLayerOrImage:viewOrLayerOrImage referenceImagesDirectory:referenceImagesDirectory imageDiffDirectory:imageDiffDirectory identifier:(identifier) perPixelTolerance:perPixelTolerance overallTolerance:overallTolerance error:&error];
        if (!referenceImageSaved) {
            [errors addObject:error];
        }

        return @"Test ran in record mode. Reference image is now saved. Disable record mode to perform an actual snapshot comparison!";
    } else {
        BOOL testSuccess = NO;
        for (NSString *suffix in suffixes) {
            NSString *referenceImagesDirectory = [NSString stringWithFormat:@"%@%@", referenceImageDirectory, suffix];
            BOOL referenceImageAvailable = [self referenceImageRecordedInDirectory:referenceImagesDirectory identifier:(identifier) error:&error];

            if (referenceImageAvailable) {
                BOOL comparisonSuccess = [self _compareSnapshotOfViewOrLayerOrImage:viewOrLayerOrImage referenceImagesDirectory:referenceImagesDirectory imageDiffDirectory:imageDiffDirectory identifier:identifier perPixelTolerance:perPixelTolerance overallTolerance:overallTolerance error:&error];
                [errors removeAllObjects];
                if (comparisonSuccess) {
                    testSuccess = YES;
                    break;
                } else {
                    [errors addObject:error];
                }
            } else {
                [errors addObject:error];
            }
        }

        if (!testSuccess) {
            return [NSString stringWithFormat:@"Snapshot comparison failed: %@", errors.firstObject];
        } else {
            return nil;
        }
    }
}

- (BOOL)compareSnapshotOfLayer:(CALayer *)layer
      referenceImagesDirectory:(NSString *)referenceImagesDirectory
            imageDiffDirectory:(NSString *)imageDiffDirectory
                    identifier:(NSString *)identifier
              overallTolerance:(CGFloat)overallTolerance
                         error:(NSError **)errorPtr
{
    return [self _compareSnapshotOfViewOrLayerOrImage:layer
                             referenceImagesDirectory:referenceImagesDirectory
                                   imageDiffDirectory:imageDiffDirectory
                                           identifier:identifier
                                    perPixelTolerance:0
                                     overallTolerance:overallTolerance
                                                error:errorPtr];
}

- (BOOL)compareSnapshotOfLayer:(CALayer *)layer
      referenceImagesDirectory:(NSString *)referenceImagesDirectory
            imageDiffDirectory:(NSString *)imageDiffDirectory
                    identifier:(NSString *)identifier
             perPixelTolerance:(CGFloat)perPixelTolerance
              overallTolerance:(CGFloat)overallTolerance
                         error:(NSError **)errorPtr
{
    return [self _compareSnapshotOfViewOrLayerOrImage:layer
                             referenceImagesDirectory:referenceImagesDirectory
                                   imageDiffDirectory:(NSString *)imageDiffDirectory
                                           identifier:identifier
                                    perPixelTolerance:perPixelTolerance
                                     overallTolerance:overallTolerance
                                                error:errorPtr];
}

- (BOOL)compareSnapshotOfView:(UIView *)view
     referenceImagesDirectory:(NSString *)referenceImagesDirectory
           imageDiffDirectory:(NSString *)imageDiffDirectory
                   identifier:(NSString *)identifier
             overallTolerance:(CGFloat)overallTolerance
                        error:(NSError **)errorPtr
{
    return [self _compareSnapshotOfViewOrLayerOrImage:view
                             referenceImagesDirectory:referenceImagesDirectory
                                   imageDiffDirectory:imageDiffDirectory
                                           identifier:identifier
                                    perPixelTolerance:0
                                     overallTolerance:overallTolerance
                                                error:errorPtr];
}

- (BOOL)compareSnapshotOfView:(UIView *)view
     referenceImagesDirectory:(NSString *)referenceImagesDirectory
           imageDiffDirectory:(NSString *)imageDiffDirectory
                   identifier:(NSString *)identifier
            perPixelTolerance:(CGFloat)perPixelTolerance
             overallTolerance:(CGFloat)overallTolerance
                        error:(NSError **)errorPtr
{
    return [self _compareSnapshotOfViewOrLayerOrImage:view
                             referenceImagesDirectory:referenceImagesDirectory
                                   imageDiffDirectory:(NSString *)imageDiffDirectory
                                           identifier:identifier
                                    perPixelTolerance:perPixelTolerance
                                     overallTolerance:overallTolerance
                                                error:errorPtr];
}

- (BOOL)compareSnapshotOfImage:(UIImage *)image
      referenceImagesDirectory:(NSString *)referenceImagesDirectory
            imageDiffDirectory:(NSString *)imageDiffDirectory
                    identifier:(NSString *)identifier
              overallTolerance:(CGFloat)overallTolerance
                         error:(NSError **)errorPtr
{
    return [self _compareSnapshotOfViewOrLayerOrImage:image
                             referenceImagesDirectory:referenceImagesDirectory
                                   imageDiffDirectory:imageDiffDirectory
                                           identifier:identifier
                                    perPixelTolerance:0
                                     overallTolerance:overallTolerance
                                                error:errorPtr];
}

- (BOOL)compareSnapshotOfImage:(UIImage *)image
      referenceImagesDirectory:(NSString *)referenceImagesDirectory
            imageDiffDirectory:(NSString *)imageDiffDirectory
                    identifier:(NSString *)identifier
             perPixelTolerance:(CGFloat)perPixelTolerance
              overallTolerance:(CGFloat)overallTolerance
                         error:(NSError **)errorPtr
{
    return [self _compareSnapshotOfViewOrLayerOrImage:image
                             referenceImagesDirectory:referenceImagesDirectory
                                   imageDiffDirectory:(NSString *)imageDiffDirectory
                                           identifier:identifier
                                    perPixelTolerance:perPixelTolerance
                                     overallTolerance:overallTolerance
                                                error:errorPtr];
}

- (BOOL)referenceImageRecordedInDirectory:(NSString *)referenceImagesDirectory
                               identifier:(NSString *)identifier
                                    error:(NSError **)errorPtr
{
    NSAssert1(_snapshotController, @"%s cannot be called before [super setUp]", __FUNCTION__);
    _snapshotController.referenceImagesDirectory = referenceImagesDirectory;
    UIImage *referenceImage = [_snapshotController referenceImageForSelector:self.invocation.selector
                                                                  identifier:identifier
                                                                       error:errorPtr];

    return (referenceImage != nil);
}

- (NSString *)getReferenceImageDirectoryWithDefault:(NSString *)dir
{
    NSString *envReferenceImageDirectory = [NSProcessInfo processInfo].environment[@"FB_REFERENCE_IMAGE_DIR"];
    if (envReferenceImageDirectory) {
        return envReferenceImageDirectory;
    }
    if (dir && dir.length > 0) {
        return dir;
    }
    return [[NSBundle bundleForClass:self.class].resourcePath stringByAppendingPathComponent:@"ReferenceImages"];
}

- (NSString *)getImageDiffDirectoryWithDefault:(NSString *)dir
{
    NSString *envImageDiffDirectory = [NSProcessInfo processInfo].environment[@"IMAGE_DIFF_DIR"];
    if (envImageDiffDirectory) {
        return envImageDiffDirectory;
    }
    if (dir && dir.length > 0) {
        return dir;
    }
    return NSTemporaryDirectory();
}

#pragma mark - Private API

- (BOOL)_compareSnapshotOfViewOrLayerOrImage:(id)viewOrLayerOrImage
                    referenceImagesDirectory:(NSString *)referenceImagesDirectory
                          imageDiffDirectory:(NSString *)imageDiffDirectory
                                  identifier:(NSString *)identifier
                           perPixelTolerance:(CGFloat)perPixelTolerance
                            overallTolerance:(CGFloat)overallTolerance
                                       error:(NSError **)errorPtr
{
    _snapshotController.referenceImagesDirectory = referenceImagesDirectory;
    _snapshotController.imageDiffDirectory = imageDiffDirectory;
    return [_snapshotController compareSnapshotOfViewOrLayerOrImage:viewOrLayerOrImage
                                                           selector:self.invocation.selector
                                                         identifier:identifier
                                                  perPixelTolerance:perPixelTolerance
                                                   overallTolerance:overallTolerance
                                                              error:errorPtr];
}

@end
