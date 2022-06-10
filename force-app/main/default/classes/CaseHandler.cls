public without sharing class CaseHandler
    implements ITrigger {
    
    // Member variable to hold the Id's of Accounts 'in use'
    private Set<Id> caseIds = new Set<Id>();
 
    // Member variable to record Audit records
    private List<Case> caseList = new List<Case>();

    // Constructor
    public CaseHandler()
    {
    }
 
    /**
     * bulkBefore
     *
     * This method is called prior to execution of a BEFORE trigger. Use this to cache
     * any data required into maps prior execution of the trigger.
     */
    public void bulkBefore()
    {
        // If this a delete trigger Cache a list of Account Id's that are 'in use'
        system.debug('insert? ' + Trigger.isInsert);
        if (Trigger.isInsert)
        {
            caseList = Trigger.new;
        }
    }
 
    public void bulkAfter()
    {
    }
 
    public void beforeInsert(SObject so)
    {
        // Cast the SObject to an Account
        Case myCase = (Case)so;
 
        // Examine the Set and if the account is in use don't allow it to be deleted.
        if (caseList.contains(myCase))
        {
            CaseGateway.generateCaseAutoNumber(caseList);
        }
        else
        {
        }
    }
 
    public void beforeUpdate(SObject oldSo, SObject so)
    {
    }
 
    /**
     * beforeDelete
     *
     * This method is called iteratively for each record to be deleted during a BEFORE
     * trigger.
     */
    public void beforeDelete(SObject so)
    {
    }
 
    public void afterInsert(SObject so)
    {
    }
 
    public void afterUpdate(SObject oldSo, SObject so)
    {
    }
 
    public void afterDelete(SObject so)
    {
    }
 
    /**
     * andFinally
     *
     * This method is called once all records have been processed by the trigger. Use this
     * method to accomplish any final operations such as creation or updates of other records.
     */
    public void andFinally()
    {

    }
}