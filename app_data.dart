import 'package:flutter/material.dart';

class Review {
  final String username, urlImage, date, description;

  Review({required this.username, required this.urlImage, required this.date, required this.description});
}

class Location {
  final String name, urlImage, latitude, longitude, addressLine1, addressLine2;
  final int starRating;
  final List<Review> reviews;

  Location({required this.name, required this.urlImage, required this.latitude, required this.longitude, required this.addressLine1, required this.addressLine2, required this.starRating, required this.reviews});
}

final reviews = [
  Review(username: 'User1', urlImage: 'assets/user1.png', date: DateTime.now().toString(), description: 'Great location with beautiful views!'),
  Review(username: 'User2', urlImage: 'assets/user2.png', date: DateTime.now().toString(), description: 'Had a wonderful experience here.'),
  Review(username: 'User3', urlImage: 'assets/user3.png', date: DateTime.now().toString(), description: 'Highly recommend this place!'),
];

final locations = [
  Location(name: 'ATCOASTAL', urlImage: 'assets/sea.jpg', latitude: 'NORTH LAT 24', longitude: 'EAST LNG 17', addressLine1: 'La Cresenta-Montrose, CA91020 Glendale', addressLine2: 'NO. 791187', starRating: 4, reviews: reviews),
  Location(name: 'SYRACUSE', urlImage: 'assets/mountain.jpg', latitude: 'SRINIVAS MUKKA', longitude: '', addressLine1: 'CodeMeet 2024', addressLine2: 'DEC', starRating: 4, reviews: reviews),
  Location(name: 'OCEANIC', urlImage: 'assets/sea2.jpg', latitude: 'NORTH LAT 24', longitude: 'WEST LNG 08', addressLine1: 'La Cresenta-Montrose, CA91020 Glendale', addressLine2: 'NO. 791187', starRating: 4, reviews: reviews),
  Location(name: 'CODE MEET 2024', urlImage: 'assets/mountain2.jpg', latitude: 'DEC 2024', longitude: 'MANGALORE', addressLine1: 'CODE MEET 2024', addressLine2: 'SRINIVAS MUKKA', starRating: 4, reviews: reviews),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: Text('INTERESTS'), centerTitle: true, actions: [IconButton(icon: Icon(Icons.location_pin), onPressed: () {})], leading: IconButton(icon: Icon(Icons.search_outlined), onPressed: () {})),
      body: LocationsWidget(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.pin_drop_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.add_location), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ]),
    );
  }
}

class LocationsWidget extends StatefulWidget {
  @override
  _LocationsWidgetState createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  final pageController = PageController(viewportFraction: 0.8);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: locations.length,
            itemBuilder: (context, index) => LocationWidget(location: locations[index]),
            onPageChanged: (index) => setState(() => pageIndex = index),
          ),
        ),
        Text('${pageIndex + 1}/${locations.length}', style: TextStyle(color: Colors.white70)),
        SizedBox(height: 12)
      ],
    );
  }
}

class LocationWidget extends StatefulWidget {
  final Location location;

  const LocationWidget({required this.location});

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.location.addressLine1),
                  SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(widget.location.addressLine2, style: TextStyle(color: Colors.black45)), Row(children: List.generate(widget.location.starRating, (index) => Icon(Icons.star_rate, size: 18, color: Colors.blueGrey)))]),
                  SizedBox(height: 12),
                  Row(children: widget.location.reviews.map((review) => CircleAvatar(radius: 16, backgroundColor: Colors.black12, backgroundImage: AssetImage(review.urlImage))).toList())
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: (details) => setState(() => isExpanded = details.delta.dy < 0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: size.height * 0.5,
                width: size.width * 0.8,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1)], borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Stack(
                    children: [
                      SizedBox.expand(child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(8)), child: Image.asset(widget.location.urlImage, fit: BoxFit.cover))),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.location.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                            Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text(widget.location.latitude, style: TextStyle(color: Colors.white70)), Icon(Icons.location_on, color: Colors.white70), Text(widget.location.longitude, style: TextStyle(color: Colors.white70))])
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
