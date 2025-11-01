import 'package:flutter/material.dart';
import 'package:madg28/notifiers/program_detail_notifier.dart';
import 'package:madg28/models/program.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProgramDetailScreen extends StatefulWidget {
  final String programId;

  const ProgramDetailScreen({super.key, required this.programId});

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  double _currentRating = 0.0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProgramDetailNotifier>(context, listen: false)
          .fetchProgramDetails(widget.programId);
    });
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Consumer<ProgramDetailNotifier>(
        builder: (context, notifier, child) {
          return Skeletonizer(
            enabled: notifier.isLoading || notifier.program == null,
            child: CustomScrollView(
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
                      notifier.program?.name ?? "Program Name",
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
                      tag: 'program-${notifier.program?.id ?? widget.programId}',
                      child: Image(
                        image: notifier.program?.imageProvider ?? AssetImage('assets/images/placeholder.png'),
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
                          notifier.program?.description ?? "Loading description...",
                          style: textTheme.bodyLarge?.copyWith(height: 1.5),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 24),
                        if (notifier.program != null)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: notifier.isEnrolled
                                  ? null
                                  : () async {
                                      final messenger = ScaffoldMessenger.of(context);
                                      await notifier.enrollInCourse();
                                      if (!mounted) return;
                                      messenger.showSnackBar(
                                        const SnackBar(content: Text('Enrolled successfully!')),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(notifier.isEnrolled ? 'Enrolled' : 'Enroll Course'),
                            ),
                          ),
                        const SizedBox(height: 24),
                        _buildSectionTitle(context, 'Program Overview'),
                        const SizedBox(height: 12),
                        _buildInfoRow(context, 'Instructor', notifier.program?.instructor ?? "-",
                            Icons.person_outline, colorScheme.primary),
                        _buildInfoRow(context, 'Level', notifier.program?.level ?? "-",
                            Icons.signal_cellular_alt, colorScheme.primary),
                        _buildInfoRow(context, 'Duration', notifier.program?.duration ?? "-",
                            Icons.timer_outlined, colorScheme.primary),
                        _buildInfoRow(context, 'Rating', '${notifier.program?.rating ?? 0.0} / 5.0',
                            Icons.star_half, Colors.amber[700]!),
                        const SizedBox(height: 24),
                        _buildSectionTitle(context, 'What you will learn'),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: (notifier.program?.whatYouWillLearn ?? List.generate(5, (index) => "learning item"))
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
                        if (notifier.program != null)
                          _buildCourseFeedbackSection(context, notifier.program!),
                        const SizedBox(height: 24),
                        _buildSectionTitle(context, 'Lessons'),
                        const SizedBox(height: 12),
                        ...(notifier.program?.lessons ?? List.generate(3, (index) => Lesson(id: index.toString(), title: "title", duration: "duration"))).asMap()
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Details for lesson ${entry.key + 1}: ${entry.value.title}. This is a placeholder for more detailed lesson content.',
                                            style: textTheme.bodyMedium,
                                          ),
                                          const SizedBox(height: 16),
                                          _buildFeedbackSection(context, entry.value),
                                        ],
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
        },
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context, Lesson lesson) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ProgramDetailNotifier notifier = Provider.of<ProgramDetailNotifier>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Feedback'),
        const SizedBox(height: 12),
        if (lesson.feedback.isEmpty)
          Text(
            'No feedback yet. Be the first to leave a review!',
            style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
          ),
        ...lesson.feedback.map((f) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: f.rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          f.userId,
                          style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          '${f.date.day}/${f.date.month}/${f.date.year}',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      f.comment,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )),
        const SizedBox(height: 24),
        _buildSectionTitle(context, 'Leave a Review'),
        const SizedBox(height: 12),
        RatingBar.builder(
          initialRating: _currentRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _currentRating = rating;
            });
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _feedbackController,
          decoration: InputDecoration(
            labelText: 'Your feedback',
            hintText: 'Tell us what you think...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            alignLabelWithHint: true,
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            if (_currentRating > 0 && _feedbackController.text.isNotEmpty) {
              final newFeedback = CourseFeedback(
                userId: 'currentUser', // TODO: Replace with actual user ID
                rating: _currentRating,
                comment: _feedbackController.text,
                date: DateTime.now(),
              );
              await notifier.submitFeedback(lesson.id, newFeedback);
              setState(() {
                _currentRating = 0.0;
                _feedbackController.clear();
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please provide a rating and feedback.')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Submit Feedback'),
        ),
      ],
    );
  }

  Widget _buildCourseFeedbackSection(BuildContext context, Program program) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ProgramDetailNotifier notifier = Provider.of<ProgramDetailNotifier>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Course Feedback'),
        const SizedBox(height: 12),
        if (program.feedback.isEmpty)
          Text(
            'No feedback yet. Be the first to leave a review!',
            style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
          ),
        ...program.feedback.map((f) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: f.rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          f.userId,
                          style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          '${f.date.day}/${f.date.month}/${f.date.year}',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      f.comment,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )),
        const SizedBox(height: 24),
        _buildSectionTitle(context, 'Leave a Review for the Course'),
        const SizedBox(height: 12),
        RatingBar.builder(
          initialRating: _currentRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _currentRating = rating;
            });
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _feedbackController,
          decoration: InputDecoration(
            labelText: 'Your feedback',
            hintText: 'Tell us what you think...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            alignLabelWithHint: true,
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            if (_currentRating > 0 && _feedbackController.text.isNotEmpty) {
              final newFeedback = CourseFeedback(
                userId: 'currentUser', // TODO: Replace with actual user ID
                rating: _currentRating,
                comment: _feedbackController.text,
                date: DateTime.now(),
              );
              await notifier.submitCourseFeedback(newFeedback);
              setState(() {
                _currentRating = 0.0;
                _feedbackController.clear();
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please provide a rating and feedback.')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Submit Course Feedback'),
        ),
      ],
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
