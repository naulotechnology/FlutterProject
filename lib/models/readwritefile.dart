class PlanningFormModel {
  String Company;
  String Department;
  List<String> costElements;

  PlanningFormModel() {}

  String toString() {
    String planningFormInString = "" + this.Company + " " + this.Department;
    return planningFormInString;
  }
}

class ReadFIle {}

class WriteFile {}
