class HomeCarouselModel {
  final String id;
  final String imgUrl;

  HomeCarouselModel({
    required this.id,
    required this.imgUrl,
  });
}

List<HomeCarouselModel> dummyCarouselItems = [
  HomeCarouselModel(
    id: '1',
    imgUrl:
        'https://marketplace.canva.com/EAFMdLQAxDU/1/0/1600w/canva-white-and-gray-modern-real-estate-modern-home-banner-NpQukS8X1oo.jpg',
  ),
  HomeCarouselModel(
    id: '2',
    imgUrl:
        'https://edit.org/photos/img/blog/mbp-template-banner-online-store-free.jpg-840.jpg',
  ),
  HomeCarouselModel(
    id: '3',
    imgUrl:
        'https://casalsonline.es/wp-content/uploads/2018/12/CASALS-ONLINE-18-DICIEMBRE.png',
  ),
  HomeCarouselModel(
    id: '4',
    imgUrl:
        'https://e0.pxfuel.com/wallpapers/606/84/desktop-wallpaper-ecommerce-website-design-company-noida-e-commerce-banner-design-e-commerce.jpg',
  ),
];
