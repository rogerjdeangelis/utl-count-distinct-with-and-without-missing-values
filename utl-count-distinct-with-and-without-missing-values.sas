%let pgm=utl-count-distinct-with-and-without-missing-values;

Count distinct with and without missing values

      Two Solutions
          1. SQL
             FreelanceReinhard

          2. Proc freq
             PageMiller

github
https://tinyurl.com/27tawj8f
https://github.com/rogerjdeangelis/utl-count-distinct-with-and-without-missing-values

SAS Communities
https://tinyurl.com/2p8mu34k
https://communities.sas.com/t5/SAS-Programming/How-to-Calculate-distinct-count-using-PROC-SQL-with-missing/m-p/801406

FreelanceReinhard
https://communities.sas.com/t5/user/viewprofilepage/user-id/32733

PageMiller
https://communities.sas.com/t5/user/viewprofilepage/user-id/10892

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/
options missing='.';
data have;
   call streaminit(54321);
   array socks[5] $6 ("ORANGE","WHITE","BLACK","GREEN","YELLOW" );
   do i = 1 to 5;
      sock_number = rand("Table", 0.2, 0.3, 0.1,0.3,0.1);
      sock_colors=socks[sock_number];
      output;
   end;
   do i=1 to 2;
      sock_colors="";
      sock_number=.;
      output;
   end;
   do i=1 to 2;
      sock_color="";
      sock_number=.A;
      output;
   end;
   sock_color="";
   sock_number=.Z;
   output;
   keep sock_number sock_colors;
run;quit;


/********************************************************************************************/
/*                                                                                          */
/* Up to 40 obs from HAVE total obs=10 18MAR2022:16:43:10                                   */
/*                                                                                          */
/*                           |  RULES                                                       */
/*                           |                                                              */
/*                           |  SOCK_COLORS_ OCK_NUMBER_  SOCK_NUMBERS_ SOCK_COLORS_        */
/*         SOCK_    SOCK_    |    WITHOUT_    WITHOUT_        WITH         WITH             */
/* Obs    NUMBER    COLORS   |    MISSING      MISSING      MISSING       MISSING           */
/*                           |                                                              */
/*   1       2      WHITE    |       4            4         7 (4+3)       5 (4+1)           */
/*   2       3      BLACK    |                                                              */
/*   3       4      GREEN    |                                                              */
/*   4       1      ORANGE   |                                                              */
/*   5       2      WHITE    |                                                              */
/*                           |                                                              */
/*   6       .               |                                                              */
/*   7       .               |                                                              */
/*   8       A               |                                                              */
/*   9       A               |                                                              */
/*  10       Z               |                                                              */
/*                                                                                          */
/********************************************************************************************/

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/********************************************************************************************/
/*             _                                                                            */
/*   ___  __ _| |                                                                           */
/*  / __|/ _` | |                                                                           */
/*  \__ \ (_| | |                                                                           */
/*  |___/\__, |_|                                                                           */
/*          |_|                                                                             */
/*                                                                                          */
/* Up to 40 obs WORK.WANT total obs=1 18MAR2022:16:51:16                                    */
/*                                                                                          */
/*        SOCK_COLORS_                    SOCK_NUMBER_                                      */
/*          WITHOUT_      SOCK_COLORS_      WITHOUT_      SOCK_NUMBER_                      */
/* Obs       MISSING      WITH_MISSING       MISSING      WITH_MISSING                      */
/*                                                                                          */
/*  1           4               5               4               7                           */
/*    __                                                                                    */
/*   / _|_ __ ___  __ _                                                                     */
/*  | |_| `__/ _ \/ _` |                                                                    */
/*  |  _| | |  __/ (_| |                                                                    */
/*  |_| |_|  \___|\__, |                                                                    */
/*                   |_|                                                                    */
/*                                                                                          */
/*              Number of Variable Levels                                                   */
/*                                                                                          */
/*                              Missing    Nonmissing                                       */
/*  Variable         Levels      Levels        Levels                                       */
/*  -------------------------------------------------                                       */
/*  SOCK_NUMBER           7           3             4                                       */
/*  SOCK_COLORS           5           1             4                                       */
/*                                                                                          */
/********************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|        _
 ___  __ _| |
/ __|/ _` | |
\__ \ (_| | |
|___/\__, |_|
        |_|
*/

proc sql;
  create
    table want as
  select
    count ( distinct sock_colors )                       as sock_colors_without_missing
   ,count ( distinct sock_colors ) + max(sock_colors="") as sock_colors_with_missing
   ,count ( distinct sock_number )                       as sock_number_without_missing
   ,count ( distinct put(sock_number,hex16.) )           as sock_number_with_missing
  from
    have
;quit;
/*__
 / _|_ __ ___  __ _
| |_| `__/ _ \/ _` |
|  _| | |  __/ (_| |
|_| |_|  \___|\__, |
                 |_|
*/
proc freq data=have nlevels;
 tables sock_number sock_colors;
run;quit;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
