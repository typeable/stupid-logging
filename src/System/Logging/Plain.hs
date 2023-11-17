{-# LANGUAGE OverloadedStrings #-}
module System.Logging.Plain where

import Control.Monad.IO.Class
import Data.Text (Text)
import Data.Text qualified as Text
import Data.Text.IO qualified as Text
import System.Logging.Types

formatMsg :: Show ctx => LogEntry ctx -> Text
formatMsg msg = Text.unlines [ "[" <> Text.pack (show msg.priority) <> "]"
                             , msg.text
                             , "Context: " <> Text.pack (show msg.context)
                             ]

msgToStdout :: (MonadIO m, Show ctx) => LogEntry ctx -> m ()
msgToStdout = liftIO . Text.putStr . formatMsg
