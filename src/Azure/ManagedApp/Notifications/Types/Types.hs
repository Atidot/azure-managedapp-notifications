{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Azure.ManagedApp.Notifications.Types.Types where

import "base" GHC.Generics  (Generic)
import "base" Data.Data     (Data)
import "base" Data.Typeable (Typeable)
import "text" Data.Text     (Text)
import "time" Data.Time     (UTCTime)

data Notification
    -- https://docs.microsoft.com/en-us/azure/azure-resource-manager/managed-applications/publish-notifications#service-catalog-application-notification-schema
    = ServiceCatalogNotification
    { _eventType               :: !EventType
    , _applicationId           :: !ApplicationId
    , _eventTime               :: !UTCTime
    , _provisioningState       :: !ProvisioningState
    , _applicationDefinitionId :: !ApplicationDefinitionId
    , _error                   :: !(Maybe Error)
    }
    -- https://docs.microsoft.com/en-us/azure/azure-resource-manager/managed-applications/publish-notifications#azure-marketplace-application-notification-schema
    | AzureMarketplaceNotification
    { _eventType               :: !EventType
    , _applicationId           :: !ApplicationId
    , _eventTime               :: !UTCTime
    , _provisioningState       :: !ProvisioningState
    , _billingDetails          :: !BillingDetails
    , _plan                    :: !Plan
    , _error                   :: !(Maybe Error)
    }
    deriving (Show, Read, Eq, Ord, Data, Typeable, Generic)

-- https://docs.microsoft.com/en-us/azure/azure-resource-manager/managed-applications/publish-notifications#event-triggers
data EventType
    = PUT
    | PATCH
    | DELETE
    deriving (Show, Read, Eq, Ord, Enum, Bounded, Data, Typeable, Generic)

data ProvisioningState
    = Accepted
    | Succeeded
    | Failed
    | Deleting
    | Deleted
    deriving (Show, Read, Eq, Ord, Enum, Bounded, Data, Typeable, Generic)

data ApplicationId
    = ApplicationId
    { _subId           :: !Text
    , _rgName          :: !Text
    , _applicationName :: !Text
    }
    deriving (Show, Read, Eq, Ord, Data, Typeable, Generic)

data ApplicationDefinitionId
    = ApplicationDefinitionId
    { _subId      :: !Text
    , _rgName     :: !Text
    , _appDefName :: !Text
    }
    deriving (Show, Read, Eq, Ord, Data, Typeable, Generic)

data BillingDetails
    = BillingDetails
    { _resourceUsageId :: !Text
    }
    deriving (Show, Read, Eq, Ord, Data, Typeable, Generic)

data Plan
    = Plan
    { _publisher :: !Text
    , _product   :: !Text
    , _name      :: !Text
    , _version   :: !Text
    }
    deriving (Show, Read, Eq, Ord, Data, Typeable, Generic)

data ErrorDetail
    = ErrorDetail
    { _code    :: !Text
    , _message :: !Text
    }
    deriving (Show, Read, Eq, Ord, Data, Typeable, Generic)

data Error
    = Error
    { _code    :: !Text
    , _message :: !Text
    , _details :: ![ErrorDetail]
    }
    deriving (Show, Read, Eq, Ord, Data, Typeable, Generic)
