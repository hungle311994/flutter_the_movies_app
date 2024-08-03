String _token =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YTkxYjc1N2Y4YmNlOTBiMTVhZDg0NThiMzZhZWRiYyIsIm5iZiI6MTcyMjMxMTk3OC42ODI2MjgsInN1YiI6IjYzYzIxZmI0ZGY4NTdjMDA5ZjQ0NTY3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.W77K6e39lyoamlvcCaPHwOnVp7NbM_Rjamg3I0gRYhU';

String apiUrl() {
  return 'https://api.themoviedb.org/3';
}

String apiKey() {
  return 'api_key=4a91b757f8bce90b15ad8458b36aedbc';
}

String apiImage(String path) {
  return 'https://image.tmdb.org/t/p/original$path';
}

Future<Map<String, String>> headers() async {
  return {
    'X-Auth-Token': _token,
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
}
