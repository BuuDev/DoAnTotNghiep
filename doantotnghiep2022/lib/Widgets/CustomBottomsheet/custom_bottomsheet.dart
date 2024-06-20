import 'package:doantotnghiep/Config/Colors/colors.dart';
import 'package:doantotnghiep/Widgets/TextfieldCustom/textfield_custom.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    Key? key,
    required this.txtSearch,
    this.data,
    this.onTap,
  }) : super(key: key);

  final TextEditingController txtSearch;
  final List<dynamic>? data;
  final Function()? onTap;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late ValueNotifier<List<dynamic>?> lst = ValueNotifier(widget.data ?? []);
  late ValueNotifier<List<dynamic>?> lsttmp = ValueNotifier(widget.data ?? []);
  TextEditingController txtSearch = TextEditingController();
  void searchProvince(keyword) {
    lsttmp.value = [];
    for (dynamic item in lst.value!) {
      if (item.name.toLowerCase().contains(keyword.toLowerCase())) {
        lsttmp.value!.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverAppBar(
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.white,
                elevation: 0.0,
                pinned: true,
                title: ValueListenableBuilder<List<dynamic>?>(
                    valueListenable: lsttmp,
                    builder: (_, value, __) {
                      return TextFieldCustom(
                        suFFixIcon: const Icon(
                          Icons.search,
                          color: AppColors.tertiary,
                        ),
                        controller: txtSearch,
                        onChanged: (val) {
                          searchProvince(val);
                        },
                        placeholder: 'Tìm kiếm...',
                      );
                    }),
              ),
            ),
            ValueListenableBuilder<List<dynamic>?>(
                valueListenable: lsttmp,
                builder: (_, value, __) {
                  return lsttmp.value != null
                      ? SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return ListTile(
                              title: Text(value![index].name),
                              onTap: () {
                                Navigator.pop(context, value[index].name);
                              },
                            );
                          }, childCount: value!.length),
                        )
                      : const SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
