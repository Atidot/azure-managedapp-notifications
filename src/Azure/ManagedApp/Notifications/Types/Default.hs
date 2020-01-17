{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}
module Azure.ManagedApp.Notifications.Types.Default where

import "data-default" Data.Default
import                Azure.ManagedApp.Notifications.Types.Types

instance Default EventType where
    def = PUT

instance Default ProvisioningState where
    def = Accepted

instance Default ApplicationId where
    def = ApplicationId "<subId>" "<rgName>" "<applicationName>"

instance Default ApplicationDefinitionId where
    def = ApplicationDefinitionId "<subId>" "<rgName>" "<appDefName>"

instance Default BillingDetails where
    def = BillingDetails "<resourceUsageId>"

instance Default Plan where
    def = Plan "" "" "" ""

instance Default ErrorDetail where
    def = ErrorDetail "" ""

instance Default Error where
    def = Error "" "" []
