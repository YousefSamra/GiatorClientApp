import 'package:flutter/material.dart';

class Reviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      width: size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_half_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Reviews",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          SizedBox(
            height: size.height * 0.15,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return _CardReview(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _CardReview(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.6,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey[200],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star_rate,
                color: Colors.amber,
                size: 14,
              ),
              Icon(
                Icons.star_rate,
                color: Colors.amber,
                size: 14,
              ),
              Icon(
                Icons.star_rate,
                color: Colors.amber,
                size: 14,
              ),
              Icon(
                Icons.star_rate,
                color: Colors.amber,
                size: 14,
              ),
              Icon(
                Icons.star_rate,
                color: Colors.amber,
                size: 14,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'دكتور رائع',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Hassan A.',
            style: TextStyle(color: Colors.grey[600], fontSize: 10),
          ),
          Text(
            '02 January 2021',
            style: TextStyle(color: Colors.grey[600], fontSize: 10),
          ),
        ],
      ),
    );
  }
}
