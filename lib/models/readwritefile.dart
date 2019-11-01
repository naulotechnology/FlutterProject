import 'dart:core';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class PlanningFormModel {
  String company;
  String selectedDepartment;

 
  List<String> costElements;
  List<String> departments;
  List<String> offlineDepartments;
  List<String> hrData;

  List data;
  String year;
 // bool isOnline;
  bool isOnline = false;
  String month;

  bool isFatches = true;

   /*
  *This string is used to hold the current selected Department
  */
  

  /*
  Cost Element to Monthly Plan map
  */
  Map<String, MonthlyPlan> ceToMpMap;

  /*
  Cost Element to Monthly Actuals map
  */
  Map<String, MonthlyActual> ceToMaMap;

  /*
  Cost Element to Monthly Variance map
  */
  Map<String, MonthlyVariance> ceToMvMap;

   Map<String,Map<String,MonthlyValues>> deToMap;

  /*
  *This string is to hold current state of the App read from Storage
  */
  String savedStateFromFile = "This is default";


  /*
  *Storge class does the file/cloudstore/db read/write
  */
  Storage st;

  PlanningFormModel() {

   

    //check if data files already exists

    //this.initializeData();

    this.st = new Storage();
    this.departments = new List<String>();
    
    //   this.company = "N Tech";
    // this.department = "Marketing";

    //  this.year = "2019";
    // this.costElements = new List<String>();
    // //mPlan = new MonthlyPlan(this);

    // this.costElements.add("Transportation");
    //   this.costElements.add("Marketing");
    //this.initializeData();

    // if (st.readData().toString() == null) {
    //   this.initializeData();
    // } else {
    //   print(
    //       "data in local file system is available , reading json and populating  data... ");
    //   print("${st.readData().toString()}");
    //   //read json from file
    //   String pfmJSONStringReadFromFile = "";
    //   //populate data
    //   // this.initializeData();
    //   this.instantiatePFMfromJSONString();
    // }
   
    //getDepartments();
   // getHrData();
     //setAllData();

    // switch (isOnline) {
    //   case false:
    //   print("**************phone is offline**************");
    //     setAllData();

    //     break;
    //   case true:
    //   print("**************phone is online**************");
    //     getPlanData();
    //     getActualData();
    //     getVariecneData();
    //     break;
    // }
    if(this.isOnline ==false ){
      print("*********************phone is offline**********************");
     
  
    // getPlanData();
    // getActualData();
   
     
    // getDepartments().whenComplete((){
    //    getCostElements("Beauty Products Department").whenComplete((){
    //    getDatas();
    //    });
    // });
    getDatas();
    
    
  // print("returned cost elememt value = " + getCostElements().toString());
   //setAllData();
   
   

    
     
    }
    if(this.isOnline ==true ){

      print("**************phone is online**************");
     // getDepartments();
      getPlanData();
    getActualData();
    getVariecneData();
     
      

    }

  //work();
     }

//    work(){

//       switch (isOnline) {
//       case false:
//       print("**************phone is offline**************");
//         setAllData();

//         break;
//       case true:
//       print("**************phone is online**************");
//         getPlanData();
//         getActualData();
//         getVariecneData();
//         break;
//     }



// // if(this.isOnline ==false ){
// //       print("*********************phone is offline**********************");
     
  
// //     // getPlanData();
// //     // getActualData();
// //     // getVariecneData();
     
    
    
// //    setAllData();

    
     
// //     }
// //     if(this.isOnline ==true ){

// //       print("**************phone is online**************");
// //      // getDepartments();
// //      return getPlanData();
// //     // getActualData();
// //     // getVariecneData();
     
      

// //     }
    
//   }

  //  setSelectedDepartment(String department){

  //   this.selectedDepartment = department;
  // }

  Future<List<String>> getDepartments() async {
   // if(isOnline == true) {
      print("Entering get Department ...");
     
      print("Firing up HTTP request ...");
      var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/getDepartments");
      print("Fired up HTTP request ...");
      print("Data Received = "+data.toString());
      Map jsonData = json.decode(data.body);
      print("Decoded json = "+jsonData.toString());
      print("Decoded json Map length = "+jsonData.length.toString());
      print("jsonData.values.toString() = "+jsonData.values.toString());
      //lets trim the first and last two chars
      String depts = jsonData.values.toString().substring(2,jsonData.values.toString().length-2);
       print("jsonData.values.toString() after trim = "+depts);
      //this.departments = jsonData.values;
      print("jsonData.values.toString(),split(',') = "+depts.split(",").toString());
      for(String s in depts.split(",")){
        // print("token = "+s);
        this.departments.add(s);
      }
      // int i = 0;
      // for(String s in this.departments){
      //   print("this.Departments["+i.toString()+"] = "+s);
      //   i++;
      // }
      return depts.split(",");
    // }
    // else {
    //  return null ;
    // }
  }

    Future<List<String> > getCostElements(departmentPassed) async {
      print("*************costElements ***************** =");
        String cE1;
        this.selectedDepartment = departmentPassed;
  //       this.departments =  new List<String>();
  //     this.departments.add("Cleaning Product Department");
  // this.departments.add("Consumer Electronics");
  // this.departments.add("Beauty Products Department");


print("*************departments ***************** =" +  this.departments.toString());

   String selectedDepartment1 = " Consumer Electronics";

     for(String department in this.departments) {
        print("*************entering for loop ***************** ");
   //i = department.indexOf("Cleaning Product Department");
  if(selectedDepartment == department) {
    print("*************Department Selection ***************** =");
    String cE = selectedDepartment ;
    print("*************selectedDepartment ***************** =" + cE);
    String newCe =cE.split(" ").join();
     print("*************splited ce ***************** =" + newCe );
    //  String d = "https://us-central1-flutterproject-fe05f.cloudfunctions.net/CleaningProductDepartment" + newCe;
        var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/" + newCe);
    //  var da = await http.get(d);
      
    //    var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/CleaningProductDepartment");
        
      var jsonData = json.decode(data.body);

 print("*************decoded data ***************** =" + jsonData.toString());
      
    
      List costElements = jsonData['costElements'];
       cE1 = costElements.toString();
      cE1 = cE1.substring(1,costElements.toString().length-1);
        print("*************costElements ***************** =" + cE1);
        this.costElements = new List<String>();
      // for(String ce in cE.split(",")){
      //   this.costElements.add(ce);
      // }
      

  }
}
//return cE1.split(",") ;

}

// selectedCostElement() {
//   String d ;
//   int i;
//   this.departments = new List<String>();
//   this.departments.add("Cleaning Product Department");
//   this.departments.add("Consumer Electronics");
//   this.departments.add("Beauty Products Department");
  
//   for(String department in this.departments) {
//    //i = department.indexOf("Cleaning Product Department");
//   if( d ==department) {
//     String ce = d ;
    

//   }
// }
// }

    //  Future<List<String> > getDepartments() async {

    //   var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/getDepartments");
    //   var jsonData = json.decode(data.body);
    
    //   List departments = jsonData['Department'];
    //   String data1 = departments.toString();
    //     print("*************Department ***************** =" + data1);
    //    // this.costElements = new List<String>();
    //   for(String ce in data1.split(",")){
    //     this.departments.add(ce);
    //   }
    //   return data1.split(",") ;
    // }

  //  Future<List<String> > getCostElements() async {
  //      print("*************entering costElements *****************");
  //     var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/CleaningProductDepartment");
  //     var jsonData = json.decode(data.body);
  //    print("*************passed url *****************");
  //     List costElements = jsonData['costElements'];
  //     String cE = costElements.toString();
  //     cE = cE.substring(1,costElements.toString().length-1);
  //       print("*************costElements ***************** =" + cE);
  //       this.costElements = new List<String>();
  //     // for(String ce in cE.split(",")){
  //     //   this.costElements.add(ce);
  //     // }
  //   // return cE.split(",") ;
  //   }

  Future getDatas() async {
    isFatches = false;
    List<String> valuetypes = ['plan','actual','varience'];
    Map valueType;
    this.costElements = new List<String>();
    String selectedCostElement = "Eyeshadow";
    String company = "company";
    int yr = 2019;
    String year = yr.toString();
    this.costElements.add(selectedCostElement);
    String department = "Beauty Products Department";
   // String department = selectedDepartment;


    // var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/CleaningProductDepartment");
    // var jsonData = json.decode(data.body);
    // List costelements = jsonData['costElements'];
    // print("*************costElements ***************** =" + costelements.toString());
    // print("*******************************************************************************************");
    ceToMpMap = new Map<String, MonthlyPlan>();
    ceToMaMap = new Map<String, MonthlyActual>();
    ceToMvMap = new Map<String, MonthlyVariance>();
         
    // for(String ce in costElements) {
      //  isFatches = true;
      // this.costElements.add(ce);
        // this.costElements.add("Transportation");
    
  // print("*************ce ***************** =" + ce.toString());
  
  MonthlyPlan mPlan = new MonthlyPlan();
  MonthlyActual mActual = new MonthlyActual();
  MonthlyVariance mVariance = new MonthlyVariance();
  mPlan.amountInMonth = new List<PlanValue>();
  mPlan.hourInMonth = new List<PlanValue>();
  mActual.amountInMonth = new List<ActualValue>();
  mActual.hourInMonth = new List<ActualValue>();
  mVariance.amountInMonth = new List<VarianceValue>();
  mVariance.hourInMonth = new List<VarianceValue>();

for(String vT in valuetypes){
  print("*************************************" +vT+"******************************************************");
  //String  vt = "actual";
  String  vt = vT;
  var data1 = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/getCeData?org=organization&company="+ company+"&dept="+department+"&ce="+selectedCostElement+"&year="+ year+ "&valueType="+ vt);
  valueType= json.decode(data1.body);    

  //if(valueType != null)  {
  print("*************************************Selected ValueType=" +vt);
     // Map plan = json.decode(data1.body);
  String datas = valueType.toString();
  print(" ************" +selectedCostElement +"Data***************** =" + datas);
  List amountInMonth = valueType['amountInMonth'];
  List hourInMonth  = valueType['hourInMonth'];

  
    
  print(" ************amountInMonth***************** =" + amountInMonth.toString());
  print(" ************hourInMonth***************** =" + hourInMonth.toString());
  print("*******************************************************************************************");

       int i = 0 ;
       if(vt == "plan"){
       for(int amount  in amountInMonth) {
           PlanValue pv = new PlanValue(amount, i);
         // PlanValue dv = new PlanValue(int.parse(a), i);
      mPlan.amountInMonth.add(pv);
      i = i + 1;
        }
       for(int hour  in hourInMonth) {
           PlanValue pv = new PlanValue(hour, i);
      mPlan.hourInMonth.add(pv);
      i = i + 1;
       }
       this.ceToMpMap[selectedCostElement] = mPlan;
       };


      if(vt == "actual"){
       for(int amount  in amountInMonth) {
           ActualValue av = new ActualValue(amount, i);
         // PlanValue dv = new PlanValue(int.parse(a), i);
      mActual.amountInMonth.add(av);
      i = i + 1;
        }
       for(int hour  in hourInMonth) {
           ActualValue av = new ActualValue(hour, i);
      mActual.hourInMonth.add(av);
      i = i + 1;
       }
       this.ceToMaMap[selectedCostElement] = mActual;
       }


       if (vt == "varience"){
       for(int amount  in amountInMonth) {
           VarianceValue vv = new VarianceValue(amount, i);
         // PlanValue dv = new PlanValue(int.parse(a), i);
      mVariance.amountInMonth.add(vv);
      i = i + 1;
        }
       for(int hour  in hourInMonth) {
           VarianceValue vv = new VarianceValue(hour, i);
      mVariance.hourInMonth.add(vv);
      i = i + 1;
       }
       this.ceToMvMap[selectedCostElement] =  mVariance;
       }

     //this.ceToMpMap[selectedCostElement] = mPlan;
   
     // }
    // }
      print("*************list of ce ***************** =" + this.costElements.toString());
       //isFatches = false;
      //return ceToMpMap;
    }
      print("*******************************************************************************************");
      // print("****************mPlan=" + mPlan.toJSONString());
      // print("****************mActual=" + mActual.toJSONString());
      print("****************mVarience=" + mVariance.toJSONString());
      print("*******************************************************************************************");
  }






   Future<Map<String,MonthlyPlan> > getPlanData() async {
        isFatches = false;
         this.costElements = new List<String>();
    
    var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/p");
    var jsonData = json.decode(data.body);
    List costelements = jsonData['costElements'];
    
    //  // List costElements = jsonData['costElements'];
         print("*************costElements ***************** =" + costelements.toString());
    //        this.hrData = new List<String>();
           // this.data = [];
          
            
            print("*******************************************************************************************");
      // for(String ce in costelements) {
      //     this.costElements.add(ce);
      
      // }
      // this.costElements.add("Transportation");
      // this.costElements.add("Marketing");
      //Transportation, Marketing, Legal
          ceToMpMap = new Map<String, MonthlyPlan>();
         
       for(String ce in costelements) {
        //  isFatches = true;
         
          // this.costElements.add(ce);
       
      print("*************ce ***************** =" + ce.toString());
      
        

              var data1 = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/p" +ce);
               
      Map plan = json.decode(data1.body);
      String planData = plan.toString();
      print(" ************hrplan***************** =" + planData);
      List amountInMonth = plan['amountInMonth'];
      List hourInMonth  = plan['hourInMonth'];

      print("*************************************plan******************************************************");
       
      print(" ************amountInMonth***************** =" + amountInMonth.toString());
      print(" ************hourInMonth***************** =" + hourInMonth.toString());
       print("*******************************************************************************************");
       MonthlyPlan mPlan = new MonthlyPlan();
       mPlan.amountInMonth = new List<PlanValue>();
       mPlan.hourInMonth = new List<PlanValue>();
       int i = 0 ;
       for(int amount  in amountInMonth) {
           PlanValue pv = new PlanValue(amount, i);
         // PlanValue dv = new PlanValue(int.parse(a), i);
      mPlan.amountInMonth.add(pv);
      i = i + 1;
        }
       for(int hour  in hourInMonth) {
           PlanValue pv = new PlanValue(hour, i);
      mPlan.hourInMonth.add(pv);
      i = i + 1;
       }
   
    this.costElements.add(ce);
     this.ceToMpMap[ce] = mPlan;
    // Future.delayed(Duration( seconds:15));
    
     // isFatches = false;
  
     }
       //isFatches = false;
      return ceToMpMap;
    }

   Future<Map > getActualData() async {
       //   isFatches = false;
    //      this.costElements = new List<String>();
    // // this.costElements.add("Marketing");  
    // // this.costElements.add("Transportation");
    var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/p");
    var jsonData = json.decode(data.body);
    List costelements = jsonData['costElements'];
    
    //  // List costElements = jsonData['costElements'];
         print("*************costElements ***************** =" + costelements.toString());
    // //        this.hrData = new List<String>();
    //        // this.data = [];
          
            
    //         print("*******************************************************************************************");
    //   for(String ce in costelements) {
    //       this.costElements.add(ce);
      
    //   }
          ceToMaMap = new Map<String, MonthlyActual>();
       for(String ce in costelements) {
         //  this.costElements.add(ce);
      
      print("*************ce ***************** =" + ce.toString());
      
               
              var data1 = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/p" +ce);
             
      Map actual = json.decode(data1.body);
      String actualData = actual.toString();
      print(" ************hrplan***************** =" + actualData);
      List amountInMonth = actual['amountInMonth'];
      List hourInMonth  = actual['hourInMonth'];

      print("*************************************Actual******************************************************");
       
      print(" ************amountInMonth***************** =" + amountInMonth.toString());
      print(" ************hourInMonth***************** =" + hourInMonth.toString());
       print("*******************************************************************************************");
       MonthlyActual monthlyActual = new MonthlyActual();
       monthlyActual.amountInMonth = new List<ActualValue>();
       monthlyActual.hourInMonth = new List<ActualValue>();
       int i = 0 ;
       for(int amount  in amountInMonth) {
           ActualValue av = new ActualValue(amount, i);
         // PlanValue dv = new PlanValue(int.parse(a), i);
      monthlyActual.amountInMonth.add(av);
      i = i + 1;
        }
       for(int hour  in hourInMonth) {
           ActualValue av = new ActualValue(hour, i);
      monthlyActual.hourInMonth.add(av);
      i = i + 1;
       }
     // mPlan.amountInMonth= montlyPlanAmts;
    // this.ceToMpMap["Marketing"] = mPlan;
   //this.costElements.add(ce);
     this.ceToMaMap[ce] = monthlyActual;

   
     }
      return ceToMaMap;
    }


    Future<Map > getVariecneData() async {
        //  isFatches = false;
    //      this.costElements = new List<String>();
    // // this.costElements.add("Marketing");  
    // // this.costElements.add("Transportation");
    var data = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/p");
    var jsonData = json.decode(data.body);
    List costelements = jsonData['costElements'];
    
    //  // List costElements = jsonData['costElements'];
         print("*************costElements ***************** =" + costelements.toString());
    // //        this.hrData = new List<String>();
    //        // this.data = [];
          
            
    //         print("*******************************************************************************************");
    //   for(String ce in costelements) {
    //       this.costElements.add(ce);
      
    //   }
          ceToMvMap = new Map<String, MonthlyVariance>();
       for(String ce in costelements) {
         //  this.costElements.add(ce);
      
      print("*************ce ***************** =" + ce.toString());
      
               
              var data1 = await http.get("https://us-central1-flutterproject-fe05f.cloudfunctions.net/p" +ce);
             
      Map varience = json.decode(data1.body);
      String varienceData = varience.toString();
      print(" ************Varience***************** =" + varienceData);
      List amountInMonth = varience['amountInMonth'];
      List hourInMonth  = varience['hourInMonth'];

      print("*************************************varience******************************************************");
       
      print(" ************amountInMonth***************** =" + amountInMonth.toString());
      print(" ************hourInMonth***************** =" + hourInMonth.toString());
       print("*******************************************************************************************");
       MonthlyVariance monthlyVariance  = new MonthlyVariance();
       monthlyVariance.amountInMonth = new List<VarianceValue>();
       monthlyVariance.hourInMonth = new List<VarianceValue>();
       int i = 0 ;
       for(int amount  in amountInMonth) {
           VarianceValue vv = new VarianceValue(amount, i);
         // PlanValue dv = new PlanValue(int.parse(a), i);
      monthlyVariance.amountInMonth.add(vv);
      i = i + 1;
        }
       for(int hour  in hourInMonth) {
           VarianceValue vv = new VarianceValue(hour, i);
      monthlyVariance.hourInMonth.add(vv);
      i = i + 1;
       }
     // mPlan.amountInMonth= montlyPlanAmts;
    // this.ceToMpMap["Marketing"] = mPlan;
    //this.costElements.add(ce);
     this.ceToMvMap[ce] = monthlyVariance;

   
     }
      return ceToMvMap;
    }




    // setFirebaseData(){
    //  deToMap = new Map<String,Map<String,MonthlyValues>>();
    //     this.getDepartments();

    //     for(String de in this.departments){
              
    //           deToMap[de] = this.getPlanData();

    //     }


    // }

  setAllData() async {
    String readData = await st.readData();

    if (readData == null) {
      this.initializeData();
    } else {
      print(
          "data in local file system is available , reading json and populating  data... ");
      print("${st.readData().toString()}");
      //read json from file
      String pfmJSONStringReadFromFile = "";
      //populate data
       this.initializeData();
      //this.instantiatePFMfromJSONString();
    }
  }

  initializeData() {
    isFatches = true;
    print(
        "welcome to planning application data we are initializeData application");
    this.company = "Naulo Tech";
    this.offlineDepartments = new List<String>();
    offlineDepartments.add("department1");
    offlineDepartments.add("department2");

    this.year = "2019";
     //getCostElements();
    this.costElements = new List<String>();
    //mPlan = new MonthlyPlan(this);
   
    this.costElements.add("Transportation");
    this.costElements.add("Marketing");
    this.costElements.add("Human Resources");
    this.costElements.add("Legal");
    this.costElements.add("Information Technology");
    

    //instatiate the map to store monthly plan for each costEleemnts
    ceToMpMap = new Map<String, MonthlyPlan>();
    ceToMaMap = new Map<String, MonthlyActual>();
    ceToMvMap = new Map<String, MonthlyVariance>();
    MonthlyValues mv ;
    MonthlyPlan mPlan;
    MonthlyActual mActual;
    MonthlyVariance mVariance;
    List<DataValue> monthlyActualAmts, montlyPlanAmts, monthlyVarianceAmts;
    List<DataValue> monthlyActualHrs, montlyPlanHrs, monthlyVarianceHrs;
    
 
    for (String ce in this.costElements) {
      mPlan = new MonthlyPlan();
      mActual = new MonthlyActual();
      mVariance = new MonthlyVariance();

      mPlan.category = ce;
      mActual.category = ce;
      mVariance.category = ce;
      mPlan.amountInMonth=  new List<PlanValue>();
      monthlyActualAmts = new List<ActualValue>();
      montlyPlanAmts = new List<PlanValue>();
      monthlyVarianceAmts = new List<VarianceValue>();

      monthlyActualHrs = new List<ActualValue>();
      montlyPlanHrs = new List<PlanValue>();
      monthlyVarianceHrs = new List<VarianceValue>();

      for (int i = 0; i < 12; i++) {
        
        //assign plan amounts to each of the 12 months
        PlanValue pv = new PlanValue(i * 1000, i);
        //assign plan amounts to each of the 12 months
        ActualValue av = new ActualValue(i * 600, i);
        //Variance the difference between plan = actual
        VarianceValue vv = new VarianceValue(pv.value - av.value, i);

        //assign plan Hours to each of the 12 months
        PlanValue ph = new PlanValue(i * 0, i);
        //assign plan Hours to each of the 12 months
        ActualValue ah = new ActualValue(i * 0, i);
        //Variance the difference between plan = actual
        VarianceValue vh = new VarianceValue(ph.value - ah.value, i);

        //add to amounts list for Plan, Actual, Variance
        monthlyActualAmts.add(av);
       montlyPlanAmts.add(pv);
        monthlyVarianceAmts.add(vv);
        mPlan.amountInMonth .add(pv);

        //add to amounts list for Plan, Actual, Variance
        monthlyActualHrs.add(ah);
        montlyPlanHrs.add(ph);
        monthlyVarianceHrs.add(vh);
      }
      
      //assign Monthly Plan Actual Vairance amounts to each plan
      mActual.amountInMonth = monthlyActualAmts;
     // mPlan.amountInMonth = montlyPlanAmts;
      mVariance.amountInMonth = monthlyVarianceAmts;

      //assign Monthly Plan Actual Vairance amounts to each plan
      mActual.hourInMonth = monthlyActualHrs;
     mPlan.hourInMonth = montlyPlanHrs;
      mVariance.hourInMonth = monthlyVarianceHrs;

      print("*******************************************************************************************");
      print("****************mPlan=" + mPlan.toString());
      print("*******************************************************************************************");


      //add monthly plan for the is
     //this.ceToMpMap["Transportation"] = mPlan;
     this.ceToMpMap[ce] = mPlan;
      this.ceToMaMap[ce] = mActual;
      this.ceToMvMap[ce] = mVariance;
    }
   
    isFatches = false;
    //assign month plan
    //this.monthLevelPlan = ceToMpMap;
  }

  instantiatePFMfromJSONString() async {
    ceToMpMap = new Map<String, MonthlyPlan>();
    ceToMaMap = new Map<String, MonthlyActual>();
    ceToMvMap = new Map<String, MonthlyVariance>();

    String jsonReadfromfile;
    print(
        "welcome to planning application data we are instantiating application");
    isFatches = true;
    print("is Fatches Data $isFatches");
    jsonReadfromfile = await st.readData();
    print("file data read from file = " + jsonReadfromfile);

    // String data = '{"Company":"N Tech",' +
    //     '"Department":"Marketing",' +
    //     '"CostElements":["Transportation","Marketing"],' +
    //     '"Plan":' +
    //     '[' +
    //     '{' +
    //     '"category": "Transportation",' +
    //     '"amountInMonth":["0","10000","20000","30000","40000","50000","60000","70000","80000","90000","100000","110000"],' +
    //     '"hourInMonth":["0","0","0","0","0","0","0","0","0","0","0","0"]' +
    //     '},' +
    //     '{' +
    //     '"category": "Marketing",' +
    //     '"amountInMonth":["0","10000","20000","30000","40000","50000","60000","70000","80000","90000","100000","110000"],' +
    //     '"hourInMonth":["0","0","0","0","0","0","0","0","0","0","0","0"]' +
    //     '}' +
    //     '],' +
    //     '"Actual":' +
    //     '[' +
    //     '{' +
    //     '"category": "Transportation",' +
    //     '"amountInMonth":["0","10000","20000","30000","40000","50000","60000","70000","80000","90000","100000","110000"],' +
    //     '"hourInMonth":["0","0","0","0","0","0","0","0","0","0","0","0"]' +
    //     '},' +
    //     '{' +
    //     '"category": "Marketing",' +
    //     '"amountInMonth":["0","10000","20000","30000","40000","50000","60000","70000","80000","90000","100000","110000"],' +
    //     '"hourInMonth":["0","0","0","0","0","0","0","0","0","0","0","0"]' +
    //     '}' +
    //     ']' +
    //     '}';

    Map jsonMap = json.decode(jsonReadfromfile);
    // print("decoded data =" + jsonMap.toString() );
    this.company = jsonMap['Company'];
    //this.department = jsonMap['Department'];
    print("company = " + this.company);
    print("data extracting = " + jsonMap['Plan'].toString());
    this.year = "2019";
    this.costElements = new List<String>();
    List cl = jsonMap['CostElements'];
    print(cl.toString());
    List monthlyPlans = jsonMap['Plan'];
    print('\n************monthlyPlan.toString = ' +
        monthlyPlans.toString() +
        '************\n');
    print("**************Actual************************");
    List actualPlans = jsonMap['Actual'];
    print('\n************monthlyActual.toString = ' +
        actualPlans.toString() +
        '************\n');
    print("**************Varience************************");
    List varience = jsonMap['Varience'];
    print('\n************monthlyVarience.toString = ' +
        varience.toString() +
        '************\n');
    for (String s in cl) {
      print("celements =" + s);
      //this.costElements.add(s);
      print(
          "**************this costelments  = " + this.costElements.toString());
    }

    // this.costElements.add("Marketing");
    //  this.costElements.add("Transportation");
    // this.costElements.add("Human Resources");
    // this.costElements.add("Legal");

    //  for (String ce in this.costElements) {
    MonthlyPlan mpObjFromJSON;
    for (var mPlan in monthlyPlans) {
      //  print('\n************mp = '+mPlan.toString());
      //   print("***************"+ "$ce initializing" + "**************");
      mpObjFromJSON = new MonthlyPlan.fromJSONMapmp(mPlan);
      print('\n************New catagory = ' + mpObjFromJSON.category);
      print('\n************Newly instantiated Monthly Plan = ' +
          mpObjFromJSON.toJSONString());

      //   for(String ce in mv.category){
      this.ceToMpMap[mpObjFromJSON.category] = mpObjFromJSON;
      this.costElements.add(mpObjFromJSON.category);

      // print('\n************New catagory = '+mpObjFromJSON.category);
      //   }

    }

    isFatches = false;
    print("is Fatches Data $isFatches");
    //  this.ceToMpMap[ce] = mpObjFromJSON;
    //   print("***************"+ "$ce added" + "**************");

    // MonthlyActual mActual = new MonthlyActual();
    MonthlyActual maObjFromJSON;
    for (var mActual in actualPlans) {
      // print('\n************ap = '+mActual.toString());
      maObjFromJSON = new MonthlyActual.fromJSONMapma(mActual);
      this.ceToMaMap[maObjFromJSON.category] = maObjFromJSON;
      // print('\n************Newly instantiated Monthly actual = '+maObjFromJSON.toJSONString());

    }

    MonthlyVariance mvObjFromJSON;
    for (var mVarience in varience) {
      //print('\n************varience = '+mVarience.toString());
      mvObjFromJSON = new MonthlyVariance.fromJSONMapmv(mVarience);
      this.ceToMvMap[mvObjFromJSON.category] = mvObjFromJSON;
      // print('\n************Newly instantiated Monthly varience = '+mvObjFromJSON.toJSONString());

    }

    // this.ceToMpMap[ce] = mpObjFromJSON;
    // this.ceToMaMap[ce] = maObjFromJSON;
    // this.ceToMvMap[ce] = mvObjFromJSON;
  }

  //print json read from file
  //  print(jsonReadfromfile);
  // String jsonData = this;

  //    MonthlyPlan mp = new MonthlyPlan();

  //  //var jsonData = this.planningFormModelMptoJSON();
  //   String sample = ' {"Company":"N Tech", "department":"Marketing"}';
  //   Map data2 = json.decode(sample);
  //    //var d = {'amountInMonth': this.ceToMpMap[ce]};
  // var a =  {'Company':'N Tech',
  //'department':'Marketing','costElements':['Transportation','Marketing',],'Plan':{[{'Transportation':{'amountInMonth':['0','0','0','0','0','0','0','0','0','0','0','0',],'hourInMonth':['0','0','0','0','0','0','0','0','0','0','0','0',]}},{'Marketing':{'amountInMonth':['0','0','0','0','0','0','0','0','0','0','0','0',],'hourInMonth':['0','0','0','0','0','0','0','0','0','0','0','0',]}},{'Transportation':{'amountInMonth':['0','0','0','0','0','0','0','0','0','0','0','0',],'hourInMonth':['0','0','0','0','0','0','0','0','0','0','0','0',]}},{'Marketing':{'amountInMonth':['0','0','0','0','0','0','0','0','0','0','0','0',],'hourInMonth':['0','0','0','0','0','0','0','0','0','0','0','0',]}},]}};
  //  print(jsonData);
  //   String check1 = a['Company'];
  //   print("check1 = " + check1);
  //   String check2 = data2['department'];
  //   print("check2 =" + check2);
  // //  Map data1 = json.decode(jsonData);

  // MonthlyPlan data2 = json.decode(jsonData);

  // print("*******" + data1.toString());
  //  String check = data1['Company'];
  //  print("check ="  + check);

  // return check; 

  // dataRead ()async {
  //   String data = await st.readData();
  //   return data;
  // }

  // MonthlyPlan mp = new MonthlyPlan();
  //readJsonString and build monthlyPlan object mp
  // }

  String toStringMp() {
    String planningFormInString = "Company = " +
        this.company +
        "\n" +
        "department = " +
        this.selectedDepartment +
        "\n";

    planningFormInString = planningFormInString + "Monthly Amount Plan\n";
    for (String ce in this.costElements) {
      planningFormInString = planningFormInString + ce + " ";

      MonthlyPlan mp = this.ceToMpMap[ce];

      for (PlanValue amount in mp.amountInMonth) {
        planningFormInString =
            planningFormInString + amount.value.toString() + "||";
      }

      planningFormInString = planningFormInString + "\n";
    }

    planningFormInString = planningFormInString + "Monthly hour Plan\n";
    for (String ce in this.costElements) {
      planningFormInString = planningFormInString + ce + " ";

      MonthlyPlan mp = this.ceToMpMap[ce];

      for (PlanValue hour in mp.hourInMonth) {
        planningFormInString =
            planningFormInString + hour.value.toString() + "||";
      }
      planningFormInString = planningFormInString + "\n";
    }
    return planningFormInString;
  }

  String toStringMa() {
    String planningFormInString = "Company = " +
        this.company +
        "\n" +
        "department = " +
        this.selectedDepartment +
        "\n";

    planningFormInString = planningFormInString + "Monthly Amount Plan\n";
    for (String ce in this.costElements) {
      planningFormInString = planningFormInString + ce + " ";

      MonthlyActual ma = this.ceToMaMap[ce];

      for (ActualValue amount in ma.amountInMonth) {
        planningFormInString =
            planningFormInString + amount.value.toString() + "||";
      }

      planningFormInString = planningFormInString + "\n";
    }

    planningFormInString = planningFormInString + "Monthly hour Plan\n";
    for (String ce in this.costElements) {
      planningFormInString = planningFormInString + ce + " ";

      MonthlyActual ma = this.ceToMaMap[ce];

      for (ActualValue hour in ma.hourInMonth) {
        planningFormInString =
            planningFormInString + hour.value.toString() + "||";
      }
      planningFormInString = planningFormInString + "\n";
    }
    return planningFormInString;
  }

  String toStringMv() {
    String planningFormInString = "Company = " +
        this.company +
        "\n" +
        "department = " +
        this.selectedDepartment +
        "\n";

    planningFormInString = planningFormInString + "Monthly Amount Plan\n";
    for (String ce in this.costElements) {
      planningFormInString = planningFormInString + ce + " ";

      MonthlyVariance mv = this.ceToMvMap[ce];

      for (VarianceValue amount in mv.amountInMonth) {
        planningFormInString =
            planningFormInString + amount.value.toString() + "||";
      }

      planningFormInString = planningFormInString + "\n";
    }

    planningFormInString = planningFormInString + "Monthly hour Plan\n";
    for (String ce in this.costElements) {
      planningFormInString = planningFormInString + ce + " ";

      MonthlyVariance mv = this.ceToMvMap[ce];

      for (VarianceValue hour in mv.hourInMonth) {
        planningFormInString =
            planningFormInString + hour.value.toString() + "||";
      }
      planningFormInString = planningFormInString + "\n";
    }
    return planningFormInString;
  }

  setAmount(bool isHour, String costElement, String amount, int idx) {
    if (isHour) {
      this.ceToMpMap[costElement].hourInMonth[idx].value = (int.parse(amount));
    } else {
      this.ceToMpMap[costElement].amountInMonth[idx].value =
          (int.parse(amount));
    }
  }

  // String planningFormModelMatoJSON() {
  //   String p = "";
  //   p = p + "{";
  //   p = p + "'Company':" + "'${this.company}'" + ",";
  //   p = p + "'department':" + "'${this.department}'" + ",";
  //   p = p + "'costElements':[";
  //   for (String ce in this.costElements) {
  //     p = p + "'" + ce + "',";
  //   }
  //   p = p + "],{'Plan':{[";
  //   for (String ce in this.costElements) {
  //     p = p + "${this.ceToMaMap[ce].toJSONString()},";
  //   }
  //   p = p + "]}";

  //   p = p + "]}";
  //   p = json.encode(p);
  //   return p;
  // }

  // String planningFormModelMvtoJSON() {
  //   String p = "";
  //   p = p + "{";
  //   p = p + "'Company':" + "'${this.company}'" + ",";
  //   p = p + "'department':" + "'${this.department}'" + ",";
  //   p = p + "'costElements':[";
  //   for (String ce in this.costElements) {
  //     p = p + "'" + ce + "',";
  //   }
  //   p = p + "],{'Plan':{[";
  //   for (String ce in this.costElements) {
  //     p = p + "${this.ceToMvMap[ce].toJSONString()},";
  //   }
  //   p = p + "]}";

  //   p = p + "]}";
  //   p = json.encode(p);
  //   return p;
  // }

  String planningFormModelToJSONString() {
    //company,department,costelements, month , year
    String pfmInJSONStringForm = "{";
    pfmInJSONStringForm =
        pfmInJSONStringForm + '"Company": ' + '"${this.company}"' + ",";
    pfmInJSONStringForm =
        pfmInJSONStringForm + '"Department":' + '"${this.selectedDepartment}"' + ",";
    pfmInJSONStringForm = pfmInJSONStringForm + '"CostElements":[';
    for (String ce in this.costElements) {
      pfmInJSONStringForm = pfmInJSONStringForm + '"' + ce + '",';
    }
    //print("before = " +pfmInJSONStringForm );
    pfmInJSONStringForm =
        pfmInJSONStringForm.substring(0, pfmInJSONStringForm.length - 1);
    // print("after = " +pfmInJSONStringForm );
    pfmInJSONStringForm = pfmInJSONStringForm + "]," + '"Plan":' + "[";

    for (String ce in this.costElements) {
      pfmInJSONStringForm =
          pfmInJSONStringForm + "{" + '"Category":' + '"${ce}",';
      //pfmInJSONStringForm = pfmInJSONStringForm + "{" +'"${ce}":';
      pfmInJSONStringForm =
          pfmInJSONStringForm + "${this.ceToMpMap[ce].toJSONString()}" + "},";
    }
    pfmInJSONStringForm =
        pfmInJSONStringForm.substring(0, pfmInJSONStringForm.length - 1);
    pfmInJSONStringForm = pfmInJSONStringForm + "]";

    pfmInJSONStringForm = pfmInJSONStringForm + "," + '"Actual":' + "[";

    for (String ce in this.costElements) {
      pfmInJSONStringForm =
          pfmInJSONStringForm + "{" + '"Category":' + '"${ce}",';
      pfmInJSONStringForm =
          pfmInJSONStringForm + "${this.ceToMaMap[ce].toJSONString()}" + "},";
    }

    pfmInJSONStringForm =
        pfmInJSONStringForm.substring(0, pfmInJSONStringForm.length - 1);
    pfmInJSONStringForm = pfmInJSONStringForm + "]";

    pfmInJSONStringForm = pfmInJSONStringForm + "," + '"Varience":' + "[";

    for (String ce in this.costElements) {
      pfmInJSONStringForm =
          pfmInJSONStringForm + "{" + '"Category":' + '"${ce}",';
      //pfmInJSONStringForm = pfmInJSONStringForm + "{" +'"${ce}":';
      pfmInJSONStringForm =
          pfmInJSONStringForm + "${this.ceToMvMap[ce].toJSONString()}" + "},";
    }
    pfmInJSONStringForm =
        pfmInJSONStringForm.substring(0, pfmInJSONStringForm.length - 1);
    pfmInJSONStringForm = pfmInJSONStringForm + "]";

    pfmInJSONStringForm = pfmInJSONStringForm + "}";
    print("pfmInJSONStringForm =" + pfmInJSONStringForm);

    return pfmInJSONStringForm;
  }

  savePfmToFile() {
    this.st.writeData(this.planningFormModelToJSONString());

    // this.st.writeData(this.toString());
  }






  Future<String> readPfmFromFile() {
    return this.st.readData();
  }



    savepfmToFirebase() {
      int pm, am, vm, ph, ah, vh;

      String path = "";
      String company = "company"; // this.Company;
      String department = "department"; //this.department;
      String year = "2019"; //this.year;
      String month = "janaury"; //this.month;
     path ="/" + " organizationSaved" +"/" + "organizationSaved" + "/" +  "company" +  "/" + "company" +  "/" + "Cleaning Product Department/"+ "Cleaning Product Department" ;
      // path = "/" + company + "/" + company + "/" + department + "/" + department + "/" + year + "/" + year + "/" + month + "/" + month ;
      //path = "/" + company + "/" + department + "/" + year + "/" + month;
      List mPAmts;
      List mPHrs;

      List mAHrs;
      List mAAmts;
      List mVHrs;
      List mVAmts;
      MonthlyPlan mp;
      DocumentReference planDocRef;
      Map<String, List> planData;
      for (String ce in this.costElements) {
        mPAmts = new List<int>();
        mPHrs = new List<int>();
        mAHrs = new List<int>();
        mAAmts = new List<int>();
        mVHrs = new List<int>();
        mVAmts = new List<int>();
        String a = ce;
        // Firestore.instance.document("/PlanningFormModel/PlanningFormModel/ceToMaMap/ceToMaMap/$a/$a");
        planDocRef = Firestore.instance.document("$path/plan/plan/$a/$a");
        final DocumentReference actualDocRef =
            Firestore.instance.document("$path/actual/actual/$a/$a");
        final DocumentReference varienceDocRef =
            Firestore.instance.document("$path/varience/varience/$a/$a");
        MonthlyPlan mp = this.ceToMpMap[ce];
        MonthlyActual ma = this.ceToMaMap[ce];
        MonthlyVariance mv = this.ceToMvMap[ce];

        //}

        for (PlanValue amount in mp.amountInMonth) {
          pm = amount.value;
          mPAmts.add(pm);
        }

        for (PlanValue hour in mp.hourInMonth) {
          ph = hour.value;
          mPHrs.add(ph);
        }

        for (ActualValue amount in ma.amountInMonth) {
          am = amount.value;
          mAAmts.add(am);
        }

        for (ActualValue hour in ma.hourInMonth) {
          ah = hour.value;
          mAHrs.add(ah);
        }

        for (VarianceValue amount in mv.amountInMonth) {
          vm = amount.value;
          mVAmts.add(vm);
        }

        for (VarianceValue hour in mv.hourInMonth) {
          vh = hour.value;
          mVHrs.add(vh);
        }

        planData = <String, List>{
          "amountInMonth": mPAmts,
          "hrInMonth": mPHrs,
          // "amountInMonth":mp.amountInMonth,
          // "hrInMonth":mp.hourInMonth,
        };

        Map<String, List> actualData = <String, List>{
          // "amountInMonth":monthlyActualAmts,
          // "amountInMonth":ma.amountInMonth,
          // "hrInMonth":ma.hourInMonth,
          "amountInMonth": mAAmts,
          "hrInMonth": mAHrs,
        };

        Map<String, List> varienceData = <String, List>{
          "amountInMonth": mVAmts,
          "hrInMonth": mVHrs,
        };

        // "amountInMonth":monthlyActualAmts,
        // "amountInMonth":mv.amountInMonth,
        // "hrInMonth":mv.hourInMonth,

        //below codes saves planValue to firebase

        print("the document reference = " + planDocRef.toString());
        planDocRef.setData(planData).whenComplete(() {
          print("Document Added");
        }).catchError((e) => print(e));
        //   if(planData.toString() ==""){
        // planDocRef.setData(planData).whenComplete(() {
        //   print("Document Added");
        // }).catchError((e) => print(e));
        //   }
        //   else{
        //     planDocRef.updateData(planData).whenComplete(() {
        //     print("Document updated");
        // }).catchError((e) => print(e));

        // }
        // below codes saves actualValue to firebase
        actualDocRef.setData(actualData).whenComplete(() {
          print("Document Added");
        }).catchError((e) => print(e));

        //below codes saves varienceValue to firebase
        varienceDocRef.setData(varienceData).whenComplete(() {
          print("Document Added");
        }).catchError((e) => print(e));
      }
    }
  

/*savePfm
if  device is online
call savePfmTOfirebase

  savePfmToFile
//savePfmtoFirebase(){


*/

  saveData() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
        //  this.isOnline=true;
      this.savepfmToFirebase();
    } else {
      print("no internet access");
      // this.isOnline=false;
    }
    this.savePfmToFile();
  }

}

class DataValue {
  int index;
  int value;

  DataValue(int amt, int idx) {
    this.value = amt;
    this.index = idx;
  }
}

class PlanValue extends DataValue {
  PlanValue(int amt, int idx) : super(amt, idx);
}

class ActualValue extends DataValue {
  ActualValue(int amt, int idx) : super(amt, idx);
}

class VarianceValue extends DataValue {
  VarianceValue(int amt, int idx) : super(amt, idx);
}

class  MonthlyValues {
  String category;
  List<DataValue> amountInMonth;
  List<DataValue> hourInMonth;
  //List<String> categories;

  MonthlyValues();

  factory MonthlyValues.fromJSONMapma(maJSONMap) {
    MonthlyValues mv = new MonthlyActual();

    mv.category = maJSONMap['Category'];

    List amts = maJSONMap['amountInMonth'];
    List hrs = maJSONMap['hourInMonth'];
    mv.amountInMonth = new List<ActualValue>();
    mv.hourInMonth = new List<ActualValue>();
    int i = 0;
    for (var a in amts) {
      ActualValue dv = new ActualValue(int.parse(a), i);
      mv.amountInMonth.add(dv);
      i = i + 1;
    }
    for (var h in hrs) {
      ActualValue dv = new ActualValue(int.parse(h), i);
      mv.hourInMonth.add(dv);
      i = i + 1;
    }
    return mv;
  }

  factory MonthlyValues.fromJSONMapmv(mvJSONMap) {
    MonthlyValues mv = new MonthlyVariance();

    mv.category = mvJSONMap['Category'];
    List amts = mvJSONMap['amountInMonth'];
    List hrs = mvJSONMap['hourInMonth'];
    mv.amountInMonth = new List<VarianceValue>();
    mv.hourInMonth = new List<VarianceValue>();
    int i = 0;
    for (var a in amts) {
      VarianceValue dv = new VarianceValue(int.parse(a), i);
      mv.amountInMonth.add(dv);
      i = i + 1;
    }
    for (var h in hrs) {
      VarianceValue dv = new VarianceValue(int.parse(h), i);
      mv.hourInMonth.add(dv);
      i = i + 1;
    }
    return mv;
  }

  factory MonthlyValues.fromJSONMapmp(mpJSONMap) {
    MonthlyValues mv = new MonthlyPlan();

    mv.category = mpJSONMap['Category'];
    List amts = mpJSONMap['amountInMonth'];
    List hrs = mpJSONMap['hourInMonth'];
    mv.amountInMonth = new List<PlanValue>();
    mv.hourInMonth = new List<PlanValue>();
    int i = 0;
    int j = 0;
    for (var a in amts) {
      PlanValue dv = new PlanValue(int.parse(a), i);
      mv.amountInMonth.add(dv);
      i = i + 1;
    }

    for (var h in hrs) {
      PlanValue dv = new PlanValue(int.parse(h), j);
      mv.hourInMonth.add(dv);
      j = j + 1;
    }
    return mv;
  }

  String toJSONString() {
    String s = "";
    //s = s + "{";
    s = s + '"amountInMonth":[';
    for (DataValue amount in this.amountInMonth) {
      s = s + '"${amount.value.toString()}",';
    }

    // print("before = " +s );
    s = s.substring(0, s.length - 1);
    //print("after = " +s );
    s = s + "],";

    s = s + '"hourInMonth":[';

    for (DataValue hour in this.hourInMonth) {
      s = s + '"${hour.value.toString()}",';
    }

    //print("before = " +s );
    s = s.substring(0, s.length - 1);
    //print("after = " +s );
    s = s + "],";

    //print("before = " +s );
    s = s.substring(0, s.length - 1);
    // print("after = " +s );

    return s;
  }
}

//  PlanningFormModel pfm = new PlanningFormModel();
//   String s = "";
//   for (String ce in pfm.costElements) {
//     s = s + "{";
//     s = s + '"' + ce + '":{';
//     s = s + '"amountInMonth":[';

class MonthlyActual extends MonthlyValues {
  MonthlyActual();

  factory MonthlyActual.fromJSONMapma(Map ma) {
    return new MonthlyValues.fromJSONMapma(ma);
  }

  // String monthlyActualToJson() {
  //   PlanningFormModel pfm = new PlanningFormModel();
  //   String s = "";
  //   for (String ce in pfm.costElements) {
  //     s = s + "{";
  //     s = s + "'" + ce + "':{";
  //     s = s + "'amountInMonth':[";
  //     for (ActualValue i in amountInMonth) {
  //       s = s + "'" + i.value.toString() + "',";
  //     }
  //     s = s + "],";

  //     s = s + "'hourInMonth':[";
  //     for (ActualValue i in hourInMonth) {
  //       s = s + "'" + i.value.toString() + "',";
  //     }
  //     s = s + "]}},";

  //     // s = json.encode(s);
  //   }

  //   return s;
  // }

  List<ActualValue> getMonthlyActual(bool isHour) {
    if (isHour)
      return this.hourInMonth;
    else
      return this.amountInMonth;
  }
}

class MonthlyVariance extends MonthlyValues {
  MonthlyVariance();
  factory MonthlyVariance.fromJSONMapmv(Map mv) {
    return MonthlyValues.fromJSONMapmv(mv);
  }

  // String monthlyVarianceToJson() {
  //   PlanningFormModel pfm = new PlanningFormModel();
  //   String s = "";
  //   for (String ce in pfm.costElements) {
  //     s = s + "{";
  //     s = s + "'" + ce + "':{";
  //     s = s + "'amountInMonth':[";
  //     for (VarianceValue i in amountInMonth) {
  //       s = s + "'" + i.value.toString() + "',";
  //     }
  //     s = s + "],";

  //     s = s + "'hourInMonth':[";
  //     for (VarianceValue i in hourInMonth) {
  //       s = s + "'" + i.value.toString() + "',";
  //     }
  //     s = s + "]}}";

  //     // s = json.encode(s);
  //   }

  //   return s;
  // }

  List<VarianceValue> getMonthlyVariance(bool isHour) {
    if (isHour)
      return this.hourInMonth;
    else
      return this.amountInMonth;
  }
}

class MonthlyPlan extends MonthlyValues {
  MonthlyPlan();

  factory MonthlyPlan.fromJSONMapmp(Map mp) {
    return new MonthlyValues.fromJSONMapmp(mp);
  }

  // String monthlyPlanToJson() {

  // PlanningFormModel pfm = new PlanningFormModel();
  // String s = "";
  // for (String ce in pfm.costElements) {
  //   s = s + "{";
  //   s = s + "'" + ce + "':{";
  //   s = s + "'amountInMonth':[";
  //   for (PlanValue i in amountInMonth) {
  //     s = s + "'" + i.value.toString() + "',";
  //   }
  //   s = s + "],";

  //   s = s + "'hourInMonth':[";
  //   for (PlanValue i in hourInMonth) {
  //     s = s + "'" + i.value.toString() + "',";
  //   }
  //   s = s + "]}},";

  // s = json.encode(s);
  // }

  // return s;
  //}

  List<PlanValue> getMonthlyPlan(bool isHour) {
    if (isHour)
      return this.hourInMonth;
    else
      return this.amountInMonth;
  }
}

// change storage class to fileStorage , save connecticity check
class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.json');
  }


  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }

  Future<String> readData() async {
    try
    
     {
      final file = await localFile;
      String body = await file.readAsString();
      print("What, It is not working");
      return body;
    } catch (e) {
      print("What is happening,It is not working");
      return null;
    }
  }
}
