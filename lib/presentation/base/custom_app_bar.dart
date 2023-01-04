import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? showLeading ;
  final void Function()? leadingAction ;

  const CustomAppBar( {Key? key,  this.title , this.leadingAction, this.showLeading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.withOpacity(0.7),
      automaticallyImplyLeading: false,
      centerTitle: true,
      leadingWidth: 80,
      title: Text( title ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
      leading:showLeading == true ?
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: InkWell(
          onTap: leadingAction ?? () {
            Navigator.pop(context);
            },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Icon(Icons.arrow_back)
            ),
          ),
        ),
      ):const SizedBox(),
    );
  }
  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
