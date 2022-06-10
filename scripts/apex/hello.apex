List <EntitlementContact> entlContacts = 
                [Select e.EntitlementId,e.ContactId,e.Entitlement.AssetId 
                From EntitlementContact e
                Where e.ContactId in :contactIds
                And e.Entitlement.EndDate >= Today 
                And e.Entitlement.StartDate <= Today];
system.debug(entlContacts);