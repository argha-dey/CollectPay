class SliderModel {
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath, this.title, this.desc});

  void setImageAssetPath(String getImagePath){
    imagePath = getImagePath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imagePath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }
}

List<SliderModel>  getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //slider 0
  sliderModel.setImageAssetPath("images/onboarding_one.png");
  sliderModel.setTitle("Connect people");
  sliderModel.setDesc("Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //slider 1
  sliderModel.setImageAssetPath("images/onboarding_two.png");
  sliderModel.setTitle("Live your life smarter");
  sliderModel.setDesc("Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //slider 2
  sliderModel.setImageAssetPath("images/onboarding_three.png");
  sliderModel.setTitle("Get a new experience");
  sliderModel.setDesc("Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //slider 3
  sliderModel.setImageAssetPath("images/onboarding_four.png");
  sliderModel.setTitle("Get a new experience");
  sliderModel.setDesc("Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.");
  slides.add(sliderModel);


  sliderModel = new SliderModel();
  //slider 5
  sliderModel.setImageAssetPath("images/onboarding_five.png");
  sliderModel.setTitle("Get a new experience");
  sliderModel.setDesc("Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.");
  slides.add(sliderModel);

  //sliderModel = new SliderModel();

  return slides;
}