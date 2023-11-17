{-# LANGUAGE OverloadedStrings #-}
module System.Logging.JSON where

import Control.Monad.IO.Class
import Data.Aeson (ToJSON(..), Value(..), (.=), object, encode)
import Data.ByteString.Lazy.Char8 as ByteString
import System.Logging.Types

instance ToJSON Priority where
  toJSON p =
    String $ case p of
               Debug -> "debug"
               Info -> "info"
               Warning -> "warning"
               Error -> "error"
               Critical -> "critical"

instance ToJSON ctx => ToJSON (LogEntry ctx) where
  toJSON e = object [ "priority" .= e.priority
                    , "text" .= e.text
                    , "context" .= e.context
                    ]

jsonLogToStdout :: (MonadIO m, ToJSON ctx) => LogEntry ctx -> m ()
jsonLogToStdout = liftIO . ByteString.putStrLn . encode
