public with sharing class CustomerSearchEngine {
    public static List<List<SObject>> executeGlobalCRMSearch(String term) {
        if (String.isBlank(term) || term.length() < 2) { return new List<List<SObject>>(); }
        return [FIND :term IN ALL FIELDS 
                RETURNING Account(Id, Name, Industry), Contact(Id, Name, Email), Case(Id, Subject, Status)];
    }
}
