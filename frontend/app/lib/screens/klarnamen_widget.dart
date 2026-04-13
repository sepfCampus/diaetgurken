import 'package:flutter/material.dart';

class KlarnamenWidget extends StatefulWidget
{
  const KlarnamenWidget({ super.key });

  @override
  State<KlarnamenWidget> createState() => _KlarnamenWidgetState();
}

class _KlarnamenWidgetState extends State<KlarnamenWidget>
{
  static const Color darkGreen = Color(0xFF3E523D);

  final List<String> aktenIds =
  [
    '000009',
    '000008',
    '000007',
  ];

  String? selectedAkte = '000009';

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    'Klarnamen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  const Text(
                    'Klientenakte',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5B48),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5E3D1),
                      border: Border.all(color: darkGreen.withOpacity(0.7)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedAkte,
                        isExpanded: true,
                        icon: const Icon(Icons.expand_more, color: Colors.black),
                        items: aktenIds.map((id)
                        {
                          return DropdownMenuItem<String>(
                            value: id,
                            child: Text(id),
                          );
                        }).toList(),
                        onChanged: (value)
                        {
                          setState(()
                          {
                            selectedAkte = value;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

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
                        hintText: 'Passwort',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:
                    [
                      OutlinedButton(
                        onPressed: ()
                        {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF4A5B48),
                          side: BorderSide(color: darkGreen.withOpacity(0.7)),
                          minimumSize: const Size(110, 44),
                        ),
                        child: const Text('Abbrechen'),
                      ),

                      const SizedBox(width: 12),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkGreen,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(110, 44),
                          elevation: 0,
                        ),
                        child: const Text('Anzeigen'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}