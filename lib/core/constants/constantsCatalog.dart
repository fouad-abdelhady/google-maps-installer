class Constantscatalog {
  static String done = "Done";
  static String noPubspec = "Couldn't find pubspec.yaml";
  static String googleMapsAddLine = "flutter pub add google_maps_flutter";
  static String noDir = "No directory picked";
  static String wellcome = "Wellcome to Google maps installer!";
  static String chooseDir = "Click blow to choose directory";
  static String step1 = "Step 1";
  static String step2 = "Step 2";
  static String googleMapApiKey = "Enter Google Maps Api key";
  static String iosSnippetPattern =
      r'override\s+func\s+application\s*\(([^)]*)\)\s*->\s*([a-zA-Z0-9]+)\s*\{';
  static String androidSnippetPattern =
      r'(<application)(\s*)(\n*)(\s*)((.*)(\s*)(\n*)(\s*)(=)(\s*)(\n*)(\s*)("(.+)"(\s*)(\n*)(\s*)))*(\s*)(\n*)(\s*)(>)';
  static String homeScreenRegex = r'(home)(.+)(\n)*(.+)(\),)';
  static String iosGoogleMapsKey(String apiKey) {
    return 'GMSServices.provideAPIKey("$apiKey")';
  }

  static String androidGoogleMapsKeySnippet(String apiKey) {
    return '<meta-data android:name="com.google.android.geo.API_KEY"android:value="$apiKey"/>';
  }
}
