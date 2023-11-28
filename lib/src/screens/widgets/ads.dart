import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AdsComponent extends StatelessWidget {
  const AdsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Html(data: """
      <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7304585699840014"
       crossorigin="anonymous"></script>
<!-- home -->
      <ins class="adsbygoogle"
             style="display:block"
             data-ad-client="ca-pub-7304585699840014"
             data-ad-slot="4653006977"
             data-ad-format="auto"
             data-full-width-responsive="true"></ins>
      <script>
             (adsbygoogle = window.adsbygoogle || []).push({});
      </script>
      """),
    );
  }
}
