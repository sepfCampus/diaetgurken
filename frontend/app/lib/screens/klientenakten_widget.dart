import 'package:flutter/material.dart';

class KlientenaktenWidget extends StatefulWidget
{
  const KlientenaktenWidget({ super.key });

  @override
  State<KlientenaktenWidget> createState() => _KlientenaktenWidgetState();
}

class _KlientenaktenWidgetState extends State<KlientenaktenWidget>
{
  static const Color darkGreen = Color(0xFF3E523D);
  static const Color lightGreen = Color(0xFFD3E1D0);

  final List<String> klientenakten =
  [
    '000001',
    '000002',
    '000003',
    '000004',
    '000005',
    '000006',
    '000007',
    '000008',
  ];

  String searchText = '';

  @override
  Widget build(BuildContext context)
  {
    final filteredList = klientenakten
        .where((id) => id.contains(searchText))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE9E9EE),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints)
          {
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
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.menu, color: Colors.white),
                      ),

                      const SizedBox(width: 8),

                      const Text(
                        'Klientenakten',
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
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 360),
                          child: Column(
                            children:
                            [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  onChanged: (value)
                                  {
                                    setState(()
                                    {
                                      searchText = value;
                                    });
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Suchen ...',
                                    hintStyle: TextStyle(color: Colors.white70),
                                    prefixIcon: Icon(Icons.search, color: Colors.white),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 18),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: darkGreen, width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  title: const Text('Neu'),
                                  trailing: const Icon(Icons.add),
                                  onTap: () {},
                                ),
                              ),

                              const SizedBox(height: 12),

                              ...filteredList.map(
                                (id) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Container(
                                    width: double.infinity,
                                    height: 56,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: lightGreen,
                                      border: Border.all(color: darkGreen, width: 0.8),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      id,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF4A5A48),
                                      ),
                                    ),
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
            );
          },
        ),
      ),
    );
  }
}