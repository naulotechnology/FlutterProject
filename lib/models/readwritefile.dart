

  class PlanningFormModel{
    String Company;
    String Department;
    List<String> costElements;
    Map<String, MonthlyPlan> monthLevelPlan;

    
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

  class ReadFIle{

  }
  class WriteFile{
    
  }
