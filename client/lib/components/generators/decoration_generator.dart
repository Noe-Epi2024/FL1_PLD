import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "../../resources/resources.dart";

class DecorationGenerator {
  static Widget logo({bool withText = true, bool withIcon = true}) => Row(
        children: [
          if (withText)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Resources.logo(
                color: Colors.black,
                height: 32,
                width: 32,
              ),
            ),
          if (withIcon)
            Text(
              "HyperTools",
              style: GoogleFonts.lexend(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      );
}
