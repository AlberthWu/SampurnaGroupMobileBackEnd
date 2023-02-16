import 'package:asm/app/models/employee/skorsing.dart';

class employeeGetModel {
  int id;
  final String? nik;
  final String? name;
  final String? alias;
  final int? company_id;
  final String? company_name;
  final int? department_id;
  final String? department_name;
  final int? division_id;
  final String? division_name;
  final int? occupation_id;
  final String? occupation_name;
  final String? status_employee;
  final String? join_date;
  final String? resign_date;
  final String? resign_memo;
  final String? sex;
  final String? religion;
  final String? place_of_birth;
  final String? date_of_birth;
  final String? living_address;
  final int? city_id;
  final String? city_name;
  final String? zip;
  final String? phone;
  final String? kartu_keluarga;
  final String? ktp;
  final String? ktp_address;
  final String? npwp;
  final String? npwp_status;
  final String? bpjs;
  final String? bpjs_tk;
  final int? bank_id;
  final String? bank_name;
  final String? bank_no;
  final String? bank_account_name;
  final String? marriage;
  final String? husband_wife_name;
  final String? children;
  final String? emergency_name;
  final String? emergency_phone;
  final String? emergency_relation;
  final String? emergency_inhouse_name;
  final String? emergency_inhouse_phone;
  final String? emergency_inhouse_relation;
  final int? license_city_id;
  final String? license_city_name;
  final String? license_type;
  final String? license_no;
  final String? license_issue_date;
  final String? license_exp_date;
  final String? license_card;
  final String? license_on_hold;
  final String? license_handover_date;
  final String? image;
  final List<skorsingModel>? skorsing;

  employeeGetModel({
    this.id = 0,
    this.nik = '',
    this.name = '',
    this.alias = '',
    this.company_id = 0,
    this.company_name = '',
    this.department_id = 0,
    this.department_name = '',
    this.division_id = 0,
    this.division_name = '',
    this.occupation_id = 0,
    this.occupation_name = '',
    this.status_employee = '',
    this.join_date = '',
    this.resign_date = '',
    this.resign_memo = '',
    this.sex = '',
    this.religion = '',
    this.place_of_birth = '',
    this.date_of_birth = '',
    this.living_address = '',
    this.city_id = 0,
    this.city_name = '',
    this.zip = '',
    this.phone = '',
    this.kartu_keluarga = '',
    this.ktp = '',
    this.ktp_address = '',
    this.npwp = '',
    this.npwp_status = '',
    this.bpjs = '',
    this.bpjs_tk = '',
    this.bank_id = 0,
    this.bank_name = '',
    this.bank_no = '',
    this.bank_account_name = '',
    this.marriage = '',
    this.husband_wife_name = '',
    this.children = '',
    this.emergency_name = '',
    this.emergency_phone = '',
    this.emergency_relation = '',
    this.emergency_inhouse_name = '',
    this.emergency_inhouse_phone = '',
    this.emergency_inhouse_relation = '',
    this.license_city_id = 0,
    this.license_city_name = '',
    this.license_type = '',
    this.license_no = '',
    this.license_issue_date = '',
    this.license_exp_date = '',
    this.license_card = '',
    this.license_on_hold = '',
    this.license_handover_date = '',
    this.image = '',
    this.skorsing = null,
  });

  factory employeeGetModel.fromJson(Map<String, dynamic> item) {
    var skorsing_data = item['employee_skorsing'];
    var image_data = item['image_data'];
    var image = '';

    if (image_data != null) {
      if (image_data.toString().contains("jpeg")) {
        image = image_data.substring(23, image_data.length);
      } else {
        image = image_data.substring(22, image_data.length);
      }
    }

    List<skorsingModel> _skorsing = [];
    if (skorsing_data != null) {
      skorsing_data.forEach((v) {
        _skorsing.add(skorsingModel.fromJson(v));
      });
    }

    return employeeGetModel(
      id: item['id'],
      nik: item['nik'],
      name: item['name'],
      alias: item['alias'],
      company_id: item['company_id']['id'],
      company_name: item['company_id']['name'],
      department_name: item['department_id']['name'],
      department_id: item['department_id']['id'],
      division_name: item['division_id']['name'],
      occupation_id: item['occupation_id']['id'],
      occupation_name: item['occupation_id']['name'],
      status_employee: item['status_employee'],
      join_date: item['join_date'] == null ? '' : item['join_date'],
      resign_date: item['resign_date'] == null ? '' : item['resign_date'],
      resign_memo: item['resign_memo'] == null ? '' : item['resign_memo'],
      sex: item['sex'] == null ? '' : item['sex'],
      religion: item['religion'] == null ? '' : item['religion'],
      place_of_birth:
          item['place_of_birth'] == null ? '' : item['place_of_birth'],
      date_of_birth: item['date_of_birth'] == null ? '' : item['date_of_birth'],
      living_address:
          item['living_address'] == null ? '' : item['living_address'],
      city_id: item['city_id']['id'] == null ? 0 : item['city_id']['id'],
      city_name: item['city_id']['name'] == null ? '' : item['city_id']['name'],
      zip: item['zip'] == null ? '' : item['zip'],
      phone: item['religion'] == null ? '' : item['religion'],
      kartu_keluarga:
          item['kartu_keluarga'] == null ? '' : item['kartu_keluarga'],
      ktp: item['ktp'] == null ? '' : item['ktp'],
      ktp_address: item['ktp_address'] == null ? '' : item['ktp_address'],
      npwp: item['npwp'] == null ? '' : item['npwp'],
      npwp_status: item['npwp_status'] == null ? '' : item['npwp_status'],
      bpjs: item['bpjs'] == null ? '' : item['bpjs'],
      bpjs_tk: item['bpjs_tk'] == null ? '' : item['bpjs_tk'],
      bank_id: item['bank_id']['id'] == null ? 0 : item['bank_id']['id'],
      bank_name: item['bank_name'] == null ? '' : item['bank_name'],
      bank_no: item['bank_no'] == null ? '' : item['bank_no'],
      bank_account_name:
          item['bank_account_name'] == null ? '' : item['bank_account_name'],
      marriage: item['marriage'] == 1 ? "1" : "0",
      husband_wife_name:
          item['husband_wife_name'] == null ? '' : item['husband_wife_name'],
      children: item['children'] == null ? '' : item['children'].toString(),
      emergency_name:
          item['emergency_name'] == null ? '' : item['emergency_name'],
      emergency_relation:
          item['emergency_relation'] == null ? '' : item['emergency_relation'],
      emergency_phone:
          item['emergency_phone'] == null ? '' : item['emergency_phone'],
      emergency_inhouse_name: item['emergency_inhouse_name'] == null
          ? ''
          : item['emergency_inhouse_name'],
      emergency_inhouse_relation: item['emergency_inhouse_relation'] == null
          ? ''
          : item['emergency_inhouse_relation'],
      emergency_inhouse_phone: item['emergency_inhouse_phone'] == null
          ? ''
          : item['emergency_inhouse_phone'],
      license_city_id: item['license_city_id']['id'] == null
          ? 0
          : item['license_city_id']['id'],
      license_city_name: item['license_city_id']['name'] == null
          ? ''
          : item['license_city_id']['name'],
      license_type: item['license_type'] == null ? '' : item['license_type'],
      license_no: item['license_no'] == null ? '' : item['license_no'],
      license_issue_date:
          item['license_issue_date'] == null ? '' : item['license_issue_date'],
      license_exp_date:
          item['license_exp_date'] == null ? '' : item['license_exp_date'],
      license_card: item['license_card'] == 1 ? "Ada" : "Tidak ada",
      license_on_hold: item['license_on_hold'] == 1 ? "Ada" : "Tidak ada",
      license_handover_date: item['license_handover_date'] == null
          ? ''
          : item['license_handover_date'],
      image: image_data == null ? '' : image,
      skorsing: skorsing_data == null ? [] : _skorsing,
    );
  }
}
