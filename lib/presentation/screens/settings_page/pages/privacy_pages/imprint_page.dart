import 'package:chattyevent_app_flutter/application/bloc/imprint/imprint_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class ImprintPage extends StatefulWidget {
  const ImprintPage({super.key});

  @override
  State<ImprintPage> createState() => _ImprintPageState();
}

class _ImprintPageState extends State<ImprintPage> {
  @override
  void initState() {
    BlocProvider.of<ImprintCubit>(context).getImprintViaApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Impressum",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: BlocBuilder<ImprintCubit, ImprintState>(
        builder: (context, state) {
          if (state.imprint != null) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(state.imprint!.imprintDescription),
                    const SizedBox(height: 20),
                    Text("Name: ${state.imprint!.name}"),
                    const SizedBox(height: 2),
                    Text(
                      "Addresse: ${state.imprint!.address.street} ${state.imprint!.address.housenumber}",
                    ),
                    const SizedBox(height: 2),
                    Text("Land: ${state.imprint!.address.country}"),
                    const SizedBox(height: 20),
                    Text("Nummer: ${state.imprint!.contact.phoneNumber}"),
                    const SizedBox(height: 2),
                    Text("E-Mail: ${state.imprint!.contact.email}"),
                    if (state.imprint!.contact.websiteUrl != null) ...[
                      const SizedBox(height: 2),
                      Text("Webseite: ${state.imprint!.contact.websiteUrl!}")
                    ],
                    const SizedBox(height: 20),
                    Text(
                      state.imprint!.disclaimer.title,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(state.imprint!.disclaimer.content),
                  ],
                ),
              ),
            );
          }

          if (state.imprintLoading) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: const [
                    SizedBox(height: 8),
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 300),
                    ),
                    SizedBox(height: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 300),
                    ),
                    SizedBox(height: 2),
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 300),
                    ),
                    SizedBox(height: 2),
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 300),
                    ),
                    SizedBox(height: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 300),
                    ),
                    SizedBox(height: 2),
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 300),
                    ),
                    SizedBox(height: 2),
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 300),
                    ),
                    SizedBox(height: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(width: 100),
                    ),
                    SizedBox(height: 4),
                    SkeletonLine(
                      style: SkeletonLineStyle(height: 60),
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: Button(
                  onTap: () =>
                      BlocProvider.of<ImprintCubit>(context).getImprintViaApi(),
                  text: "Laden",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
