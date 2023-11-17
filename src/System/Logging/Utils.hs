module System.Logging.Utils where

import Data.Text
import System.Logging.Types

withContext :: Log m => (LogContext m -> m a) -> m a
withContext f = do ctx <- createContext
                   f ctx

logMessage :: Log m => Priority -> Text -> m ()
logMessage p t =
  withContext $ \ctx ->
    let e = LogEntry { text = t
                     , priority = p
                     , context = ctx
                     }
    in logEntry e

logDebug, logInfo, logWarn, logError, logCritical :: Log m => Text -> m ()
logDebug = logMessage Debug
logInfo = logMessage Info
logWarn = logMessage Warning
logError = logMessage Error
logCritical = logMessage Critical
