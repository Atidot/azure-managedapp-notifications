# azure-managedapp-notifications
Haskell implementation of Azure Managed Application Notifications
* [Azure ManagedApp Notifications]
* Using Haskell's [servant] package
* Haskell types are leveraged to describe schemas and API
  * [Notification schema]
  * [API definition]

### Example
* Running the server
``` shell
22:33 barak@berkos:~/Development/atidot/azure-managedapp-notifications (master) $ cabal new-run
Up to date


```
* Testing with cURL
* [Test notification]
``` shell
22:35 barak@berkos:~ $ cat ~/notif.json
{
    "eventType": "PUT",
    "applicationId": "subscriptions/<subId>/resourceGroups/<rgName>/providers/Microsoft.Solutions/applications/<applicationName>",
    "eventTime": "2019-08-14T19:20:08.1707163Z",
    "provisioningState": "Succeeded",
    "billingDetails": {
        "resourceUsageId":"<resourceUsageId>"
    },
    "plan": {
        "publisher": "publisherId",
        "product": "offer",
        "name": "skuName",
        "version": "1.0.1"
    }
}
22:35 barak@berkos:~ $ curl --header "Content-Type: application/json" --request POST --data @notif.json http://localhost:8080/resource
[]22:35 barak@berkos:~ $

```
* Server prints
* [Source reference]
``` shell
22:33 barak@berkos:~/Development/atidot/azure-managedapp-notifications (master) $ cabal new-run
Up to date

"----------------------------"
"Implement your handler here"
AzureMarketplaceNotification {_eventType = PUT, _applicationId = ApplicationId {_subId = "<subId>", _rgName = "<rgName>", _applicationName = "<applicationName>"}, _eventTime = 2019-08-14 19:20:08.170716
3 UTC, _provisioningState = Succeeded, _billingDetails = BillingDetails {_resourceUsageId = "<resourceUsageId>"}, _plan = Plan {_publisher = "publisherId", _product = "offer", _name = "skuName", _versio
n = "1.0.1"}, _error = Nothing}
```
[Azure ManagedApp Notifications]: https://docs.microsoft.com/en-us/azure/azure-resource-manager/managed-applications/publish-notifications
[Test notification]: https://docs.microsoft.com/en-us/azure/azure-resource-manager/managed-applications/publish-notifications#azure-marketplace-application-notification-schema
[Source reference]: https://github.com/Atidot/azure-managedapp-notifications/blob/5aacc1c449735506de61dfd983fca886e0b1d4c5/app/Main.hs#L23
[servant]: https://www.servant.dev/
[Notification schema]: https://github.com/Atidot/azure-managedapp-notifications/blob/fe35521741f08b577ef5a2b430ac79e58078df31/src/Azure/ManagedApp/Notifications/Types/Types.hs#L15
[API definition]: https://github.com/Atidot/azure-managedapp-notifications/blob/master/src/Azure/ManagedApp/Notifications/API.hs#L12
