import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget HomePageProfSalud() {
  return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Inicio')),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
      ],
    ),
    tabBuilder: (BuildContext context, int index) {
      return CupertinoTabView(
        builder: (BuildContext context) {
          switch (index) {
            case 0:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Bienvenido! :3 ${index}'),
                ),
                child: Center(
                  child: CupertinoButton(child: Text('Hola'), onPressed: null),
                ),
              );
              break;
            case 1:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Page 1 of tab $index'),
                ),
                child: Center(
                  child: CupertinoButton(
                    child: const Text('Next page'),
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute<void>(
                          builder: (BuildContext context) {
                            return CupertinoPageScaffold(
                              navigationBar: CupertinoNavigationBar(
                                middle: Text('Page 2 of tab $index'),
                              ),
                              child: Center(
                                child: CupertinoButton(
                                  child: const Text('Back'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
          }

          /*return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Page 1 of tab $index'),
            ),
            child: Center(
              child: CupertinoButton(
                child: const Text('Next page'),
                onPressed: () {
                  print('Hola');
                  //Navigator.of(context).push();
                },
              ),
            ),
          );
          */
        },
      );
    },
  );
}
