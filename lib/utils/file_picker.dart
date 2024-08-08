
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../provider/auth_provider.dart';

const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};

class SelectedFile {
  const SelectedFile({
    this.storagePath = '',
    this.filePath,
    required this.bytes,
    this.dimensions,
    this.blurHash,
  });
  final String storagePath;
  final String? filePath;
  final Uint8List bytes;
  final MediaDimensions? dimensions;
  final String? blurHash;
}

class MediaDimensions {
  const MediaDimensions({
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
}

enum MediaSource {
  photoGallery,
  videoGallery,
  camera,
}

Future<List<SelectedFile>?> selectMediaWithSourceBottomSheet({
  required BuildContext context,
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  required bool allowPhoto,
  bool allowVideo = false,
  String pickerFontFamily = 'Roboto',
  Color textColor = const Color(0xFF111417),
  Color? backgroundColor,
  bool includeDimensions = false,
  bool includeBlurHash = false,
}) async {
  createUploadMediaListTile(String label, MediaSource mediaSource) => ListTile(
    // use borderradius variable to dynamically change the border radius
    shape: RoundedRectangleBorder(),
        title: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            pickerFontFamily,
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        tileColor: Theme.of(context).scaffoldBackgroundColor,
        dense: false,
        onTap: () => Navigator.pop(
          context,
          mediaSource,
        ),
      );
  final mediaSource = await showModalBottomSheet<MediaSource>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!kIsWeb) ...[
              Container(
                // add border radius to top left and top right
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: ListTile(
                    title: Text(
                      'Choose Source',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        pickerFontFamily,
                        color: textColor.withOpacity(0.65),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    tileColor: Theme.of(context).scaffoldBackgroundColor,
                    dense: false,
                  ),
                ),
              ),
              const Divider(),
            ],
            if (allowPhoto && allowVideo) ...[
              createUploadMediaListTile(
                'Gallery (Photo)',
                MediaSource.photoGallery,
              ),
              const Divider(),
              createUploadMediaListTile(
                'Gallery (Video)',
                MediaSource.videoGallery,
              ),
            ] else if (allowPhoto)
              createUploadMediaListTile(
                'Gallery',
                MediaSource.photoGallery,
              )
            else
              createUploadMediaListTile(
                'Gallery',
                MediaSource.videoGallery,
              ),
            if (!kIsWeb) ...[
              const Divider(),
              createUploadMediaListTile('Camera', MediaSource.camera),
              // const Divider(),
            ],
            const SizedBox(height: 10),
          ],
        );
      });
  if (mediaSource == null) {
    return null;
  }
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  return selectMedia(
    authProvider: authProvider,
    storageFolderPath: storageFolderPath,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
    isVideo: mediaSource == MediaSource.videoGallery ||
        (mediaSource == MediaSource.camera && allowVideo && !allowPhoto),
    mediaSource: mediaSource,
    includeDimensions: includeDimensions,
    includeBlurHash: includeBlurHash,
  );
}

// Future<List<SelectedFile>?> selectMedia({
//   required AuthProvider authProvider,
//   String? storageFolderPath,
//   double? maxWidth,
//   double? maxHeight,
//   int? imageQuality,
//   bool isVideo = false,
//   MediaSource mediaSource = MediaSource.camera,
//   bool multiImage = false,
//   bool includeDimensions = false,
//   bool includeBlurHash = false,
// }) async {
//   final picker = ImagePicker();

//   if (multiImage) {
//     final pickedMediaFuture = picker.pickMultiImage(
//       maxWidth: maxWidth,
//       maxHeight: maxHeight,
//       imageQuality: imageQuality,
//     );
//     final pickedMedia = await pickedMediaFuture;
//     if (pickedMedia.isEmpty) {
//       return null;
//     }
//     return Future.wait(pickedMedia.asMap().entries.map((e) async {
//       final index = e.key;
//       final media = e.value;
//       final mediaBytes = await media.readAsBytes();
//       final path = _getStoragePath(
//           authProvider, storageFolderPath, media.name, false, index);
//       final dimensions = includeDimensions
//           ? isVideo
//               ? _getVideoDimensions(media.path)
//               : _getImageDimensions(mediaBytes)
//           : null;

//       // print('Picked media: $mediaBytes');
//       return SelectedFile(
//         storagePath: path,
//         filePath: media.path,
//         bytes: mediaBytes,
//         dimensions: await dimensions,
//       );
//     }));
//   }

//   final source = mediaSource == MediaSource.camera
//       ? ImageSource.camera
//       : ImageSource.gallery;
//   final pickedMediaFuture = isVideo
//       ? picker.pickVideo(source: source)
//       : picker.pickImage(
//           maxWidth: maxWidth,
//           maxHeight: maxHeight,
//           imageQuality: imageQuality,
//           source: source,
//         );
//   final pickedMedia = await pickedMediaFuture;
//   final mediaBytes = await pickedMedia?.readAsBytes();
//   // print('Single picked media bytes: $mediaBytes');
//   if (mediaBytes == null) {
//     return null;
//   }
//   final path = _getStoragePath(
//       authProvider, storageFolderPath, pickedMedia!.name, isVideo);
//   final dimensions = includeDimensions
//       ? isVideo
//           ? _getVideoDimensions(pickedMedia.path)
//           : _getImageDimensions(mediaBytes)
//       : null;

//   return [
//     SelectedFile(
//       storagePath: path,
//       filePath: pickedMedia.path,
//       bytes: mediaBytes,
//       dimensions: await dimensions,
//     ),
//   ];
// }


Future<String> _calculateBlurHash(Uint8List imageBytes) async {
  // Decode the image using dart:ui
  final ui.Image uiImage = await decodeImageFromList(imageBytes);

  // Convert dart:ui.Image to image.Image
  final img.Image image = await _convertUiImageToImage(uiImage);

  // Encode the image to a BlurHash string
  final blurHash = BlurHash.encode(image, numCompX: 4, numCompY: 3);

  return blurHash.hash;
}

Future<img.Image> _convertUiImageToImage(ui.Image uiImage) async {
  final ByteData? byteData =
      await uiImage.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (byteData == null) {
    throw Exception('Failed to convert ui.Image to ByteData');
  }
  final img.Image image = img.Image.fromBytes(
    width: uiImage.width,
    height: uiImage.height,
    bytes: byteData.buffer,
    format: img.Format.uint8, // Assuming the format is uint8
  );

  return image;
}

Future<List<SelectedFile>?> selectMedia({
  required AuthProvider authProvider,
  String? storageFolderPath,
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  bool isVideo = false,
  MediaSource mediaSource = MediaSource.camera,
  bool multiImage = false,
  bool includeDimensions = false,
  bool includeBlurHash = false,
}) async {
  final picker = ImagePicker();

  if (multiImage) {
    final pickedMediaFuture = picker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    final pickedMedia = await pickedMediaFuture;
    if (pickedMedia.isEmpty) {
      return null;
    }
    return Future.wait(pickedMedia.asMap().entries.map((e) async {
      final index = e.key;
      final media = e.value;
      final mediaBytes = await media.readAsBytes();
      final mimeType = mime(media.path) ?? 'application/octet-stream';
      final path = _getStoragePath(
          authProvider, storageFolderPath, media.name, false, index);
      final dimensions = includeDimensions
          ? isVideo
              ? _getVideoDimensions(media.path)
              : _getImageDimensions(mediaBytes)
          : null;
      final blurHash =
          includeBlurHash ? await _calculateBlurHash(mediaBytes) : null;

      return SelectedFile(
        storagePath: path,
        filePath: media.path,
        bytes: mediaBytes,
        dimensions: await dimensions,
        blurHash: blurHash,
      );
    }));
  }

  final source = mediaSource == MediaSource.camera
      ? ImageSource.camera
      : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.pickVideo(source: source)
      : picker.pickImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: imageQuality,
          source: source,
        );
  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
    return null;
  }
  final mimeType = mime(pickedMedia!.path) ?? 'application/octet-stream';
  final path = _getStoragePath(
      authProvider, storageFolderPath, pickedMedia.name, isVideo);
  final dimensions = includeDimensions
      ? isVideo
          ? _getVideoDimensions(pickedMedia.path)
          : _getImageDimensions(mediaBytes)
      : null;
  final blurHash =
      includeBlurHash ? await _calculateBlurHash(mediaBytes) : null;

  return [
    SelectedFile(
      storagePath: path,
      filePath: pickedMedia.path,
      bytes: mediaBytes,
      dimensions: await dimensions,
      blurHash: blurHash,
    ),
  ];
}


bool validateFileFormat(String filePath, BuildContext context) {
  if (allowedFormats.contains(mime(filePath))) {
    return true;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('Invalid file format: ${mime(filePath)}'),
    ));
  return false;
}

Future<SelectedFile?> selectFile({
  required AuthProvider authProvider,
  String? storageFolderPath,
  List<String>? allowedExtensions,
}) =>
    selectFiles(
      authProvider: authProvider,
      storageFolderPath: storageFolderPath,
      allowedExtensions: allowedExtensions,
      multiFile: false,
    ).then((value) => value?.first);

Future<List<SelectedFile>?> selectFiles({
  required AuthProvider authProvider,
  String? storageFolderPath,
  List<String>? allowedExtensions,
  bool multiFile = false,
}) async {
  final pickedFiles = await FilePicker.platform.pickFiles(
    type: allowedExtensions != null ? FileType.custom : FileType.any,
    allowedExtensions: allowedExtensions,
    withData: true,
    allowMultiple: multiFile,
  );
  if (pickedFiles == null || pickedFiles.files.isEmpty) {
    return null;
  }
  if (multiFile) {
    return Future.wait(pickedFiles.files.asMap().entries.map((e) async {
      final index = e.key;
      final file = e.value;
      final storagePath = _getStoragePath(
          authProvider, storageFolderPath, file.name, false, index);
      return SelectedFile(
        storagePath: storagePath,
        filePath: kIsWeb ? null : file.path,
        bytes: file.bytes!,
      );
    }));
  }
  final file = pickedFiles.files.first;
  if (file.bytes == null) {
    return null;
  }
  final storagePath =
      _getStoragePath(authProvider, storageFolderPath, file.name, false);
  return [
    SelectedFile(
      storagePath: storagePath,
      filePath: kIsWeb ? null : file.path,
      bytes: file.bytes!,
    )
  ];
}

List<SelectedFile> selectedFilesFromUploadedFiles(
  List<FileData> uploadedFiles, {
  required AuthProvider authProvider,
  String? storageFolderPath,
  bool isMultiData = false,
}) =>
    uploadedFiles.asMap().entries.map(
      (entry) {
        final index = entry.key;
        final file = entry.value;
        return SelectedFile(
            storagePath: _getStoragePath(
              authProvider,
              storageFolderPath,
              file.name!,
              false,
              isMultiData ? index : null,
            ),
            bytes: file.bytes!);
      },
    ).toList();

Future<MediaDimensions> _getImageDimensions(Uint8List mediaBytes) async {
  final image = await decodeImageFromList(mediaBytes);
  return MediaDimensions(
    width: image.width.toDouble(),
    height: image.height.toDouble(),
  );
}

Future<MediaDimensions> _getVideoDimensions(String path) async {
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset(path);
  await videoPlayerController.initialize();
  final size = videoPlayerController.value.size;
  return MediaDimensions(width: size.width, height: size.height);
}

String _getStoragePath(
  AuthProvider authProvider,
  String? pathPrefix,
  String filePath,
  bool isVideo, [
  int? index,
]) {
  pathPrefix ??= _firebasePathPrefix(authProvider);
  pathPrefix = _removeTrailingSlash(pathPrefix);
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  final indexStr = index != null ? '_$index' : '';
  return '$pathPrefix/$timestamp$indexStr.$ext';
}

String getSignatureStoragePath(AuthProvider authProvider,
    [String? pathPrefix]) {
  pathPrefix ??= _firebasePathPrefix(authProvider);
  pathPrefix = _removeTrailingSlash(pathPrefix);
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  return '$pathPrefix/signature_$timestamp.png';
}

void showUploadMessage(
  BuildContext context,
  String message, {
  bool showLoading = false,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10.0),
                child: CircularProgressIndicator(
                  valueColor: Theme.of(context).brightness == Brightness.dark
                      ? AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.secondary)
                      : null,
                ),
              ),
            Text(message),
          ],
        ),
        duration:
            showLoading ? const Duration(days: 1) : const Duration(seconds: 4),
      ),
    );
}

String? _removeTrailingSlash(String? path) => path != null && path.endsWith('/')
    ? path.substring(0, path.length - 1)
    : path;

String _firebasePathPrefix(AuthProvider authProvider) {
  if (authProvider.user != null) {
    return 'users/${authProvider.user!.id}/uploads';
  } else {
    throw Exception('User is not authenticated');
  }
}

class FileData {
  const FileData({
    this.name,
    this.bytes,
    this.height,
    this.width,
    this.blurHash,
  });

  final String? name;
  final Uint8List? bytes;
  final double? height;
  final double? width;
  final String? blurHash;

  @override
  String toString() =>
      'FFUploadedFile(name: $name, bytes: ${bytes?.length ?? 0}, height: $height, width: $width, blurHash: $blurHash,)';

  String serialize() => jsonEncode(
        {
          'name': name,
          'bytes': bytes,
          'height': height,
          'width': width,
          'blurHash': blurHash,
        },
      );

  static FileData deserialize(String val) {
    final serializedData = jsonDecode(val) as Map<String, dynamic>;
    final data = {
      'name': serializedData['name'] ?? '',
      'bytes': serializedData['bytes'] ?? Uint8List.fromList([]),
      'height': serializedData['height'],
      'width': serializedData['width'],
      'blurHash': serializedData['blurHash'],
    };
    return FileData(
      name: data['name'] as String,
      bytes: Uint8List.fromList(data['bytes'].cast<int>().toList()),
      height: data['height'] as double?,
      width: data['width'] as double?,
      blurHash: data['blurHash'] as String?,
    );
  }

  @override
  int get hashCode => Object.hash(
        name,
        bytes,
        height,
        width,
        blurHash,
      );

  @override
  bool operator ==(other) =>
      other is FileData &&
      name == other.name &&
      bytes == other.bytes &&
      height == other.height &&
      width == other.width &&
      blurHash == other.blurHash;
}





class UploadedFile {
  const UploadedFile({
    this.name,
    this.bytes,
    this.height,
    this.width,
    this.blurHash,
  });

  final String? name;
  final Uint8List? bytes;
  final double? height;
  final double? width;
  final String? blurHash;

  @override
  String toString() =>
      'UploadedFile(name: $name, bytes: ${bytes?.length ?? 0}, height: $height, width: $width, blurHash: $blurHash,)';

  String serialize() => jsonEncode(
        {
          'name': name,
          'bytes': bytes,
          'height': height,
          'width': width,
          'blurHash': blurHash,
        },
      );

  static UploadedFile deserialize(String val) {
    final serializedData = jsonDecode(val) as Map<String, dynamic>;
    final data = {
      'name': serializedData['name'] ?? '',
      'bytes': serializedData['bytes'] ?? Uint8List.fromList([]),
      'height': serializedData['height'],
      'width': serializedData['width'],
      'blurHash': serializedData['blurHash'],
    };
    return UploadedFile(
      name: data['name'] as String,
      bytes: Uint8List.fromList(data['bytes'].cast<int>().toList()),
      height: data['height'] as double?,
      width: data['width'] as double?,
      blurHash: data['blurHash'] as String?,
    );
  }

  @override
  int get hashCode => Object.hash(
        name,
        bytes,
        height,
        width,
        blurHash,
      );

  @override
  bool operator ==(other) =>
      other is UploadedFile &&
      name == other.name &&
      bytes == other.bytes &&
      height == other.height &&
      width == other.width &&
      blurHash == other.blurHash;
}

Future<String?> uploadData(String storagePath, Uint8List bytes) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(storagePath);

    // Determine the MIME type
    String? mimeType = mime(storagePath);
    final metadata = SettableMetadata(contentType: mimeType);

    final uploadTask = ref.putData(bytes, metadata);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    print('Upload error: $e');
    return null;
  }
}

Future<String> uploadImage(
    Uint8List imageBytes, String filePath, String mimeType) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(filePath);
    final metadata = SettableMetadata(contentType: mimeType);
    final uploadTask = ref.putData(imageBytes, metadata);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    print('Upload error: $e');
    return '';
  }
}
