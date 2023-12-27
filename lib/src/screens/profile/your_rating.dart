import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/screens/profile/bloc/profile_cubit.dart';

import '../../../global/utilities/public.dart';
import '../../di/dependencies.dart';
import '../detail/bloc/review_item_cubit.dart';
import '../detail/widgets/reviews.dart';
import '../widgets/responsive_builder.dart';

class YourRatings extends StatefulWidget {
  const YourRatings({super.key});

  @override
  State<YourRatings> createState() => _YourRatingsState();
}

class _YourRatingsState extends State<YourRatings> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getMyReview();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: Public.tabletSize),
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveBuilder.setHorizontalPadding(context),
            vertical: 20,
          ),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.loading) {
                return SizedBox(
                  height: MediaQuery
                      .sizeOf(context)
                      .height * 0.7,
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
                      create: (context) => getIt.get<ReviewItemCubit>(),
                      child: ReviewItem(
                        review: (state.reviews ?? [])[index],
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
          ),
        ),
      ),
    );
  }
}
