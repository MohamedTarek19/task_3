import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'package:task_3/dataCubit/my_app_cubit.dart';
import 'package:task_3/helper.dart';
import 'package:task_3/widgets/item.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print('##########[${context.read<AppCubit>().flag?.length}]##############');
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return GridView.builder(
          itemCount: context.read<AppCubit>().products?.length,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (MediaQuery.of(context).size.width * 0.5) /
                  (MediaQuery.of(context).size.height * 0.3)),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: const EdgeInsets.only(top: 10),
                child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          context.read<AppCubit>().flag?[index] = !context.read<AppCubit>().flag![index];
                        });
                      },
                      child: Item(
                        itemName: context.read<AppCubit>().products?[index].title,
                        itemDesc: context.read<AppCubit>().products?[index].description,
                        itemPrice: context.read<AppCubit>().products?[index].price?.toDouble(),
                        itemPath: context.read<AppCubit>().products?[index].thumbnail,
                        itemfav: context.read<AppCubit>().flag?[index] ?? false,
                      ),
                    );
                  },
                ));
          },
        );
      },
    );
  }
}
