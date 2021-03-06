module IdrisWeb.Common.Date
import Builtins
%access public

{- Simple date and time records.
   Like, really simple. They'll do for now.

   Allows date serialisation and deserialisation as per
   RFC822, which is used when setting cookies.

   TODO: Timezones, timestamp, comparison

-}

data Day = Monday
         | Tuesday
         | Wednesday
         | Thursday
         | Friday
         | Saturday
         | Sunday


data Month = January
           | February
           | March
           | April
           | May
           | June
           | July
           | August
           | September
           | October
           | November
           | December

-- Not using the show typeclass for cookies, since there are so many
-- different ways of showing dates.
showCookieDay : Day -> String
showCookieDay Monday = "Mon"
showCookieDay Tuesday = "Tue"
showCookieDay Wednesday = "Wed"
showCookieDay Thursday = "Thu"
showCookieDay Friday = "Fri"
showCookieDay Saturday = "Sat"
showCookieDay Sunday = "Sun"


--private
{-
divides : Integer -> Integer -> Bool
divides x y = (x `mod` y) == 0

isLeapYear : (year : Integer) -> Bool
isLeapYear y = if divides y 400 then True
                   else if divides y 100 then False
                   else if divides y 4 then True
                   else False


--  where y : Nat
  --      y = cast year
  -}

isLeapYear : (year : Integer) -> Bool
isLeapYear year = if (y `mod` 400) == O then True
                   else if (y `mod` 100) == O then False
                   else if (y `mod` 4) == O then True
                   else False
  where y : Nat
        y = cast year

daysInMonth : Month -> (year : Integer) -> Int
daysInMonth September _ = 30
daysInMonth April _ = 30
daysInMonth June _ = 30
daysInMonth November _ = 30
daysInMonth February y = if isLeapYear y then 29
                                         else 28
daysInMonth _ _ = 31

dayOfWeek : (year : Integer) -> (month : Integer) -> (day : Integer) -> Int
dayOfWeek year month day = d + (2.6 * m) 
  where y = if (month == 1 || month == 2) then year - 1 else year
        m = (month - 2) `mod` 12
        d = daysInMonth month

public
record Date : Type where 
  MkDate : (day : Integer) ->
           (month : Integer) ->
           (year : Integer) -> Date

public
record DateTime : Type where
  MkDateTime : (day : Integer) ->
               (month : Integer) ->
               (year : Integer) ->
               (hour : Integer) -> 
               (minute : Integer) ->
               (second : Integer) ->
               DateTime


-- Why everyone can't just use the ISO one, I'll never know...
-- Wed, 13 Jan 2021 22:23:01 GMT
--abstract
--showCookieTime : DateTime -> String
--showCookieTime dt 
