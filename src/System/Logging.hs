{-# LANGUAGE CPP #-}
module System.Logging (module Export) where

#ifdef WITHJSON
import System.Logging.JSON as Export
#endif
import System.Logging.Plain as Export
import System.Logging.Types as Export
import System.Logging.Utils as Export
