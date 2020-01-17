{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Azure.ManagedApp.Notifications.Types.Lens where

import        Prelude hiding (error)
import "lens" Control.Lens (makeClassy)
import        Azure.ManagedApp.Notifications.Types.Types

makeClassy ''Notification
