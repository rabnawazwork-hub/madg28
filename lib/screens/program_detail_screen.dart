import 'package:flutter/material.dart';
import 'package:madg28/notifiers/program_detail_notifier.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class ProgramDetailScreen extends StatefulWidget {
  final String programId;

  const ProgramDetailScreen({super.key, required this.programId});

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch program details when the widget is first created
    Provider.of<ProgramDetailNotifier>(context, listen: false)
        .fetchProgramDetails(widget.programId);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Consumer<ProgramDetailNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading || notifier.program == null) {
            return _buildSkeleton(context);
          }

          final program = notifier.program!;

          return CustomScrollView(
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
                      image: program.imageProvider,
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
          );
        },
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return SkeletonTheme(
      themeMode: ThemeMode.light,
      shimmerGradient: const LinearGradient(
        colors: [
          Color(0xFFD8E3E7),
          Color(0xFFC8D5DA),
          Color(0xFFD8E3E7),
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      darkShimmerGradient: const LinearGradient(
        colors: [
          Color(0xFF222222),
          Color(0xFF242424),
          Color(0xFF2B2B2B),
          Color(0xFF242424),
          Color(0xFF222222),
        ],
        stops: [
          0.0,
          0.2,
          0.5,
          0.8,
          1,
        ],
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  height: 280,
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
                  SkeletonParagraph(
                    style: const SkeletonParagraphStyle(
                      lines: 3,
                      spacing: 6,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 16,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        minLength: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 24,
                      width: 150,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (int i = 0; i < 4; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          const SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: 24,
                              height: 24,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 100,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          const Spacer(),
                          const SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 50,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  const SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 24,
                      width: 200,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      6,
                      (index) => const SkeletonLine(
                        style: SkeletonLineStyle(
                          width: 100,
                          height: 32,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 24,
                      width: 100,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (int i = 0; i < 3; i++)
                    SkeletonListTile(
                      hasLeading: false,
                      hasSubtitle: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
