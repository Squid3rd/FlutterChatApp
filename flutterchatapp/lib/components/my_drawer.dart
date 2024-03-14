import 'package:flutter/material.dart';
import 'package:flutterchatapp/services/auth/auth_service.dart';
import 'package:flutterchatapp/pages/settings_page.dart';



class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

void logout(){
    //  get auth
    final _auth = AuthService();
    _auth.signOut();

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(children: [
          // Logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
            ),
          ),

          // Home list
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("HOME"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          // setting list title
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("SETTING"),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);

                // Navigation Setting page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MySettingPage(),
                    ));
              },
            ),
          ),
        ]),
        // logout eiei
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25),
          child: ListTile(
            title: Text("LOG OUT"),
            leading: Icon(Icons.logout),
            onTap: logout,
          ),
        ),
      ]),
    );
  }
}
