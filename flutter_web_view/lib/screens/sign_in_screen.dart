import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadHtmlString("""

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign In</title>
  </head>

  <style>
    * {
      padding: 0;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background: #f2f2f2;
    }

    section {
      display: grid;
      place-items: center;
      height: 100vh;
    }

    .text-field {
      display: flex;
      flex-direction: column;
    }

    .text-field input {
      padding: 16px;
      border: 1px solid gray;
      border-radius: 4px;
    }

    .spacer {
      height: 8px;
    }
  </style>

  <body>
    <section>
      <div class="form-container">
        <h1>Create your account</h1>

        <div class="text-field">
          <span>Full name</span>
          <div class="spacer"></div>
          <input type="text" />
        </div>
        <div class="spacer"></div>
        <div class="text-field">
          <span>Age</span>
          <div class="spacer"></div>
          <input type="number" />
        </div>
      </div>
    </section>
  </body>
</html>


""");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
