
import 'package:flutter/material.dart';
import 'package:madg28/models/program.dart';

class ProgramDetailScreen extends StatelessWidget {
  final Program program;

  const ProgramDetailScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(
                program.name,
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.black.withAlpha((0.6 * 255).round()),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              background: Hero(
                tag: 'program-${program.id}',
                child: Image(
                  image: program.imageProvider, // Use imageProvider
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                  color: Colors.black.withAlpha((0.3 * 255).round()),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.description,
                    style: textTheme.bodyLarge?.copyWith(height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(context, 'Program Overview'),
                  const SizedBox(height: 12),
                  _buildInfoRow(context, 'Instructor', program.instructor,
                      Icons.person_outline, colorScheme.primary),
                  _buildInfoRow(context, 'Level', program.level,
                      Icons.signal_cellular_alt, colorScheme.primary),
                  _buildInfoRow(context, 'Duration', program.duration,
                      Icons.timer_outlined, colorScheme.primary),
                  _buildInfoRow(context, 'Rating', '${program.rating} / 5.0',
                      Icons.star_half, Colors.amber[700]!),
                  const SizedBox(height: 24),
                  _buildSectionTitle(context, 'What you will learn'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: program.whatYouWillLearn
                        .map((item) => Chip(
                              avatar: Icon(Icons.check,
                                  color: colorScheme.onSecondaryContainer),
                              label: Text(item),
                              backgroundColor: colorScheme.secondaryContainer,
                              labelStyle: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSecondaryContainer),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(context, 'Lessons'),
                  const SizedBox(height: 12),
                  ...program.lessons
                      .asMap()
                      .entries
                      .map(
                        (entry) => Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: colorScheme.primaryContainer,
                              child: Text(
                                '${entry.key + 1}',
                                style: textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onPrimaryContainer),
                              ),
                            ),
                            title: Text(
                              entry.value.title,
                              style: textTheme.titleMedium,
                            ),
                            trailing: Text(
                              entry.value.duration,
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Details for lesson ${entry.key + 1}: ${entry.value.title}. This is a placeholder for more detailed lesson content.',
                                  style: textTheme.bodyMedium,
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
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String title, String value,
      IconData icon, Color iconColor) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '$title: ',
              style: textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      title,
      style: textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
