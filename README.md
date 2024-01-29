[![Actions Status](https://github.com/tbrowder/Holidays-Miscellaneous/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/Holidays-Miscellaneous/actions) [![Actions Status](https://github.com/tbrowder/Holidays-Miscellaneous/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/Holidays-Miscellaneous/actions) [![Actions Status](https://github.com/tbrowder/Holidays-Miscellaneous/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/Holidays-Miscellaneous/actions)

NAME
====

**Holidays::Miscellaneous** - Provides perpetual data for miscellaneous holidays

SYNOPSIS
========

```raku
use Holidays::Miscellaneous;
```

DESCRIPTION
===========

**Holidays::Miscellaneous** is a collection of holiday data the author uses for *perpetual* calendar creation. (The term *perpetual* is used to mean the source code to generate the calendar's holiday dates is valid for any given year since the code uses the documented rules for determining those dates and no additional data need be inserted in the code annually.)

Note the names and dates of the holidays are those customarily used in the U.S., but several of those holidays are commonly celebrated in other countries around the world.

Current holiday list
--------------------

  * Groundhog Day - February 2

  * Valentine's Day - February 14

  * St. Patrick's Day - March 17

  * *Mother's Day - second Sunday in May

  * *Armed Forces Day - third Saturday in May

  * Flag Day - June 14

  * *Father's Day - third Sunday in June

  * Pearl Harbor Day - December 7

Holidays marked with a leading '*' are classified as 'calculated' holidays since their observed date vary from year to year and this module uses module **Date::Utils** for the calculation.

The holidays without the leading asterisk are classified as 'directed' or 'fixed' since they are always on fixed dates.

SEE ALSO
========

Related Raku modules by the author:

  * **Date::Christian::Advent**

  * **Date::Easter**

  * **Holidays::US::Federal**

  * **Calendar**

  * **Calendar::Christian**

  * **Calendar::Jewish**

  * **Date::Event**

  * **Date::Utils**

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2024 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

