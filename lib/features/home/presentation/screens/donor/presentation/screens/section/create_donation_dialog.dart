import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
import '../../../../../../../widgets/coustom_green_field.dart';
import '../../provider/donor_provider.dart';

class CreateDonationDialog extends StatefulWidget {
  const CreateDonationDialog({super.key});

  @override
  State<CreateDonationDialog> createState() => _CreateDonationDialogState();
}

class _CreateDonationDialogState extends State<CreateDonationDialog> {
  final _formKey = GlobalKey<FormState>();

  final foodCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  final pickupTimeCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final donorProvider = context.watch<DonorProvider>();

    return Stack(
      children: [
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Create Donation",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColor.green,
                      ),
                    ),
                    const Divider(),

                    CustomGreenField(
                      controller: foodCtrl,
                      label: "Food Name",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    CustomGreenField(
                      controller: qtyCtrl,
                      label: "Quantity",
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    CustomGreenField(
                      controller: pickupTimeCtrl,
                      label: "Pickup Time",
                    ),
                    CustomGreenField(
                      controller: addressCtrl,
                      label: "Pickup Address",
                    ),
                    CustomGreenField(
                      controller: descCtrl,
                      label: "Description",
                      maxLines: 2,
                    ),

                    const SizedBox(height: 15),

                    TextButton.icon(
                      onPressed: donorProvider.pickImages,
                      icon: Icon(Icons.add_a_photo, color: AppColor.green),
                      label: Text(
                        "Add Images (${donorProvider.selectedImages.length})",
                        style: TextStyle(color: AppColor.green),
                      ),
                    ),

                    if (donorProvider.selectedImages.isNotEmpty)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                          donorProvider.selectedImages.length,
                          itemBuilder: (_, i) {
                            final img =
                            donorProvider.selectedImages[i];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: kIsWeb
                                    ? FutureBuilder<Uint8List>(
                                  future: img.readAsBytes(),
                                  builder: (_, s) {
                                    if (!s.hasData) {
                                      return const SizedBox(
                                        width: 100,
                                        child: Center(
                                          child:
                                          CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    return Image.memory(
                                      s.data!,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                                    : Image.file(
                                  File(img.path),
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        
                        onPressed: donorProvider.isLoading
                            ? null
                            : () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          try {
                            await donorProvider.submitPost(
                              foodName:
                              foodCtrl.text.trim(),
                              quantity:
                              qtyCtrl.text.trim(),
                              pickupTime:
                              pickupTimeCtrl.text.trim(),
                              pickupAddress:
                              addressCtrl.text.trim(),
                              description:
                              descCtrl.text.trim(),
                            );

                            if (mounted) {
                              Navigator.pop(context);
                              ShowAlertMessage(
                                context: context,
                                title: "Success",
                                boldText: "Done! ",
                                message: "Donation posted successfully.",
                                isSuccess: true,
                              );
                            }
                          } catch (e) {
                            ShowAlertMessage(
                              context: context,
                              title: "Success",
                              boldText: "Done! ",
                              message: "Donation post successfully.",
                              isSuccess: true,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.green,
                          foregroundColor: AppColor.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                        ),
                        child: const Text("Submit Donation"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // 🔥 FULLSCREEN LOADER
        if (donorProvider.isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black38,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColor.green,
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
