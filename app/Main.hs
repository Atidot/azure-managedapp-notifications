{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

import "base"                           Control.Monad.IO.Class (liftIO)
import "warp"                           Network.Wai.Handler.Warp (run)
import "servant-server"                 Servant.Server
import "azure-managedapp-notifications" Azure.ManagedApp.Notifications.API
import "azure-managedapp-notifications" Azure.ManagedApp.Notifications.Types

handler :: Maybe String
        -- ^ Optional Parameter
        -> Notification
        -- ^ Notification
        -> Handler ()
handler mParam notification@ServiceCatalogNotification{..} = do
    liftIO $ print "----------------------------"
    liftIO $ print "Implement your handler here"
    liftIO $ print notification
    return ()

handler mParam notification@AzureMarketplaceNotification{..} = do
    liftIO $ print "----------------------------"
    liftIO $ print "Implement your handler here"
    liftIO $ print notification
    return ()


server :: Server NotificationsAPI
server = handler

app :: Application
app = serve notificationsAPI server

main :: IO ()
main = do
    run 8080 app
