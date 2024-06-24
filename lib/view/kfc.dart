import 'package:flutter/material.dart';

class Kfc extends StatelessWidget {
  Kfc({super.key});
  List<String> foodList = [
    "Fast Food",
    "Vegetarian",
    "Cafe",
    "Buffet",
    "Fast Food",
    "Vegetarian",
    "Cafe",
    "Buffet",
  ];
  List<PhotoList> photoList = [
    PhotoList(name: "Sandar Momo", km: "0.5 km", url: "assets/images/momo.jpg"),
    PhotoList(
        name: "Bajeko Sekuwa", km: "1.5 km", url: "assets/images/sekuwa.png"),
    PhotoList(name: "Sandar Momo", km: "0.5 km", url: "assets/images/momo.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi,John",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "Banepa 45210,Nepal",
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 15),
                        )
                      ],
                    ),
                    Icon(Icons.search)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(foodList[index]),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Recommended",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: photoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 140,
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        15), // Set the border radius here
                                    child: Image.asset(
                                      photoList[index].url!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  photoList[index].name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  photoList[index].km!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoList {
  String? url;
  String? name;
  String? km;
  PhotoList({this.url, this.name, this.km});
}
