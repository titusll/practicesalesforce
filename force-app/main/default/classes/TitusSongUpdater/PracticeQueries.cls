public with sharing class PracticeQueries {
    public PracticeQueries() {

    }

    public static Integer totalOppAmount (){

        List<Opportunity> opps = [SELECT Id, Amount FROM Opportunity WHERE StageName = 'Closed Won'];
        Decimal totalAmount;

       Integer listSize = opps.size();

        for (Opportunity o : opps){
            totalAmount = totalAmount + o.Amount;
        }

        Decimal avgTotal = totalAmount/listSize;

        return avgTotal;
    }

    public static List<String> accountsWithHighOpps(){

        List<Account> accts = [SELECT Id, Name FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity WHERE Amount > 50000)];

        List<String> accNames = new List<String>();
        
        for (Account a : accts) {
            accNames.add(a.Name);
        }
        return accNames;
    }

    // Return account with highest count of opportunities
    public static Account accWithMostOpps(){

        Map<Account, Integer> accAndTotalopps = new Map<Account, Integer>();

        List<AggregateResult> results = [SELECT AccountId, COUNT(Id) FROM Opportunity GROUP BY AccountId];

        Account maxOppAcc;

        for (AggregateResult ar : results){

            Id acc = (Id) ar.get('AccountId');
            Integer count = (Integer) ar.get('expr00');
            accAndTotalopps.put(acc, count);
        }

        for (int i = 0; i< accAndTotalopps.keySet(); i++){

            if (accAndTotalopps.get(i) > accAndTotalopps.get(i -1)){
                maxOppAcc = accAndTotalopps.get(i);
            }
        }

        return maxOppAcc;
    }

    // Return accounts with opportunities greater than average amount
    public static List<Account> accWithHigh(){

        Decimal avgOpp = [SELECT AVG(Amount) FROM Opportunity];

        List<Account> accsMeetCriteria = new List<Account>();

        List<Account> accs = [SELECT Id, (SELECT Amount FROM Opportunity) FROM Account];

        for (Account a : accs){
            
            for (Opportunity o : a) {
                    if (o.Amount > avOpp){
                        accsMeetCriteria.add(a);
                        System.debug('HELLO GIT TEST');
                    }
            }
        }
        return accsMeetCriteria;
    }

}