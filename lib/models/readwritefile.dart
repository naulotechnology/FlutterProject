

  import 'dart:io';
  import 'package:path_provider/path_provider.dart';

class PlanningFormModel{
    String Company;
    String Department;
    List<String> costElements;
    Map<String, MonthlyPlan> monthLevelPlan;


    //String get Company / Aa
    //String get Department /Aa
    //List<String> get CostElement/ Aa
    //Map  monthlyLevelPlan / Aa
    //implements to toString()
    //implement to Json

    
    PlanningFormModel(){
      this.Company = "N Tech";
      this.Department = "Marketing";
      this.costElements = new List<String>();
    
      this.costElements.add("Transportation");
      this.costElements.add("Marketing");
      this.costElements.add("Human Resources");
      this.costElements.add("Information Technology");
      this.costElements.add("Legal");
    
      //instatiate the map to store monthly plan for each costEleemnts
      Map mp = new Map<String,MonthlyPlan>();

      for(String ce in this.costElements){
        //creaete monthly plan for each cost element 
        MonthlyPlan mPlan = new MonthlyPlan();
        mPlan.category = ce;
        List amt = new List<int>();
      
        for (int i = 1; i < 13; i++) {
          //assign some amount to each of the 12 months
          amt.add(i*125);
        }
        mPlan.amountInMonth = amt;
      
        List hr = new List<int>();
      
        for (int i = 1; i < 13; i++) {
          //assign some amount to each of the 12 months
          hr.add(i*7);
        }
        mPlan.hourInMonth = hr;

        //add monthly plan for the is 
        mp[ce] = mPlan;
      }
      //assign month plan
      this.monthLevelPlan = mp;
      
    }
    
    String toString(){
      String planningFormInString = ""+this.Company+" "+this.Department;
      return planningFormInString;
    }
      
  }

  class MonthlyPlan{
    String category;
    List<int> amountInMonth;
    List<int> hourInMonth;
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
