class Constants {
  final List<Map<String, String>> categories =[
    {'label':'Cat foods',  'argument':'cat food', 'image':'assets/images/cat-removebg-preview.png'},
    {'label':'dog foods',  'argument':'dog food', 'image':'assets/images/dog-removebg-preview.png'},
    {'label':'Collars',  'argument':'collar', 'image':'assets/images/collar-removebg-preview.png'},
    {'label':'Pet Toys',  'argument':'toys', 'image':'assets/images/toys-removebg-preview.png'},

  ];
  String discountPercent(int oldPrice, int currentPrice){
    if(oldPrice==0){
      return "0";
    }
    else{
      double discount= ((oldPrice-currentPrice)/oldPrice)*100;
      return discount.toStringAsFixed(0);
    }
  }

}
class ChatMessage{
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}


