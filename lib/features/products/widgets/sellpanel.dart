// ignore_for_file: avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers
import 'package:e_clean_fcm/core/constants/app_sizes.dart';
import 'package:e_clean_fcm/core/util/string_hardcode.dart';
import 'dart:io';
import 'package:e_clean_fcm/features/auth/widgets/validation.dart';
import 'package:e_clean_fcm/features/products/models/product_models.dart';
import 'package:e_clean_fcm/features/products/services/product_notifier.dart';
import 'package:e_clean_fcm/features/products/services/sell_pandel_notifier.dart';
import 'package:e_clean_fcm/shared/custom_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class SellPanelSheetState extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SellPanelSheetState({super.key});
  // List<File> _selectedImages = []; // Changed to List
  // bool _isLoading = false;
  // var _onSaveTitle = '';
  // double? _onSavePrice;
  // var _onSaveDescription = '';
  Future<void> uploadProduct(BuildContext context, WidgetRef ref) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final sellStat = ref.read(sellPanelNotifierProvider);
    final sellNotifier = ref.read(sellPanelNotifierProvider.notifier);
    print('Upload started');
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to post products')),
        );
        return;
      }

      // Check images first
      if (sellStat.proImageFile == null || sellStat.proImageFile!.isEmpty) {
        print('No images selected');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one image')),
        );
        return;
      }

      // Validate and save form
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        _formKey.currentState!.save(); // Only save if validation passes

        // Read updated state after saving
        final updatedState = ref.read(sellPanelNotifierProvider);

        print('Saved Title: ${updatedState.proTitle}');
        print('Saved Price: ${updatedState.proPrice}');
        print('Saved Description: ${updatedState.proDesciption}');

        sellNotifier.toggleAuthMode();

        final uploadedProduct = Products(
          id: _auth.currentUser!.uid,
          userId: user.uid,
          title: updatedState.proTitle!,
          description: updatedState.proDesciption!,
          price: updatedState.proPrice,
          imageUrls: updatedState.proImageFile!,
        );

        print('Created product values:');
        print('Title: ${uploadedProduct.title}');
        print('Price: ${uploadedProduct.price}');
        print('Description: ${uploadedProduct.description}');

        await ref
            .read(productUploadNotifierProvider.notifier)
            .productUploaderToFirebase(
              uploadedProduct,
            );

        print('Upload completed');

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product uploaded successfully!')),
        );
      } else {
        print('Form validation failed');
      }
    } catch (e) {
      print('Upload error: $e');
      if (sellStat.isAuthenticaion) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (sellStat.isAuthenticaion) {
        sellNotifier.toggleAuthMode();
      }
    }
  }

  Future<void> _pickImages(WidgetRef ref) async {
    final sellNotifier = ref.watch(sellPanelNotifierProvider.notifier);
    final imagePicker = ImagePicker();

    try {
      final List<XFile> pickedFiles = await imagePicker.pickMultiImage(
        maxWidth: 600,
      );

      if (pickedFiles.isNotEmpty) {
        // Convert XFile to File
        final List<File> files =
            pickedFiles.map((xFile) => File(xFile.path)).toList();

        sellNotifier.setImageFiles(files);
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  // void _removeImage(int index) {
  //   setState(() {
  //     _selectedImages.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellStat = ref.watch(sellPanelNotifierProvider.notifier);
    final sellStates = ref.watch(sellPanelNotifierProvider);
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scroll) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Selected Images Preview
                      if (sellStates.proImageFile!.isNotEmpty)
                        Container(
                          height: 120,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sellStates.proImageFile!.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: FileImage(
                                          sellStates.proImageFile![index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 12,
                                    child: GestureDetector(
                                      // onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                      // Image Picker Button
                      GestureDetector(
                        onTap: () {
                          _pickImages(ref);
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate, size: 40),
                              SizedBox(height: 8),
                              Text('Add Product Images'),
                            ],
                          ),
                        ),
                      ),

                      // Rest of your form fields remain the same
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != null && value.isNotEmpty) {
                              print('Saving title: $value');
                              sellStat.setTitle(value);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Title'.hardcoded,
                            border: const OutlineInputBorder(),
                          ),
                          validator: FormValidators.validateText,
                        ),
                      ),
                      //For Price
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != null && value.isNotEmpty) {
                              print('Saving price: $value');
                              final price = double.tryParse(value) ?? 0.0;
                              sellStat.setPrice(price);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Price'.hardcoded,
                            border: const OutlineInputBorder(),
                          ),
                          validator: FormValidators.validatePrice,
                        ),
                      ),
                      //For Description
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLines: 3,
                          onSaved: (value) {
                            if (value != null && value.isNotEmpty) {
                              print('Saving description: $value');
                              ref
                                  .read(sellPanelNotifierProvider.notifier)
                                  .setDescriptions(value);
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Description'.hardcoded,
                            border: const OutlineInputBorder(),
                          ),
                          validator: FormValidators.validateText,
                        ),
                      ),
                      if (sellStates.isLogin)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),

                      const Gap(Sizes.p16),
                      // ... rest of your form fields

                      AppButtons.primary(
                        text: 'Post Product'.hardcoded,
                        onTap: () {
                          uploadProduct(context, ref);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSellPanel(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SellPanelSheetState(),
  );
}
