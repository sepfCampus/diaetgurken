import 'package:app/config/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/klarnamen_widget.dart';
import 'package:app/screens/klientenakten_widget.dart';
import 'package:app/screens/einstellungen_widget.dart';

class HomePageWidget extends StatefulWidget
{
  const HomePageWidget({ super.key });

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
{
  static const Color darkGreen = Color(0xFF3E523D);

  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints)
          {
            final double menuWidth =
                constraints.maxWidth < 500 ? 210 : 290;

            return Column(
              children:
              [
                Container(
                  height: 100,
                  width: double.infinity,
                  color: darkGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children:
                    [
                      IconButton(
                        onPressed: ()
                        {
                          setState(()
                          {
                            isMenuOpen = !isMenuOpen;
                          });
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 8),

                      const Text(
                        'Seitenbezeichnung',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Stack(
                    children:
                    [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),

                      if (isMenuOpen)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: menuWidth,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              color: darkGreen,
                              border: Border(
                                top: BorderSide(
                                  color: Colors.white,
                                  width: 1.2,
                                ),
                              ),
                            ),
                            child: Column(
                              children:
                              [
                                ListTile(
                                  leading: const Icon(Icons.settings, color: Colors.white),
                                  title: const Text(
                                    'Einstellungen',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: ()
                                  {
                                    setState(()
                                    {
                                      isMenuOpen = false;
                                    });

                                    Navigator.pushNamed(context, Routes.PAGE_SETTINGS);
                                  },
                                ),

                                const SizedBox(height: 8),

                                ListTile(
                                  leading: const Icon(Icons.folder, color: Colors.white),
                                  title: const Text(
                                    'Klientenakten',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: ()
                                    {
                                      setState(() 
                                      {
                                        isMenuOpen = false;
                                      });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => KlientenaktenWidget(),
                                        ),
                                      );
                                    },
                                ),

                                const SizedBox(height: 8),

                                ListTile(
                                  leading: const Icon(Icons.person_outline, color: Colors.white),
                                  title: const Text(
                                    'Klarnamen',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: ()
                                    {
                                      setState(() 
                                      {
                                        isMenuOpen = false;
                                      });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => KlarnamenWidget(),
                                        ),
                                      );
                                    },
                                ),

                                const SizedBox(height: 8),

                                ListTile(
                                  leading: const Icon(Icons.logout, color: Colors.white),
                                  title: const Text(
                                    'Abmelden',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}