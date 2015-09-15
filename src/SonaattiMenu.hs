{-# LANGUAGE OverloadedStrings #-}
module SonaattiMenu
  ( findMenu
  , findMenus
  ) where

import Control.Lens
import Data.List
import Data.Maybe
import Data.Text (Text)
import Network.Wreq
import Text.XML.Light
import qualified Data.Text as T
import qualified Data.String.Conversions as C

type Menu = (Text,Text)

-- RSS feed URL.
feed :: Text
feed = "http://www.sonaatti.fi/rssfeed/"

-- Clean menu title and description.
cleanMenu :: (Maybe Element,Maybe Element) -> Maybe Menu
cleanMenu (Nothing,_)         = Nothing
cleanMenu (_,Nothing)         = Nothing
cleanMenu ((Just t),(Just d)) =
    let cleanT x = T.pack $ takeWhile (/= ' ') $ strContent x
        cleanD y = T.pack $ filter (/= '\t') $ strContent y
    in  Just (cleanT t, cleanD d)

-- Parse menu from an XML element.
parseMenu :: Element -> [Menu] -> [Menu]
parseMenu x acc =
    let mTitle = findElement (QName "title" Nothing Nothing) x
        mDesc = findElement (QName "description" Nothing Nothing) x
    in case cleanMenu (mTitle, mDesc) of
            Nothing     -> acc
            Just (menu) -> menu:acc

-- Parse menus from XML.
parseMenus :: Maybe Element -> [Menu]
parseMenus Nothing    = []
parseMenus (Just doc) =
    let itemElem = QName "item" Nothing Nothing
        items = findElements itemElem doc
    in  foldr parseMenu [] items

-- Find menu from list.
getMenu :: Text -> [Menu] -> Maybe Menu
getMenu x = find (\(t,_) -> T.toLower t == x)

-- Read RSS feed.
readFeed :: Text -> IO (Maybe Element)
readFeed url = do
    r <- get $ T.unpack url
    let body = C.cs $ r ^. responseBody :: String
        doc = parseXMLDoc body
    return (doc)

-- Find single restaurant menu.
findMenu :: Text -> IO (Maybe Menu)
findMenu r = do
    doc <- readFeed feed
    let menu = getMenu r $ parseMenus doc
    return (menu)

-- Find multiple restaurant menus.
findMenus :: [Text] -> IO [Menu]
findMenus rs = do
    doc <- readFeed feed
    let allMenus = parseMenus doc
        menus = catMaybes $ map (\ x -> getMenu x allMenus) rs
    return (menus)
