module Application.Helper.Validators where

import IHP.ControllerPrelude

isSameOrAfterDay :: Day -> Day -> ValidatorResult
isSameOrAfterDay day1 day2 | day2 >= day1 = Success
isSameOrAfterDay day1 day2 = Failure "Date must be today or later"