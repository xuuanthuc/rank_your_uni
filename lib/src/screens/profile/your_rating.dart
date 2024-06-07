import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/global/style/app_colors.dart';
import 'package:template/l10n/l10n.dart';
import 'package:template/src/screens/detail/bloc/professor_review_item_cubit.dart';
import 'package:template/src/screens/profile/bloc/profile_cubit.dart';
import 'package:template/src/screens/widgets/primary_button.dart';
import '../../di/dependencies.dart';
import '../detail/bloc/university_review_item_cubit.dart';
import '../detail/widgets/professor_reviews.dart' as lecturer;
import '../detail/widgets/university_reviews.dart' as uni;

class YourRatings extends StatefulWidget {
  const YourRatings({super.key});

  @override
  State<YourRatings> createState() => _YourRatingsState();
}

class _YourRatingsState extends State<YourRatings> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            PrimaryButton(
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
              title: text.university,
              hasBorder: _currentIndex == 1,
              backgroundColor: _currentIndex == 0 ? AppColors.primary : Colors.white,
              titleTextStyleColor: _currentIndex == 1 ? AppColors.primary : Colors.white,
            ),
            const SizedBox(width: 15),
            PrimaryButton(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              title: text.professor,
              hasBorder: _currentIndex == 0,
              backgroundColor: _currentIndex == 1 ? AppColors.primary : Colors.white,
              titleTextStyleColor: _currentIndex == 0 ? AppColors.primary : Colors.white,
            ),
          ],
        ),
        const SizedBox(height: 15),
        IndexedStack(
          index: _currentIndex,
          children: const [
            MyUniversityReviewsPage(),
            MyProfessorReviewsPage(),
          ],
        ),
      ],
    );
  }
}

class MyUniversityReviewsPage extends StatefulWidget {
  const MyUniversityReviewsPage({super.key});

  @override
  State<MyUniversityReviewsPage> createState() =>
      _MyUniversityReviewsPageState();
}

class _MyUniversityReviewsPageState extends State<MyUniversityReviewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getMyUniversityReview(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.7,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: (((index + 1) % 3) == 0) ? 75 : 0,
              ),
              child: BlocProvider(
                create: (context) => getIt.get<UniversityReviewItemCubit>(),
                child: uni.ReviewItem(
                  review: (state.reviews ?? [])[index],
                  currentUser: state.userAuthenticated,
                  onUpdateReviewIndex: (review) {
                    (state.reviews ?? [])[index] = review;
                  },
                ),
              ),
            );
          },
          itemCount: state.reviews?.length ?? 0,
          separatorBuilder: (_, __) => const SizedBox(height: 30),
        );
      },
    );
  }
}

class MyProfessorReviewsPage extends StatefulWidget {
  const MyProfessorReviewsPage({super.key});

  @override
  State<MyProfessorReviewsPage> createState() => _MyProfessorReviewsPageState();
}

class _MyProfessorReviewsPageState extends State<MyProfessorReviewsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getMyProfessorReview(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.7,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: (((index + 1) % 3) == 0) ? 75 : 0,
              ),
              child: BlocProvider(
                create: (context) => getIt.get<ProfessorReviewItemCubit>(),
                child: lecturer.ReviewItem(
                  review: (state.professorReviews ?? [])[index],
                  currentUser: state.userAuthenticated,
                  onUpdateReviewIndex: (review) {
                    (state.professorReviews ?? [])[index] = review;
                  },
                ),
              ),
            );
          },
          itemCount: state.professorReviews?.length ?? 0,
          separatorBuilder: (_, __) => const SizedBox(height: 30),
        );
      },
    );
  }
}
