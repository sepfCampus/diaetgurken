import 'package:flutter/material.dart';

class PasswortAendernWidget extends StatelessWidget
{
  const PasswortAendernWidget({ super.key });

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
                    'Passwort ändern',
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
                          const Text('Altes Passwort:'),

                          const SizedBox(height: 8),

                          Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: darkGreen.withOpacity(0.7)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '********',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Text('Neues Passwort:'),

                          const SizedBox(height: 8),

                          Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: darkGreen.withOpacity(0.7)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '************',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Text('Neues Passwort bestätigen:'),

                          const SizedBox(height: 8),

                          Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: darkGreen.withOpacity(0.7)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '************',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:
                            [
                              SizedBox(
                                width: 140,
                                height: 44,
                                child: OutlinedButton(
                                  onPressed: ()
                                  {
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF4A5A48),
                                    side: BorderSide(color: darkGreen.withOpacity(0.7)),
                                  ),
                                  child: const Text('Abbrechen'),
                                ),
                              ),

                              const SizedBox(width: 12),

                              SizedBox(
                                width: 140,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkGreen,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                  ),
                                  child: const Text('Speichern'),
                                ),
                              ),
                            ],
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