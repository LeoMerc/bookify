import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height * 0.225,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              //TODO: add localizations
              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.1,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, 'camera'),
                    child: const Text('Camera'),
                  ),
                ),
              ),

              const Divider(thickness: 1),

              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.1,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, 'gallery'),
                    child: const Text('Gallery'),
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
