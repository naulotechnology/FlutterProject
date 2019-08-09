
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:flutterproject/screen/planninglayout.dart';


class PlanningFormModel {
  String Company;
  String Department;
  List<String> costElements;
   Map<String, MonthlyPlan> ceToMpMap;
   List<PlanValue> amtList;
  Map<String, MonthlyPlan> monthLevelPlan;
  MonthlyPlan mPlan = new MonthlyPlan();
  String currentSavedState;
  String cost = "";

String savedStateFromFile="This is default";
  Storage st ;
  

  

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

    //instatiate the map to store monthly plan for each costEleemnts
    ceToMpMap = new Map<String, MonthlyPlan>();

    //mp = mp.getbykey(legal)
    //  mp=mp.amountInMonth

    for (String ce in this.costElements) {
      //creaete monthly plan for each cost element

      mPlan.category = ce;
    

       amtList = new List<PlanValue>();


      for (int i = 0; i < 12; i++) {
        //assign some amount to each of the 12 months
        PlanValue pa = new PlanValue(i * 125, i);
        amtList.add(pa);
      }
      mPlan.amountInMonth = amtList;

      List hrList = new List<PlanValue>();

      for (int i = 0; i < 12; i++) {
        //assign some amount to each of the 12 months
        PlanValue pa = new PlanValue(i * 7, i);
        hrList.add(pa);
      }
      mPlan.hourInMonth = hrList;

      //add monthly plan for the is
      this.ceToMpMap[ce] = mPlan;
    }
    //assign month plan
    // this.ceToMpMap = ceToMpM;
  }

 String toString() {
    String planningFormInString = "Company = " +
        this.Company +
        "\n" +
        "DepartMent = " +
        this.Department +
        "\n";

    planningFormInString = planningFormInString + "Monthly Amount Plan\n";
    for (String ce in this.costElements) {
      planningFormInString = planningFormInString + ce + " ";

      MonthlyPlan mp = this.ceToMpMap[ce];

      for (PlanValue amount in mp.amountInMonth) {
        planningFormInString = planningFormInString + amount.toString() + "||";
      }

      planningFormInString = planningFormInString + "\n";
    }

    planningFormInString = planningFormInString + "Monthly hour Plan\n";
    for (String ce in this.costElements) {
      planningFormInString = planningFormInString + ce + " ";

      MonthlyPlan mp = this.ceToMpMap[ce];

      for (PlanValue hour in mp.hourInMonth) {
        planningFormInString = planningFormInString + hour.toString() + "||";
      }
      planningFormInString = planningFormInString + "\n";
    }
    return planningFormInString;
  }

  setAmount(bool isHour, String costElement, String amount,int idx) {
    if (isHour) {
      this.monthLevelPlan[costElement].hourInMonth[idx].value=(int.parse(amount));
    } else {
      this.monthLevelPlan[costElement].amountInMonth[idx].value=(int.parse(amount));
    }
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
    p = p + "${mPlan.monthlyplantoJsonv2()}" + "]";

    p = p + "}";
    p = json.encode(p);
    return p;
  }
  savePfmToFile(){
   
   this.st.writeData(this.PlanningFormModeltoJsonv2());
 }

}

class PlanValue{
  int value;
  int index;

  PlanValue(int amt, int idx){
    this.value = amt;
    this.index = idx;

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
    return File('$path/db.json');
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
