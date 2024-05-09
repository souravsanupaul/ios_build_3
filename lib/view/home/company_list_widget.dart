import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common/color_extension.dart';
import 'package:ott_code_frontend/models/OTTModel.dart';
import 'package:hive/hive.dart';
import 'package:ott_code_frontend/view/main_tab/main_tab_bar_view.dart';
import 'package:ott_code_frontend/view/login/login_view.dart';

class CompanyListWidget extends StatefulWidget {
  const CompanyListWidget({Key? key}) : super(key: key);

  @override
  _CompanyListWidgetState createState() => _CompanyListWidgetState();
}

class _CompanyListWidgetState extends State<CompanyListWidget> {
  late Future<List<OTTModel>> _companies;
  List<OTTModel> _filteredCompanies = [];

  @override
  void initState() {
    super.initState();
    _companies = _fetchCompanies();
  }

  // Fetching companies from API
  Future<List<OTTModel>> _fetchCompanies() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return [
        OTTModel(
          ottName: "Indimuse",
          websiteName: "indimuse.in",
          logoUrl: "assets/images/app_logo_new.png",
          apiUrl: "dummy_url_here",
          bucketUrl: "dummy_url_here",
        ),
        // OTTModel(
        //   ottName: "Flutflix",
        //   websiteName: "flutflix.in",
        //   logoUrl: "assets/images/american_hustle.png",
        //   apiUrl: "dummy_url_here",
        //   bucketUrl: "dummy_url_here",
        // ),
        OTTModel(
          ottName: "Netflix",
          websiteName: "flutflix.in",
          logoUrl: "assets/images/search_3.png",
          apiUrl: "dummy_url_here",
          bucketUrl: "dummy_url_here",
        ),
        // OTTModel(
        //   ottName: "Hotstar",
        //   websiteName: "flutflix.in",
        //   logoUrl: "assets/images/app_logo_old.png",
        //   apiUrl: "dummy_url_here",
        //   bucketUrl: "dummy_url_here",
        // ),
      ];
    });
  }

  Future<void> _filterCompanies(String query) async {
    final companies = await _companies;
    setState(() {
      if (query.isEmpty) {
        _filteredCompanies = [];
        return;
      }
      _filteredCompanies = companies.where((company) {
        return company.ottName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(top: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  hintText: 'Search OTT',
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 14, 14, 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: _filterCompanies,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _companies,
              builder: (context, AsyncSnapshot<List<OTTModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<OTTModel> companies = _filteredCompanies.isEmpty
                      ? snapshot.data!
                      : _filteredCompanies;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: companies.length,
                      itemBuilder: (context, index) {
                        OTTModel company = companies[index];
                        return SizedBox(
                          width: 100,
                          child: InkWell(
                            onTap: () {
                              _companyListSelecter(context, company);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: ApplicationColor.bgColor,
                                borderRadius: BorderRadius.circular(10.0),
                                border:
                                    Border.all(color: Colors.red, width: 1.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  company.logoUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to handle company selection
  Future<void> _companyListSelecter(
      BuildContext context, OTTModel company) async {
    var ottmodel = OTTModel(
        ottName: company.ottName,
        websiteName: company.websiteName,
        logoUrl: company.logoUrl,
        apiUrl: company.apiUrl,
        bucketUrl: company.bucketUrl);

    var box = await Hive.openBox<OTTModel>('OTTTable');
    await box.put('ottmodel', ottmodel);
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }
}
