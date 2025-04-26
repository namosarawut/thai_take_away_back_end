import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File? _pickedImage;
  final _picker = ImagePicker();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => _pickedImage = File(img.path));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7162BA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),

            // Main form container
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 788),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF534598),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          // Image picker
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 266,
                              height: 191,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFD80A3),
                                borderRadius: BorderRadius.circular(20),
                                image: _pickedImage != null
                                    ? DecorationImage(
                                  image: FileImage(_pickedImage!),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                              child: _pickedImage == null
                                  ? Center(
                                child: Icon(Icons.add_a_photo,size: 100,color: Colors.white,),
                              )
                                  : null,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Name
                          SizedBox(
                            width: 433,
                            height: 57,
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Description
                          SizedBox(
                            width: 488,
                            height: 285,
                            child: TextField(
                              controller: _descController,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Description',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Price
                          SizedBox(
                            width: 254,
                            height: 57,
                            child: TextField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Price',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
