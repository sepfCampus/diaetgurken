import 'package:flutter/material.dart';

class ProfilLoeschenWidget extends StatelessWidget
{
  const ProfilLoeschenWidget({ super.key });

  static const Color darkGreen = Color(0xFF3E523D);
  static const Color lightGreenBackground = Color(0xFFDCE8D8);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: lightGreenBackground,
      body: SafeArea(
        child: Column(
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
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.menu, color: Colors.white),
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    'Profil löschen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                color: lightGreenBackground,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 360),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          const Text(
                            'Profil wirklich löschen?',
                            style: TextStyle(fontSize: 16),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF4A5A48),
                                side: BorderSide(color: darkGreen.withOpacity(0.7)),
                                backgroundColor: const Color(0xFFD5E3D1),
                              ),
                              child: const Text('Profil löschen'),
                            ),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: ()
                              {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkGreen,
                                foregroundColor: Colors.white,
                                elevation: 0,
                              ),
                              child: const Text('Abbrechen'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}