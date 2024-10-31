// ignore_for_file: avoid_print

import 'dart:io';
import 'package:e_clean_fcm/features/auth/widgets/validation.dart';
import 'package:e_clean_fcm/features/products/models/product_models.dart';
import 'package:e_clean_fcm/features/products/services/product_notifier.dart';
import 'package:e_clean_fcm/features/products/services/sell_pandel_notifier.dart';
import 'package:e_clean_fcm/shared/custom_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

        // // Verify required fields are not null/empty
        // if (updatedState.proTitle?.isEmpty ??
        //   {
        //   print('Required fields are missing');
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Please fill all required fields')),
        //   );
        //   return;
        // }

        print('Saved Title: ${updatedState.proTitle}');
        print('Saved Price: ${updatedState.proPrice}');
        print('Saved Description: ${updatedState.proDesciption}');

        sellNotifier.toggleAuthMode();

        final uploadedProduct = Products(
          id: '',
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
                uploadedProduct, updatedState.proImageFile!);

        print('Upload completed');

        if (updatedState.isAuthenticaion) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product uploaded successfully!')),
          );
        }
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
  // Future<void> uploadProduct(BuildContext context, WidgetRef ref) async {
  //   final sellStat = ref.watch(sellPanelNotifierProvider);
  //   final sellNotifier = ref.watch(sellPanelNotifierProvider.notifier);
  //   print('Upload started');
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Please login to post products')),
  //       );
  //       return;
  //     }

  //     if (!_formKey.currentState!.validate()) {
  //       print('Validation failed');
  //       return;
  //     }

  //     if (sellStat.proImageFile!.isEmpty) {
  //       print('No images selected');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Please select at least one image')),
  //       );
  //       return;
  //     }

  //     _formKey.currentState?.save();

  //     print('Saved Title: ${sellStat.proTitle}');
  //     print('Saved Price: ${sellStat.proPrice}');
  //     print('Saved Description: ${sellStat.proDesciption}');
  //     sellNotifier.toggleAuthMode();

  //     print('Loading state set');

  //     final uploadedProduct = Products(
  //       id: '',
  //       userId: '',
  //       title: sellStat.proTitle ?? '',
  //       description: sellStat.proDesciption ?? '',
  //       price: sellStat.proPrice,
  //       imageUrls: sellStat.proImageFile!,
  //     );

  //     print('Product object created: ${uploadedProduct.title}');
  //     print('Created product values:');
  //     print('Title: ${uploadedProduct.title}');
  //     print('Price: ${uploadedProduct.price}');
  //     print('Description: ${uploadedProduct.description}');
  //     ref
  //         .read(productUploadNotifierProvider.notifier)
  //         .productUploaderToFirebase(uploadedProduct, sellStat.proImageFile!);

  //     print('Upload completed');

  //     if (sellStat.isAuthenticaion) {
  //       Navigator.pop(context);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Product uploaded successfully!')),
  //       );
  //     }
  //   } catch (e) {
  //     print('Upload error: $e');
  //     if (sellStat.isAuthenticaion) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Upload failed: ${e.toString()}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } finally {
  //     if (sellStat.isAuthenticaion) {
  //       sellNotifier.toggleAuthMode();
  //     }
  //   }
  // }

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
                            color: Colors.grey[200],
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
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
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
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(),
                          ),
                          validator: FormValidators.validatePrice,
                        ),
                      ),
                      //For Description
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onSaved: (value) {
                            if (value != null && value.isNotEmpty) {
                              print('Saving description: $value');
                              ref
                                  .read(sellPanelNotifierProvider.notifier)
                                  .setDescriptions(value);
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
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

                      const SizedBox(height: 16),
                      // ... rest of your form fields

                      AppButtons.primary(
                        text: 'Post Product',
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
