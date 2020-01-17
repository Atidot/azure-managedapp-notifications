{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE RecordWildCards #-}
module Azure.ManagedApp.Notifications.Types.JSON where

import "base"             Control.Applicative ((<|>))
import "base"             Data.Foldable (asum)
import "aeson"            Data.Aeson
import "aeson"            Data.Aeson.TH
import "attoparsec"       Data.Attoparsec.Text
import "template-haskell" Language.Haskell.TH
import                    Azure.ManagedApp.Notifications.Types.Types

$(deriveJSON defaultOptions ''EventType)
$(deriveJSON defaultOptions ''ProvisioningState)
$(deriveJSON defaultOptions{omitNothingFields = True, fieldLabelModifier = drop (length ("_" :: String))} ''BillingDetails)
$(deriveJSON defaultOptions{omitNothingFields = True, fieldLabelModifier = drop (length ("_" :: String))} ''Plan)
$(deriveJSON defaultOptions{omitNothingFields = True, fieldLabelModifier = drop (length ("_errorDetail_" :: String))} ''ErrorDetail)
$(deriveJSON defaultOptions{omitNothingFields = True, fieldLabelModifier = drop (length ("_error_" :: String))} ''Error)

instance ToJSON ApplicationId where
    toJSON ApplicationId{..}
        = String
        $ "subscriptions/"   <> _subId
       <> "/resourceGroups/" <> _rgName
       <> "/providers/Microsoft.Solutions/applications/" <> _applicationName

instance ToJSON ApplicationDefinitionId where
    toJSON ApplicationDefinitionId{..}
        = String
        $ "subscriptions/"   <> _subId
       <> "/resourceGroups/" <> _rgName
       <> "/providers/Microsoft.Solutions/applicationDefinitions/" <> _appDefName

instance FromJSON ApplicationId where
    parseJSON = withText "ApplicationId" $ \t ->
        case parseOnly parser t of
            Right appId -> return appId
            Left _      -> fail "Failed parsing ApplicationId String"
        where
            parser :: Parser ApplicationId
            parser = do
                _      <- string "subscriptions/"
                subId  <- takeTill (== '/')
                _      <- string "/resourceGroups/"
                rgName <- takeTill (== '/')
                _      <- string "/providers/Microsoft.Solutions/applications/"
                applicationName <- takeTill isEndOfLine
                endOfLine <|> endOfInput
                --applicationName <- take
                return $ ApplicationId subId rgName applicationName

instance FromJSON ApplicationDefinitionId where
    parseJSON = withText "ApplicationDefinitionId" $ \t ->
        case parseOnly parser t of
            Right appId -> return appId
            Left _      -> fail "Failed parsing ApplicationDefinitionId String"
        where
            parser :: Parser ApplicationDefinitionId
            parser = do
                _      <- string "subscriptions/"
                subId  <- takeTill (== '/')
                _      <- string "/resourceGroups/"
                rgName <- takeTill (== '/')
                _      <- string "/providers/Microsoft.Solutions/applicationDefinitions/"
                appDefName <- takeTill isEndOfLine
                endOfLine <|> endOfInput
                return $ ApplicationDefinitionId subId rgName appDefName

$(deriveJSON defaultOptions{sumEncoding = UntaggedValue, omitNothingFields = True, fieldLabelModifier = drop (length ("_" :: String))} ''Notification)
