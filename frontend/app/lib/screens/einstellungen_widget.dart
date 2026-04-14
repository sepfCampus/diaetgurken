import 'package:app/screens/passwort_aendern_widget.dart';
import 'package:app/screens/profil_loeschen_widget.dart';
import 'package:flutter/material.dart';

class EinstellungenWidget extends StatefulWidget
{
  const EinstellungenWidget({ super.key });

  @override
  State<EinstellungenWidget> createState() => _EinstellungenWidgetState();
}

class _EinstellungenWidgetState extends State<EinstellungenWidget>
{
  static const Color darkGreen = Color(0xFF3E523D);
  static const Color lightGreenBackground = Color(0xFFDCE8D8);

  String? farbdarstellung = 'Standard';
  String? schriftgroesse = 'Standard';

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
                    'Einstellungen',
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
                            'E-Mail-Adresse:',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4A5A48),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: darkGreen.withOpacity(0.7)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'vorname.nachname@email.at',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Text(
                            'Registernr.:',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4A5A48),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: darkGreen.withOpacity(0.7)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'AA-BBB-123456',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          const Text(
                            'Farbdarstellung',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4A5A48),
                            ),
                          ),

                          RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Standard'),
                            value: 'Standard',
                            groupValue: farbdarstellung,
                            activeColor: darkGreen,
                            onChanged: (value)
                            {
                              setState(()
                              {
                                farbdarstellung = value;
                              });
                            },
                          ),

                          RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Hoher Kontrast'),
                            value: 'Hoher Kontrast',
                            groupValue: farbdarstellung,
                            activeColor: darkGreen,
                            onChanged: (value)
                            {
                              setState(()
                              {
                                farbdarstellung = value;
                              });
                            },
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            'Schriftgröße',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4A5A48),
                            ),
                          ),

                          RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Standard'),
                            value: 'Standard',
                            groupValue: schriftgroesse,
                            activeColor: darkGreen,
                            onChanged: (value)
                            {
                              setState(()
                              {
                                schriftgroesse = value;
                              });
                            },
                          ),

                          RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Groß'),
                            value: 'Groß',
                            groupValue: schriftgroesse,
                            activeColor: darkGreen,
                            onChanged: (value)
                            {
                              setState(()
                              {
                                schriftgroesse = value;
                              });
                            },
                          ),

                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 170,
                              height: 44,
                              child: OutlinedButton(
                                onPressed: ()
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PasswortAendernWidget(),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF4A5A48),
                                  side: BorderSide(color: darkGreen.withOpacity(0.7)),
                                ),
                                child: const Text('Passwort ändern'),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 170,
                              height: 44,
                              child: OutlinedButton(
                                onPressed: ()
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ProfilLoeschenWidget(),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF4A5A48),
                                  side: BorderSide(color: darkGreen.withOpacity(0.7)),
                                ),
                                child: const Text('Profil löschen'),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Transform.translate(
                              offset: const Offset(-24, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
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