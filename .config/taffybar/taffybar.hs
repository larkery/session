{-# LANGUAGE ScopedTypeVariables, OverloadedStrings #-}

import System.Taffybar

import System.Taffybar.Systray
import System.Taffybar.SimpleClock
import System.Taffybar.Weather

import System.Taffybar.Widgets.PollingLabel
import System.Taffybar.CommandRunner

import System.Information.Memory
import System.Information.CPU

import Graphics.UI.Gtk.General.RcStyle (rcParseString)
import System.Taffybar.Battery

import Data.List.Split (splitOn)
import Data.Ratio
import qualified Data.Map as M
import Data.Maybe
import Data.Char
import Text.Printf

import Control.Applicative

import DBus ( toVariant, fromVariant, Signal(..), signal )
import DBus.Client ( addMatch, matchAny, MatchRule(..), connectSession, emit, Client )
import Graphics.UI.Gtk hiding ( Signal )

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

readBatt = do
  thelines <- readFile "/sys/class/power_supply/BAT0/uevent"
  let result = map (break (== '=')) $ lines $ thelines
  return $ M.fromList $ map (\(a, b) -> (a, drop 1 b)) result


battStat :: M.Map String String -> Maybe (Integer, Integer, Integer)
battStat m =
  let a = do full <- M.lookup "POWER_SUPPLY_CHARGE_FULL" m
             now <- M.lookup "POWER_SUPPLY_CHARGE_NOW" m
             current <- M.lookup "POWER_SUPPLY_CURRENT_NOW" m
             return $ (read now :: Integer, read full :: Integer, read current :: Integer)
      b = do full <- M.lookup "POWER_SUPPLY_ENERGY_FULL" m
             now <- M.lookup "POWER_SUPPLY_ENERGY_NOW" m
             current <- M.lookup "POWER_SUPPLY_POWER_NOW" m
             return $ (read now :: Integer, read full :: Integer, read current :: Integer)
  in a <|> b

batteryString :: IO String
batteryString = do
  dat <- readBatt
  return $ fromMaybe "?" $
    do (n, f, r) <- battStat dat
       let per =  (n % f)
       return $ printf "B: %d%%" (floor (min 100 $ per * 100) :: Integer)

batticator = do bat <- pollingLabelNew "..." 5 batteryString
                widgetShowAll bat
                return $ toWidget bat

sep :: IO Widget
sep = do l <- labelNew (Nothing :: Maybe String)
         labelSetMarkup l ("<span fgcolor='grey'>|</span>" :: String)
         widgetShowAll l
         return $ toWidget l

main = do
  let clockCfg = "<span fgcolor='white'>%a %b %d %H:%M</span>"
  let clock = textClockNew Nothing clockCfg 1

  defaultTaffybar defaultTaffybarConfig
                  { barHeight = 14
                  , barPosition = Bottom
                  , startWidgets = [ xmonadLogNew ]
                  , endWidgets = [ systrayNew
                                 , clock
                                 , sep
                                 , batticator
                                 ]
                  }

-- yanked from the codebase as is deprecated, but I like it.

xmonadLogNew :: IO Widget
xmonadLogNew = do
  l <- labelNew (Nothing :: Maybe String)
  _ <- on l realize $ setupDbus l
  widgetShowAll l
  return (toWidget l)

setupDbus :: Label -> IO ()
setupDbus w = do
  let matcher = matchAny { matchSender = Nothing
                          , matchDestination = Nothing
                          , matchPath = Just "/org/xmonad/Log"
                          , matchInterface = Just "org.xmonad.Log"
                          , matchMember = Just "Update"
                          }

  client <- connectSession
  addMatch client matcher (callback w)
  return ()

callback :: Label -> Signal -> IO ()
callback w sig = do
  let [bdy] = signalBody sig
      status :: String
      Just status = fromVariant bdy
  postGUIAsync $ labelSetMarkup w (' ':status)
