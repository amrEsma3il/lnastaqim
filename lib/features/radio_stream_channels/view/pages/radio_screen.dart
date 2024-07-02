import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/radio_stream_channels/bussniess_logic/radio_cubit.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RadioCubit(),
      child: BlocConsumer<RadioCubit, RadioState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                    image: NetworkImage(
                        'https://play-lh.googleusercontent.com/QuVFM8a1DJFaLb3M0iHjgylkrS0ddvpBzDSHOGxs7YzqAFIHeXJwZ53aX7SaMImmA30')),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          // RadioCubit.get(context).next();
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          size: 50,
                        )),
                    state is RadioLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              // RadioCubit.get(context).playRadio();
                            },
                            icon: const Icon(
                              Icons.play_circle,
                              size: 50,
                            )),
                    IconButton(
                        onPressed: () {
                          // RadioCubit.get(context).back();
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 50,
                        ))
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
