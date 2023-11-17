{-# LANGUAGE TypeFamilies #-}
module System.Logging.Types where

import Data.Kind
import Data.Text (Text)

data Priority = Debug
              | Info
              | Warning
              | Error
              | Critical
              deriving (Eq, Ord, Enum)

instance Show Priority where
  show Debug = "DEBUG"
  show Info = "INFO"
  show Warning = "WARNING"
  show Error = "ERROR"
  show Critical = "CRITICAL"

data LogEntry ctx = LogEntry { text :: !Text
                             , priority :: !Priority
                             , context :: !ctx
                             }

class Monad m => Log (m :: Type -> Type) where
  type LogContext m
  createContext :: m (LogContext m)
  logEntry :: LogEntry (LogContext m) -> m ()
