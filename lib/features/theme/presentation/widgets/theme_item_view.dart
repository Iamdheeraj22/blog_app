import 'package:flutter/material.dart';

class ThemeItemView extends StatelessWidget {
  const ThemeItemView({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        style: ListTileStyle.list,
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        trailing: isSelected
            ? Icon(
                Icons.check,
                size: 24,
              )
            : null,
      ),
    );
  }
}
/*
* Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Spacer(),
              // Create custom tick mark if isSelected is true
              if (isSelected) Icon(Icons.check),
            ],
          ),
        ),
      ),
* */
