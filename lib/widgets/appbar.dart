import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppbar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(
      "Abisiniya",
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).secondaryHeaderColor,
            fontWeight: FontWeight.bold,
          ),
    ),
    backgroundColor: Theme.of(context).primaryColor,
  );
}
//new commit