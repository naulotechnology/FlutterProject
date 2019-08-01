import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class PlanningFormModel {
  String Company;
  String Department;
  List<String> costElements;
  Map<String, MonthlyPlan> ceToMpMap;
  Map<String, MonthlyPlan> monthLevelPlan;
  MonthlyPlan mPlan = new MonthlyPlan();
  String currentSavedState;
  String cost = "";

  String savedStateFromFile = "This is default";
  Storage st;

  PlanningFormModel() {
    this.Company = "N Tech";
    this.Department = "Marketing";
    this.st = new Storage();
    this.costElements = new List<String>();

    this.costElements.add("Transportation");
    this.costElements.add("Marketing");
    this.costElements.add("Human Resources");
    this.costElements.add("Information Technology");
    this.costElements.add("Legal");

    //   String result = utf8.decode(costElements);

    //  List<String> file() {
    //   List<String> clist;
    //      for (int i = 0; i < 5; i++) {
    //          clist = costElements;

    //          }

    //   return clist;
    // }

    for (int i = 0; i < costElements.length; i++) {
      cost += costElements[i];
    }

    //instatiate the map to store monthly plan for each costEleemnts
    Map mp = new Map<String, MonthlyPlan>();

    //mp = mp.getbykey(legal)
    //  mp=mp.amountInMonth

    for (String ce in this.costElements) {
      //creaete monthly plan for each cost element
      MonthlyPlan mPlan = new MonthlyPlan();
      mPlan.category = ce;
      //List amtList = new List<int>();
      List amtList = new List<PlanValue>();

      for (int i = 1; i < 13; i++) {
        //assign some amount to each of the 12 months
        PlanValue pa = new PlanValue(i * 125, i);
        amtList.add(pa);
      }
      mPlan.amountInMonth = amtList;

      List hrList = new List<PlanValue>();

      for (int i = 1; i < 13; i++) {
        //assign some amount to each of the 12 months
        PlanValue pa = new PlanValue(i * 7, i);
        hrList.add(pa);
      }
      mPlan.hourInMonth = hrList;

      //add monthly plan for the is
      mp[ce] = mPlan;
    }
    // assign month plan
    this.monthLevelPlan = mp;
  }

  String toString() {
    String planningFormInString =
        "" + this.Company + " " + this.Department + cost;
    return planningFormInString;
  }

  setAmount(bool isHour, String costElement, String amount, int idx) {
    if (isHour) {
      this.monthLevelPlan[costElement].hourInMonth[idx] =
          (int.parse(amount)) as PlanValue;
    } else {
      this.monthLevelPlan[costElement].amountInMonth[idx] =
          (int.parse(amount)) as PlanValue;
    }
  }

  savePfmToFile() {
    this.st.writeData(this.PlanningFormModeltoJsonv2());
  }

  String PlanningFormModeltoJsonv2() {
    String p = "";
    p = p + "{";
    p = p + "'Company':" + "'${this.Company}'" + ",";
    p = p + "'Department':" + "'${this.Department}'" + ",";
    p = p + "'costElements':[";
    for (String ce in this.costElements) {
      p = p + "'" + ce + "',";
    }
    p = p + "],";
    p = p + "{'ceToMpMap':[" + "${mPlan.monthlyplantoJsonv2()}" + "]";

    p = p + "}";
    p = json.encode(p);
    return p;
  }
}

class MonthlyPlan {
  String category;
  List<PlanValue> amountInMonth;
  List<PlanValue> hourInMonth;

  String monthlyplantoJsonv2() {
    PlanningFormModel pfm = new PlanningFormModel();
    String s = "";
    for (String ce in pfm.costElements) {
      s = s + "{";
      s = s + "'" + ce + "':{";
      s = s + "'amountInMonth':[";
      for (PlanValue i in amountInMonth) {
        s = s + "'" + i.toString() + "',";
      }
      s = s + "],";

      s = s + "'hourInMonth':[";
      for (PlanValue i in hourInMonth) {
        s = s + "'" + i.toString() + "',";
      }
      s = s + "]}},";

      // s = json.encode(s);
    }

    return s;
  }

  List<PlanValue> getMonthlyPlan(bool isHour) {
    if (isHour)
      return this.hourInMonth;
    else
      return this.amountInMonth;
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}

class PlanValue {
  int value;
  int index;

  PlanValue(int amt, int idx) {
    this.value = amt;
    this.index = idx;
  }
}
