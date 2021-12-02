import 'package:flutter/material.dart';

class LeftAppBar extends StatelessWidget {
  const LeftAppBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: MediaQuery.of(context).size.height - 150,
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [BoxShadow(
          offset: Offset(-2, 0),
          blurRadius: 30,
          color: Colors.black.withOpacity(0.16) 
        )]
      ),
      child:  Column(children: <Widget>[
        
        const CircleAvatar(backgroundImage: AssetImage('assets/Sample_User_Icon.png'),),
        const Spacer(),
        MenuItem(title: "Home", ontap: (){}, icon: Icons.home_outlined, boldIcon: Icons.home, selected: true),
        MenuItem(title: "Pinned", ontap: (){}, icon: Icons.pin_drop_outlined, boldIcon: Icons.pin_drop, selected: false),
        MenuItem(title: "Explore", ontap: (){}, icon: Icons.home_outlined, boldIcon: Icons.home, selected: false),
        MenuItem(title: "Subscription", ontap: (){}, icon: Icons.save_outlined, boldIcon: Icons.save, selected: false),
        MenuItem(title: "Edit Profile", ontap: (){}, icon: Icons.home_outlined, boldIcon: Icons.home, selected: false),
        const Spacer()
      ])
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final IconData boldIcon;
  final bool selected;
  final VoidCallback ontap;
  const MenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.boldIcon,
    required this.selected,
    required this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      title: Text(title, style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
      trailing: Icon(selected ? boldIcon : icon),
    );
    // return 
    // InkWell(
    //       onTap: (){},
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children:<Widget>[
    //     Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10), 
    //         child: Text(
    //           title.toUpperCase(), 
    //           style: const TextStyle(color: Colors.black,)
    //         )
    //       ),
    //     Container(
    //       decoration: const BoxDecoration(
    //         shape: BoxShape.circle,
    //         image: DecorationImage(
    //           image: AssetImage('assets/images/Sample_User_Icon.png'),
    //           fit: BoxFit.fill,
    //         ),
    //         ),
    //       ),
    //     ] 
    //   )
    // );
  }
}