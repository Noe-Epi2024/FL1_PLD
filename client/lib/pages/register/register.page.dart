import "package:flutter/material.dart";

import "../../components/generators/layout.generator.dart";
import "register.page.mobile.dart";

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) => LayoutGenerator.adaptativeLayout(
        context,
        mobileLayout: RegisterPageMobile(),
      );
}
