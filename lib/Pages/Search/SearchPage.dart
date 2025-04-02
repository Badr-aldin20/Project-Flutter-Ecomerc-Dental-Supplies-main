// Pages/Search/SearchPage.dart
import 'package:dental_supplies/Pages/ai/ai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'package:dental_supplies/Pages/Other/EmpityData.dart';
import 'package:dental_supplies/Pages/Other/NoConnect.dart';
import 'package:dental_supplies/Pages/Product/ProdectDetails.dart';
import 'package:dental_supplies/Utils/Api.dart';
import 'package:dental_supplies/Utils/Check internet.dart';
import 'package:dental_supplies/Utils/ColorsApp.dart';
import 'package:dental_supplies/Utils/LinksApp.dart';
import 'package:dental_supplies/Utils/sqlDB+ALL.dart';
import 'package:dental_supplies/Widget/CardProdect.dart';
import 'package:dental_supplies/Widget/Loading.dart';
import 'package:dental_supplies/Widget/SearchHistory.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController txtSearch = TextEditingController();
  final sqlDb sql = sqlDb();

  bool loading = false;
  bool loadingSearch = true;
  bool isHiddenSearch = false;
  bool autofocus = true;
  bool isConnectNet = true;

  List data = [];
  List dataSearch = [];

  // Internet connection checker
  Future<void> _checkInternet() async {
    isConnectNet = await checkInternet();
    setState(() {});
  }

  // Fetch data from API based on search text
  Future<void> GetData() async {
    await _checkInternet();
    loading = true;
    data.clear();
    setState(() {});

    if (txtSearch.text.isNotEmpty) {
      var response =
          await Api.get("${LinksApp.searchByText}/${txtSearch.text}");
      if (response["status"] == "200") {
        data.addAll(response["data"]);
      }
    }

    loading = false;
    setState(() {});
  }

  // Add search term to local database
  Future<void> _addToDB() async {
    if (txtSearch.text.isNotEmpty) {
      var result = await sql.insert_plus("db", {"name": txtSearch.text});
      if (result > 0) await _getDataToDB();
    }
  }

  // Remove specific search term from database
  Future<void> _remove(int id) async {
    var result = await sql.delete_plus("db", "id == $id");
    if (result > 0) await _getDataToDB();
    setState(() {});
  }

  // Remove all search terms from database
  Future<void> _removeAllData() async {
    var result = await sql.delete_plus("db", "1==1");
    if (result > 0) await _getDataToDB();
    setState(() {});
  }

  // Fetch search history data from database
  Future<void> _getDataToDB() async {
    loading = true;
    dataSearch.clear();
    setState(() {});

    var result = await sql.select("SELECT * FROM db ORDER BY id DESC LIMIT 7");
    dataSearch.addAll(result);

    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _checkInternet();
    _getDataToDB();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: !isConnectNet
            ? NoConnect(onTap: _checkInternet)
            : SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    _buildSearchField(),
                    if (!isHiddenSearch) _buildSearchHistoryTitle(),
                    if (!isHiddenSearch && dataSearch.isNotEmpty)
                      _buildSearchHistoryList(),
                    if (!isHiddenSearch && dataSearch.isEmpty)
                      const Text(
                        "لا توجد نتائج بحث محفوظة",
                        style: TextStyle(color: ColorsApp.gray),
                      ),
                    if (isHiddenSearch) _buildSearchResults()
                  ],
                ),
              ),
      ),
    );
  }

  // Widget for search field
  Widget _buildSearchField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 20, 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: ColorsApp.gray),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => Ai());
                  },
                  child: Icon(Icons.camera_alt_outlined,
                      size: 40, color: ColorsApp.gray),
                ),
                _divider(),
                const Icon(Icons.search, size: 40, color: ColorsApp.gray),
                const SizedBox(width: 10),
                _searchTextField()
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 50,
            color: ColorsApp.primary,
          ),
        )
      ],
    );
  }

  // Divider between icons
  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 2,
      height: 40,
      color: ColorsApp.gray,
    );
  }

  // Search text field widget
  Widget _searchTextField() {
    return Expanded(
      child: TextField(
        onChanged: (val) {
          GetData();
          setState(() => isHiddenSearch = val.isNotEmpty);
        },
        onEditingComplete: () {
          _addToDB();
          FocusScope.of(context).unfocus();
        },
        textInputAction: TextInputAction.search,
        textAlign: TextAlign.center,
        autofocus: autofocus,
        controller: txtSearch,
        decoration: const InputDecoration(
          hintText: "ابــحــثــ عــنــ مــنــتــجــ...",
        ),
      ),
    );
  }

  // Widget for search history title
  Widget _buildSearchHistoryTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          const Text("سجل البحث"),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              color: ColorsApp.gray,
              height: 1,
            ),
          )
        ],
      ),
    );
  }

  // Widget for search history list
  Widget _buildSearchHistoryList() {
    return Expanded(
      child: ListView.builder(
        itemCount: dataSearch.length + 1,
        itemBuilder: (context, index) {
          if (index == dataSearch.length) {
            return InkWell(
              onTap: _removeAllData,
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                child: const Text(
                  "حذف جميع نتائج البحث المحفوظة",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: ColorsApp.gray,
                  ),
                ),
              ),
            );
          } else {
            return SearchHistory(
              txt: dataSearch[index]["name"],
              Remove: () => _remove(dataSearch[index]["id"]),
              Search: () {
                txtSearch.text = dataSearch[index]["name"];
                GetData();
                setState(() => isHiddenSearch = true);
              },
            );
          }
        },
      ),
    );
  }

  // Widget for search results
  Widget _buildSearchResults() {
    return Expanded(
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? const EmpityData(txt: "لم يتم العثور على أي نتائج بحث.")
              : GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: .7,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return CardProdect(
                      onTap: () async {
                        String name = data[index]["name"];
                        List r = await sql
                            .select("SELECT * FROM db WHERE name == '$name'");
                        if (r.isEmpty) {
                          await sql.insert_plus("db", {"name": name});
                        }
                        Get.to(() => ProdectDetails(
                              idAdmin: data[index]["Manger_Id"],
                              idProduct: data[index]["id"],
                            ));
                      },
                      Img: "${LinksApp.serverSrcImage}/${data[index]["image"]}",
                      name: data[index]["name"],
                      price: data[index]["price_buy"],
                      id: data[index]["id"],
                    );
                  },
                ),
    );
  }
}
