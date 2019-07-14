

void main() {
  
  PlanningFormModel pfm = new PlanningFormModel();  
  
  pfm.Company = "N Tech";
  pfm.Department = "Marketing";
  pfm.costElements = new List<String>();
  
  pfm.costElements.add("Transportation");
  pfm.costElements.add("Marketing");
  pfm.costElements.add("Human Resources");
  pfm.costElements.add("Information Technology");
  pfm.costElements.add("Legal");
  
  //instatiate the map to store monthly plan for each costEleemnts
  Map mp = new Map<String,MonthlyPlan>();

  
  for(String ce in pfm.costElements){
    //creaete monthly plan for each cost element 
    MonthlyPlan mPlan = new MonthlyPlan();
    mPlan.category = ce;
    List amt = new List<int>();
    
    for (int i = 1; i < 13; i++) {
      //assign some amount to each of the 12 months
      amt.add(i*125+.25);
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
  pfm.monthLevelPlan = mp;
  
 
}

class PlanningFormModel{
  String Company;
  String Department;
  List<String> costElements;
  Map<String, MonthlyPlan> monthLevelPlan;

  
  PlanningFormModel(){
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

class ReadFIle{

}
class WriteFile{
  
}
