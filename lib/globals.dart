const String kApiKey = "26eb908b-5e62-4d59-912a-efa993c26362";

List<String> favouritesList = [];

List<String> favouritesApiCall = [];

bool checkFavourites(String target) {
  for (int i = 0; i < favouritesList.length; i++) {
    if (target == favouritesList[i]) {
      return true;
    }
  }
  return false;
}



//   List<String> favouritesList = [
//   "Manchester",
//   "London",
//   "Blackpool",
//   "Bedford",
//   "Bolton",
// ];

// List<String> favouritesApiCall = [
//   "http://api.airvisual.com/v2/city?city=Manchester&state=England&country=uk&key=ac9823bb-9913-4ba1-b800-dd47fa51383d",
//   "http://api.airvisual.com/v2/city?city=London&state=England&country=uk&key=ac9823bb-9913-4ba1-b800-dd47fa51383d",
//   "http://api.airvisual.com/v2/city?city=Blackpool&state=England&country=uk&key=ac9823bb-9913-4ba1-b800-dd47fa51383d",
//   "http://api.airvisual.com/v2/city?city=Bedford&state=England&country=uk&key=ac9823bb-9913-4ba1-b800-dd47fa51383d",
//   "http://api.airvisual.com/v2/city?city=Bolton&state=England&country=uk&key=ac9823bb-9913-4ba1-b800-dd47fa51383d"
// ];
