import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';

import '../../../provider/auth_provider.dart';
import '../../../utils/file_picker.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;


class ChangePhotoWidget extends StatefulWidget {
  const ChangePhotoWidget({super.key, required this.onPhotoChanged});

  final ValueChanged<String> onPhotoChanged;

  @override
  State<ChangePhotoWidget> createState() => _ChangePhotoWidgetState();
}

class _ChangePhotoWidgetState extends State<ChangePhotoWidget>
    with TickerProviderStateMixin {
  Uint8List? _selectedImageBytes;
  String? _uploadedFileUrl;
  bool _isDataUploading = false;
  String? _selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 6.0,
              color: Color(0x35000000),
              offset: Offset(0.0, -2.0),
            )
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF95A1AC),
                      size: 24.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Change Profile Photo',
                        textAlign: TextAlign.start,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontFamily: 'Plus Jakarta Sans',
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: _selectedImageBytes != null
                      ? Image.memory(
                          _selectedImageBytes!,
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          _uploadedFileUrl ??
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/uxii7iwtqpy8/emptyAvatar@2x.png',
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final selectedMedia =
                        await selectMediaWithSourceBottomSheet(
                      context: context,
                      allowPhoto: true,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.onSecondary,
                      pickerFontFamily: 'Lexend Deca',
                    );
                    if (selectedMedia != null &&
                        selectedMedia.every((m) =>
                            validateFileFormat(m.storagePath, context))) {
                      setState(() {
                        _selectedImageBytes = selectedMedia.first.bytes;
                        _selectedImagePath = selectedMedia.first.storagePath;
                      });
                    }
                  },
                  child: const Text('Upload Photo'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedImageBytes != null &&
                        _selectedImagePath != null) {
                      setState(() {
                        _isDataUploading = true;
                      });
                      try {
                        final timestamp = DateTime.now().millisecondsSinceEpoch;

                        // Get the extension from the selected image path
                        final extension = path.extension(_selectedImagePath!);
                        final filePath =
                            'profile_pictures/${Provider.of<AuthProvider>(context, listen: false).user!.id}/$extension';

                        final downloadUrl =
                            await uploadData(filePath, _selectedImageBytes!);

                        setState(() {
                          _uploadedFileUrl = downloadUrl;
                        });
                        widget.onPhotoChanged(_uploadedFileUrl!);

                        // Update Firestore with the new URL
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(authProvider.user!.id)
                            .update({'profile_picture_url': _uploadedFileUrl});

                        // Update AuthProvider user
                        await authProvider
                            .updateUserProfilePicture(_uploadedFileUrl!);

                        Navigator.pop(context);
                      } catch (e) {
                        print('Upload error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to upload data')),
                        );
                      } finally {
                        setState(() {
                          _isDataUploading = false;
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No photo to save')),
                      );
                    }
                  },
                  child: _isDataUploading
                      ? const CircularProgressIndicator()
                      : const Text('Save Photo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
