class NewsModel{

  late String newsHead;
  late String newsImg;
  late String newsdes;
  late String newsUrl;

  NewsModel({this.newsHead = " news headline", this.newsImg = " url ", this.newsdes=" news description", this.newsUrl = " Url"});
factory NewsModel.fromMap(Map news){
  return NewsModel(
    newsdes:news["description"],
    newsHead:news["title"],
    newsImg:news["urlToImage"],
    newsUrl:news["url"]
  );
}

}