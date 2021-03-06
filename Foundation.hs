{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Foundation where

import Yesod.Core

import Text.Hamlet (HtmlUrl, hamlet,hamletFile)
import Text.Blaze.Renderer.String (renderHtml)
import Data.Text (Text)
import Yesod.Static
import Yesod.Form
import Yesod.Form.Jquery

staticFiles "static"

data App = App{getStatic::Static}


mkYesodData "App" $(parseRoutesFile "config/routes")

instance Yesod App -- where
--   defaultLayout = myLayout


homepageLayout :: Widget -> Handler Html
homepageLayout widget = do
    pc <- widgetToPageContent widget
    giveUrlRenderer $( hamletFile "templates/homepage-layout.hamlet")


instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

-- And tell us where to find the jQuery libraries. We'll just use the defaults,
-- which point to the Google CDN.
instance YesodJquery App where
    --urlJqueryJs :: App -> Either (Route App) Text
    urlJqueryJs _ = Right "/static/jquery.min.js"

    --urlJqueryUiJs :: App -> Either (Route App) Text
    urlJqueryUiJs _ = Right "/static/jquery-ui.min.js"

    --urlJqueryUiCss :: App -> Either (Route App) Text
    urlJqueryUiCss _ = Right "/static/jquery-ui.css"
