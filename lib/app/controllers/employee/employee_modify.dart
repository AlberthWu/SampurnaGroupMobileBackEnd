import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/employee/employee_profile.dart';
import 'package:asm/app/controllers/employee/employee_skorsing.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/autocomplete_model.dart';
import 'package:asm/app/service/autocomplete_service.dart';
import 'package:asm/app/views/widgets/auto_complete_widget.dart';
import 'package:asm/app/views/widgets/checkbox_widget.dart';
import 'package:asm/app/views/widgets/date_widget.dart';
import 'package:asm/app/views/widgets/dropdownlist_widget.dart';
import 'package:asm/app/views/widgets/information_title.dart';
import 'package:asm/app/views/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:asm/app/service/employee.dart';
import 'package:asm/app/models/employee/get.dart';

class EmployeeModify extends StatefulWidget {
  final int id;

  const EmployeeModify({
    Key? key,
    this.id = 0,
  }) : super(key: key);

  @override
  State<EmployeeModify> createState() => _EmployeeModifyState();
}

class _EmployeeModifyState extends State<EmployeeModify> {
  employeeService get service => GetIt.I<employeeService>();
  bool get isEditing => widget.id != 0;

  autoCompleteService get serviceAutoComplete => GetIt.I<autoCompleteService>();
  late APIResponse<List<autocompleteListModel>> _apiResponse;

  late employeeGetModel _model;
  bool _isLoading = false;
  late String errorMessage = "";
  bool _isEdit = true;

  TextEditingController _companyController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _aliasController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _joinDateController = TextEditingController();
  TextEditingController _resignDateController = TextEditingController();
  TextEditingController _resignMemoController = TextEditingController();

  TextEditingController _birthPlaceController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _kkController = TextEditingController();
  TextEditingController _ktpController = TextEditingController();
  TextEditingController _npwpController = TextEditingController();
  TextEditingController _bpjsController = TextEditingController();
  TextEditingController _bpjsTkController = TextEditingController();
  TextEditingController _accountNoController = TextEditingController();
  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _wifeNameController = TextEditingController();
  TextEditingController _childrenController = TextEditingController();
  TextEditingController _emergencyNameController = TextEditingController();
  TextEditingController _emergencyPhoneController = TextEditingController();
  TextEditingController _emergencyRelationController = TextEditingController();
  TextEditingController _emergencyNameInhouseController =
      TextEditingController();
  TextEditingController _emergencyPhoneInhouseController =
      TextEditingController();
  TextEditingController _emergencyRelationInhouseController =
      TextEditingController();
  TextEditingController _marriageController = TextEditingController();
  TextEditingController _religionController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _npwpStatusController = TextEditingController();
  TextEditingController _sexController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _livingAddressController = TextEditingController();
  TextEditingController _ktpAddressController = TextEditingController();
  TextEditingController _bankController = TextEditingController();

  TextEditingController _licenseCityController = TextEditingController();
  TextEditingController _licenseTypeController = TextEditingController();
  TextEditingController _licenseNoController = TextEditingController();
  TextEditingController _licenseIssueController = TextEditingController();
  TextEditingController _licenseExpController = TextEditingController();
  TextEditingController _licenseCardController = TextEditingController();
  TextEditingController _licenseHoldController = TextEditingController();
  TextEditingController _licenseHandOverController = TextEditingController();

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    setState(() {
      _isLoading = true;
    });

    await service.GetEmployee(widget.id).then(
      (response) {
        if (response.status) {
          errorMessage = response.message;
          _model = employeeGetModel();
        } else {
          _model = response.data;
        }
      },
    );

    _setDataCompany();
    _setDataEmployee();
    _setDataSim();

    setState(() {
      _isLoading = false;
    });
  }

  _setDataCompany() {
    _companyController.text = _model.company_name!;
    _nikController.text = _model.nik!;
    _nameController.text = _model.name!;
    _aliasController.text = _model.alias!;
    _departmentController.text = _model.department_name!;
    _divisionController.text = _model.division_name!;
    _occupationController.text = _model.occupation_name!;
    _departmentController.text = _model.department_name!;
    _statusController.text = _model.status_employee!;
    _joinDateController.text = _model.join_date!;
    _resignDateController.text = _model.resign_date!;
    _resignMemoController.text = _model.resign_memo!;
  }

  _setDataEmployee() {
    _birthPlaceController.text = _model.place_of_birth!.toString();
    _birthDateController.text = _model.date_of_birth!.toString();
    _zipController.text = _model.zip!.toString();
    _phoneController.text = _model.phone!.toString();
    _kkController.text = _model.kartu_keluarga!.toString();
    _ktpController.text = _model.ktp!.toString();
    _npwpController.text = _model.npwp!.toString();
    _bpjsController.text = _model.bpjs!.toString();
    _bpjsTkController.text = _model.bpjs_tk!.toString();
    _accountNoController.text = _model.bank_no!.toString();
    _accountNameController.text = _model.bank_account_name!.toString();
    _wifeNameController.text = _model.husband_wife_name!.toString();
    _childrenController.text = _model.children!.toString();
    _emergencyNameController.text = _model.emergency_name!.toString();
    _emergencyPhoneController.text = _model.emergency_phone!.toString();
    _emergencyRelationController.text = _model.emergency_relation!.toString();
    _emergencyNameInhouseController.text =
        _model.emergency_inhouse_name!.toString();
    _emergencyPhoneInhouseController.text =
        _model.emergency_inhouse_phone!.toString();
    _emergencyRelationInhouseController.text =
        _model.emergency_inhouse_relation!.toString();
    _marriageController.text = _model.marriage!.toString();
    _religionController.text = _model.religion!.toString();
    _npwpStatusController.text = _model.npwp_status!.toString();
    _sexController.text = _model.sex!.toString();
    _cityController.text = _model.city_name!.toString();
    _livingAddressController.text = _model.living_address!.toString();
    _ktpAddressController.text = _model.ktp_address!.toString();
    _bankController.text = _model.bank_name!.toString();
  }

  _setDataSim() {
    _licenseCityController.text = _model.license_city_name!;
    _licenseTypeController.text = _model.license_type!;
    _licenseNoController.text = _model.license_no!;
    _licenseIssueController.text = _model.license_issue_date!;
    _licenseExpController.text = _model.license_exp_date!;
    _licenseCardController.text = _model.license_card!;
    _licenseHoldController.text = _model.license_on_hold!;
    _licenseHandOverController.text = _model.license_handover_date!;
  }

  _save() async {
    setState(() {
      _isLoading = true;
    });

    var form = new Map<String, dynamic>();

    form['company_id'] = _companyController.text;
    form['nik'] = _nikController.text;
    form['name'] = _nameController.text;
    form['alias'] = _aliasController.text;
    form['department_id'] = _departmentController.text;
    form['division_id'] = _divisionController.text;
    form['occupation_id'] = _occupationController.text;
    form['status_employee'] = _statusController.text;
    form['join_date'] = _joinDateController.text;
    form['resign_date'] = _resignDateController.text;
    form['resign_memo'] = _resignMemoController.text;

    form['place_of_birth'] = _birthPlaceController.text;
    form['date_of_birth'] = _birthDateController.text;
    form['sex'] = _sexController.text;
    form['religion'] = _religionController.text;
    form['living_address'] = _livingAddressController.text;
    form['city_id'] = _cityController.text;
    form['zip'] = _zipController.text;
    form['phone'] = _phoneController.text;
    form['kartu_keluarga'] = _kkController.text;
    form['ktp'] = _ktpAddressController.text;
    form['ktp_address'] = _ktpAddressController.text;
    form['npwp'] = _npwpController.text;
    form['npwp_status'] = _npwpStatusController.text;
    form['bpjs'] = _bpjsController.text;
    form['bpjs_tk'] = _bpjsTkController.text;
    form['bank_id'] = _bankController.text;
    form['bank_no'] = _accountNoController.text;
    form['bank_account_name'] = _accountNameController.text;
    form['marriage'] = _marriageController.text;
    form['husband_wife_name'] = _wifeNameController.text;
    form['children'] = _childrenController.text;
    form['emergency_name'] = _emergencyNameController.text;
    form['emergency_phone'] = _emergencyPhoneController.text;
    form['emergency_relation'] = _emergencyRelationController.text;
    form['emergency_inhouse_name'] = _emergencyNameInhouseController.text;
    form['emergency_inhouse_phone'] = _emergencyPhoneInhouseController.text;
    form['emergency_inhouse_relation'] =
        _emergencyRelationInhouseController.text;

    form['license_city_id'] = _licenseCityController.text;
    form['license_type'] = _licenseTypeController.text;
    form['license_no'] = _licenseNoController.text;
    form['license_issue_date'] = _licenseIssueController.text;
    form['license_exp_date'] = _licenseExpController.text;
    form['license_card'] = _licenseCardController.text;
    form['license_on_hold'] = _licenseHoldController.text;
    form['license_handover_date'] = _licenseHandOverController.text;

    if (isEditing) {
      final result = await service.PutEmployee(widget.id, form);

      final title = 'Information';
      final text = result.status
          ? (result.message ?? 'An error occurred')
          : 'Your unit was updated';

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ).then((data) {
        if (result.data) {
          Navigator.of(context).pop();
        }
      });
    } else {
      final result = await service.PostEmployee(form);

      final title = 'Information';
      final text = result.status
          ? (result.message ?? 'An error occurred')
          : 'Your unit was created';

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ).then((data) {
        if (result.data) {
          Navigator.of(context).pop();
        }
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _company(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        children: [
          sgSizedBoxHeight,
          SGAutoCompleteWidget(
            controller: _companyController,
            title: 'Grup Perusahaan',
            getData: _companyData,
            id: _model.company_id!,
            name: _model.company_name!,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: 'NIK',
            controller: _nikController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: 'Nama Lengkap',
            controller: _nameController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: 'Nama Panggilan',
            controller: _aliasController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGAutoCompleteWidget(
            controller: _departmentController,
            title: 'Departemen',
            getData: _departmentData,
            id: _model.department_id!,
            name: _model.department_name!,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGAutoCompleteWidget(
            controller: _divisionController,
            title: 'Divisi',
            getData: _divisionData,
            id: _model.division_id!,
            name: _model.division_name!,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGAutoCompleteWidget(
            controller: _occupationController,
            title: 'Jabatan',
            getData: _occupationData,
            id: _model.occupation_id!,
            name: _model.occupation_name!,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGDropDownListWidget(
            controller: _statusController,
            title: "Status Karyawan",
            data: employeeStatusList,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGDatePickerWidget(
            controller: _joinDateController,
            title: "Tanggal Masuk",
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGDatePickerWidget(
            controller: _resignDateController,
            title: "Tanggal Keluar",
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Keterangan Keluar",
            controller: _resignMemoController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
        ],
      ),
    );
  }

  Widget _employee(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        children: [
          sgSizedBoxHeight,
          SGDropDownListWidget(
            controller: _sexController,
            title: "Jenis Kelamin",
            data: sexList,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGDropDownListWidget(
            controller: _religionController,
            title: "Agama",
            data: religionList,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Tempat Lahir",
            controller: _birthPlaceController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGDatePickerWidget(
            controller: _birthDateController,
            title: "Tanggal Lahir",
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Alamat Domisili",
            controller: _livingAddressController,
            enabled: this._isEdit,
            maxLines: 3,
          ),
          sgSizedBoxHeight,
          SGAutoCompleteWidget(
            controller: _cityController,
            enabled: this._isEdit,
            title: 'City',
            getData: _cityData,
            id: _model.city_id!,
            name: _model.city_name!,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Kode Pos",
            controller: _zipController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Telepon",
            controller: _phoneController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Kartu Keluarga",
            controller: _kkController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "KTP",
            controller: _ktpController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Alamat KTP",
            controller: _ktpAddressController,
            enabled: this._isEdit,
            maxLines: 3,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "NPWP",
            controller: _npwpController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGDropDownListWidget(
            controller: _npwpStatusController,
            title: "NPWP Status",
            data: npwpStatusList,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "BPJS Kesehatan",
            controller: _bpjsController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "BPJS TK",
            controller: _bpjsTkController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          InfoTitleWidget(value: "Informasi Rekening"),
          sgSizedBoxHeight,
          SGAutoCompleteWidget(
            controller: _bankController,
            enabled: this._isEdit,
            title: 'Bank',
            getData: _bankData,
            id: _model.bank_id!,
            name: _model.bank_name!,
            // data: this.model.bank_id!,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Nomor Rekening",
            controller: _accountNoController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Nama Rekening",
            controller: _accountNameController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          InfoTitleWidget(value: "Informasi Keluarga"),
          sgSizedBoxHeight,
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CheckBoxWidget(
              title: "Menikah",
              controller: _marriageController,
              icon: Icons.family_restroom_outlined,
              enabled: this._isEdit,
            ),
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Nama Suami / Istri",
            controller: _wifeNameController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Jumlah Anak",
            controller: _childrenController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          InfoTitleWidget(value: "Kontak Darurat Serumah"),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Nama Lengkap",
            controller: _emergencyNameController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Telepon",
            controller: _emergencyPhoneController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Hubungan",
            controller: _emergencyRelationController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          InfoTitleWidget(value: "Kontak Darurat Tidak Serumah"),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Nama Lengkap",
            controller: _emergencyNameInhouseController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Telepon",
            controller: _emergencyPhoneInhouseController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Hubungan",
            controller: _emergencyRelationInhouseController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
        ],
      ),
    );
  }

  Widget _sim(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        children: [
          sgSizedBoxHeight,
          SGAutoCompleteWidget(
            controller: _licenseCityController,
            enabled: this._isEdit,
            title: 'City',
            getData: _cityData,
            id: _model.license_city_id!,
            name: _model.license_city_name!,
          ),
          sgSizedBoxHeight,
          SGDropDownListWidget(
            controller: _licenseTypeController,
            title: "Jenis Lisensi",
            data: sexList,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGTextFormField(
            label: "Nomor Lisensi",
            controller: _licenseNoController,
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGDatePickerWidget(
            controller: _licenseIssueController,
            title: "Tanggal Dibuat",
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          SGDatePickerWidget(
            controller: _licenseExpController,
            title: "Masa Berlaku",
            enabled: this._isEdit,
          ),
          sgSizedBoxHeight,
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CheckBoxWidget(
              title: "Kartu Lisensi",
              controller: _licenseCardController,
              icon: Icons.card_membership_outlined,
              enabled: this._isEdit,
            ),
          ),
          sgSizedBoxHeight,
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CheckBoxWidget(
              title: "Lisensi Ditahan",
              controller: _licenseHoldController,
              icon: Icons.sim_card_alert_outlined,
              enabled: this._isEdit,
            ),
          ),
          sgSizedBoxHeight,
          SGDatePickerWidget(
            controller: _licenseHandOverController,
            title: "Tgl Serah Terima",
            enabled: this._isEdit,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: sgRed,
            title: Text(
              "Informasi Karyawan",
              style: TextStyle(
                color: sgWhite,
                fontFamily: 'Nexa',
              ),
            ),
            iconTheme: IconThemeData(
              color: sgWhite, //change your color here
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.save_outlined,
                  color: sgWhite,
                ),
                onPressed: () => _save(),
              ),
            ],
          ),
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  color: sgWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EmployeeProfile(
                        model: _model,
                      ),
                      TabBar(
                        isScrollable: true,
                        labelColor: sgBlack,
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nexa',
                        ),
                        tabs: [
                          Tab(
                            text: "Data Karyawan",
                          ),
                          Tab(
                            text: "Data Pribadi",
                          ),
                          Tab(
                            text: "Data SIM",
                          ),
                          Tab(
                            text: "Skorsing",
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _company(context),
                            _employee(context),
                            _sim(context),
                            widget.id > 0
                                ? EmployeeSkorsing(
                                    skorsing: _model.skorsing,
                                  )
                                : Center(
                                    child: Text("Data not found"),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<List<autocompleteListModel>> _companyData(keyword) async {
    _apiResponse = await serviceAutoComplete.GetCompanyList(keyword);
    List<autocompleteListModel> _models = [];

    if (_apiResponse.data.length == 0) {
      return [];
    }

    for (var i = 0; i < _apiResponse.data.length; i++) {
      _models.add(_apiResponse.data[i]);
    }

    return _models;
  }

  Future<List<autocompleteListModel>> _departmentData(keyword) async {
    _apiResponse = await serviceAutoComplete.GetDepartmentList(keyword);
    List<autocompleteListModel> _models = [];

    if (_apiResponse.data.length == 0) {
      return [];
    }

    for (var i = 0; i < _apiResponse.data.length; i++) {
      _models.add(_apiResponse.data[i]);
    }

    return _models;
  }

  Future<List<autocompleteListModel>> _divisionData(keyword) async {
    _apiResponse = await serviceAutoComplete.GetDivisionList(keyword);
    List<autocompleteListModel> _models = [];

    if (_apiResponse.data.length == 0) {
      return [];
    }

    for (var i = 0; i < _apiResponse.data.length; i++) {
      _models.add(_apiResponse.data[i]);
    }

    return _models;
  }

  Future<List<autocompleteListModel>> _occupationData(keyword) async {
    _apiResponse = await serviceAutoComplete.GetOccupationList(keyword);
    List<autocompleteListModel> _models = [];

    if (_apiResponse.data.length == 0) {
      return [];
    }

    for (var i = 0; i < _apiResponse.data.length; i++) {
      _models.add(_apiResponse.data[i]);
    }

    return _models;
  }

  Future<List<autocompleteListModel>> _cityData(keyword) async {
    _apiResponse = await serviceAutoComplete.GetCityList(keyword);
    List<autocompleteListModel> _models = [];

    if (_apiResponse.data.length == 0) {
      return [];
    }

    for (var i = 0; i < _apiResponse.data.length; i++) {
      _models.add(_apiResponse.data[i]);
    }

    return _models;
  }

  Future<List<autocompleteListModel>> _bankData(keyword) async {
    _apiResponse = await serviceAutoComplete.GetBankList(keyword);
    List<autocompleteListModel> _models = [];

    if (_apiResponse.data.length == 0) {
      return [];
    }

    for (var i = 0; i < _apiResponse.data.length; i++) {
      _models.add(_apiResponse.data[i]);
    }

    return _models;
  }
}