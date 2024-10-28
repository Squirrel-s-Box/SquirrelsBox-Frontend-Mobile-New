import 'package:flutter/material.dart';
import 'package:squirrels_box_2/config/theme/colors.dart';
import 'package:squirrels_box_2/features/widgets/app_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrincipalTitle(title: "Settings"),
          const SecondaryTitle(title: "Features"),
          Row(
            children: [
              const Icon(Icons.sunny),
              const SizedBox(width: 5),
              const NormalText(title: "Change theme"),
              Expanded(child: Container()),
              Switch(
                  value: isDarkMode,
                  onChanged: (mode) {
                    isDarkMode = mode;
                  })
            ],
          ),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 5),
              const NormalText(title: "Language"),
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
          const SizedBox(height: 5),
          const SecondaryTitle(title: "Legal"),
          const SizedBox(height: 5),
          const Row(
            children: [
              const Icon(Icons.menu_book),
              const SizedBox(width: 5),
              const NormalText(title: "Terms of Service")
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.menu_book),
              const SizedBox(width: 5),
              NormalText(title: "Privacy Policy")
            ],
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Log Out",
              style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  color: AppColors.strongOrange,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SecondaryTitle(title: "About Us"),
          const SizedBox(height: 20),
          Row(
            children: [
              Image.network(
                  width: 50,
                  "https://s3-alpha-sig.figma.com/img/d57a/fd37/d58524979d6f28ae4ff0a51fd6fad4de?Expires=1731283200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=JfHhQ8oBx24NXp5~0MFfajNSpjj2NtOlAIBpWLHEb85rqafh0ufHuvs-PRCNs4Ty-D86U-rjDEMmOC1afp6TCnAbVDzSsI-PZCqVjVA6tTCIP6pCzs7abD2j063n3eFyfDb5aXXu-G2sKXUOG6t9T~cxpQFCE~~c8KbavGrSNBbnsOS8cXuob9NG10IeKNF2E5vE~fqyE6lNXWyNt7-Whn0h-waRjx29ApbOvZly5pIqsBovEL4pNUkYaBXqqcAGJ2GT57BTb2NbQrY6NwV4iX3BeeGFF4wdQt6Paf9IGToVrU4AdhNjZI9WoChxozI2JRaSezZeQx0Cf~DjTH5Z8g__"),
              const SizedBox(width: 10),
              const NormalText(title: "About the application")
            ],
          ),
          const SizedBox(height: 10),
          const NormalText(title: "Software Version: 7.7.7")
        ],
      ),
    );
  }
}
