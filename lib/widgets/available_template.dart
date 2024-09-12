import 'package:flutter/material.dart';

class AvailableTemplates extends StatelessWidget {
  const AvailableTemplates({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Template> mockTemplates = [
      Template(
        imageUrl: 'https://cdn.mos.cms.futurecdn.net/25mEf9H2CYfpdX53bWHjK.jpg',
        title: 'Template 1',
        lastUpdated: 'Today',
      ),
      Template(
        imageUrl: 'https://cdn.mos.cms.futurecdn.net/25mEf9H2CYfpdX53bWHjK.jpg',
        title: 'Template 2',
        lastUpdated: 'Yesterday',
      ),
      Template(
        imageUrl: 'https://cdn.mos.cms.futurecdn.net/25mEf9H2CYfpdX53bWHjK.jpg',
        title: 'Template 3',
        lastUpdated: '3 days ago',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Templates',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.85,
        ),
        itemCount: mockTemplates.length,
        itemBuilder: (context, index) {
          final template = mockTemplates[index];
          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.network(
                      template.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    template.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Modified: ${template.lastUpdated}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Template {
  final String imageUrl;
  final String title;
  final String lastUpdated;

  Template({
    required this.imageUrl,
    required this.title,
    required this.lastUpdated,
  });
}
