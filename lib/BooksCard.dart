import 'package:flutter/material.dart';
import './AppColor.dart' as AppColors;

class BooksCard extends StatelessWidget {
  final String imagePath;
  final String bookRating;
  final String bookTitle;
  final String bookText;

  const BooksCard({
    super.key,
    required this.imagePath,
    required this.bookRating,
    required this.bookTitle,
    required this.bookText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.tabVarViewColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(0, 0),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, size: 24, color: AppColors.starColor),
                  const SizedBox(width: 5),
                  Text(bookRating, style: TextStyle(color: AppColors.menu2Color)),
                ],
              ),
              Text(
                bookTitle,
                style: const TextStyle(
                    fontSize: 20, fontFamily: 'Avenir', fontWeight: FontWeight.bold),
              ),
              Text(
                bookText,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Center(
                  child: Text(
                    'Play',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
