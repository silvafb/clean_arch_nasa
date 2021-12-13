// ignore_for_file: unnecessary_string_interpolations

class NasaEndpoints {
  static Uri getSpaceMedia(String apiKey, String date) =>
    Uri.https('api.nasa.gov', '/planetary/apod', {
      'api_key': '$apiKey',
      'date': '$date',
    });
}