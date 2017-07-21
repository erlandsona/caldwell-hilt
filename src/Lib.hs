module Lib
    ( someFunc
    ) where

import Data.Monoid ((<>))
-- import Data.Text
import qualified Hilt
import qualified Hilt.Channel as Channel
import qualified Hilt.Logger as Logger
import qualified Hilt.Server as Server
import qualified Hilt.SocketServer as Websocket
import TextShow

someFunc :: IO ()
someFunc = Hilt.manage $ do
  logger <- Logger.load

  let
    onJoined clientId clientCount = do
      Logger.debug logger $ showt clientId <> " joined, " <> showt clientCount <> " connected."
      return Nothing

    onReceive clientId text =
      Logger.debug logger $ showt clientId <> " said " <> showt text

  websocket <- Websocket.load onJoined onReceive

  Hilt.program $ do
    -- Start a HTTP server on port 8081
    Server.runWebsocket websocket
