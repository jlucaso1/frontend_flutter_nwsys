String defaultImage =
    "data:image/png;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==";

converBase64ImageToUint8List(String base64Image) {
  final UriData? data = Uri.parse(base64Image).data;
  return data!.contentAsBytes();
}
