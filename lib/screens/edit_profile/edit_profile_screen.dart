import 'package:flutter/material.dart';

import '../../components/autocomplete_address_field.dart';
import '../../components/button.dart';
import '../../constants.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../login/components/email_input_field.dart';
import '../login/components/name_input_field.dart';
import '../login/components/phone_number_input_field.dart';
import '../profile/components/change_photo.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    this.userProfile,
  });

  final User? userProfile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? _profilePictureUrl;
  // controllers and focus nodes
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  String? _nameError;
  String? _emailError;
  String? _phoneNumberError;
  String? _addressError;

  @override
  void initState() {
    super.initState();
    _profilePictureUrl = widget.userProfile?.profilePictureUrl;
    _nameController.text = widget.userProfile?.name ?? '';
    _emailController.text = widget.userProfile?.email ?? '';
    _phoneNumberController.text = widget.userProfile?.phoneNumber ?? '';
    _addressController.text = widget.userProfile?.address ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  void _updateProfilePicture(String newUrl) {
    setState(() {
      _profilePictureUrl = newUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: UserService().getUser(widget.userProfile!.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          );
        }

        final editProfileUsersRecord = snapshot.data!;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 24,
              ),
            ),
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontFamily: 'Plus Jakarta Sans',
                    letterSpacing: 0,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDBE2E7),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          width: 90,
                          height: 90,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            _profilePictureUrl ??
                                'assets/images/placeholder.jpg',
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading image: $error');
                              return Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: const Color(0xB2090F13),
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: Container(
                                  height: 470,
                                  child: ChangePhotoWidget(
                                    onPhotoChanged: _updateProfilePicture,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        text: 'Change Photo',
                        options: ButtonOptions(
                          width: 130,
                          height: 40,
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Theme.of(context).primaryColor,
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontFamily: 'Lexend Deca',
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          elevation: 2,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                    child: NameInputField(
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                    )),
                Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                    child: EmailInputField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                    )),
                Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                    child: PhoneNumberInputField(
                      controller: _phoneNumberController,
                      focusNode: _phoneNumberFocusNode,
                    )),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                  child: AutoCompleteAddressField(
                    controller: _addressController,
                    focusNode: _addressFocusNode,
                    onAddressValidated: (String? value) {},
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0.05),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                    child: Button(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: 'Save Changes',
                      options: ButtonOptions(
                        width: 340,
                        height: 60,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Theme.of(context).primaryColor,
                        textStyle:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                ),
                        elevation: 2,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
