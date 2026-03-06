# example

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## entry point for menu builder


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyRegisterWidget(
      child: GetMaterialApp(
        key: MenuBuilderGlobalVariable.navState,
        title: 'Flutter Demo',
        theme: appTheme(context),
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        ),
        home: FlutterFoodpageMenuBuilder(
          config: MenuBuilderConfig(
            authenticationKey: "6b6035bd8e22c350ab03e2b9b64009e7",
            mode: DevelopmentMode.development,
            geminiAPIKey: "AIzaSyCHY942WKRPYPucmyaANG9HOHSJGb77T9E",
            applicationName: "EPOS",
          ),
        ),
      ),
    );
  }
}

## entry point for table reservation 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(context),
      initialBinding: AppBinding(),
      initialRoute: RouteNames.kDashBoard,
      getPages: appRoutes,
    );
  }
}