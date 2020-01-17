{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

module Azure.ManagedApp.Notifications.API where

import "base"    Data.Proxy (Proxy(..))
import "servant" Servant.API
import           Azure.ManagedApp.Notifications.Types.Types

type NotificationsAPI
    = "resource"
    :> QueryParam "optional_parameter" String
    :> ReqBody '[JSON] Notification
    :> Post '[JSON] ()

notificationsAPI :: Proxy NotificationsAPI
notificationsAPI = Proxy
