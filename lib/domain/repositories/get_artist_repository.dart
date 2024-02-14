class GetArtistRepository {

  @override
  Future<> getBestArtist() async {

    try{
      Response response = await apiProvider.callCurrentWeather(cityName);
      if(response.statusCode == 200){
        CurrentCityEntity currentCityEntity = CurrentCityModel.fromJson(response.data);

        return DataSuccess(currentCityEntity);
      }else{
        return const DataFailed("Something Went Wrong. try again...");
      }
    }catch(e){
      return const DataFailed("please check your connection...");
    }
  }
}