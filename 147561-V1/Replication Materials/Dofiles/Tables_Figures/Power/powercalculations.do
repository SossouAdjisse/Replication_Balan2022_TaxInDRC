
*###############################################################################
*############### Using Baseline All as Control #########################
*###############################################################################

use "${repldir}/Data/01_base/admin_data/tax_payments_noPII.dta", clear

*####################################################################

recode paid (3 = 1 "Yes")(1 = 0 "No")(else = .), gen(paid_dummy)

/*
gen paid_dummy = (paid == 3)
replace paid_dummy = . if  paid != 1 &  paid != 3
*/

* Summarize the depend variable 
sum paid_dummy 
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
  paid_dummy |      2,204    .0530853    .2242545          0          1
*/

* Getting the intra-cluster correlation
loneway paid_dummy a7 
/*
                 One-way analysis of variance for paid_dummy: 

                                             Number of obs =        2,203
                                                 R-squared =       0.3271

    Source                SS         df      MS            F     Prob > F
-------------------------------------------------------------------------
Between a7             36.242695    251    .14439321      3.78     0.0000
Within a7              74.543506  1,951    .03820785
-------------------------------------------------------------------------
Total                   110.7862  2,202    .05031163

         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.24195     0.02871       0.18568     0.29822

         Estimated SD of a7 effect               .1104313
         Estimated SD within a7                  .1954683
         Est. reliability of a a7 mean            0.73539
              (evaluated at n=8.71)
*/




/*
gen paid_dum2 = paid_dummy*amountCF

	* taxes_paid variable
* Getting the intra-cluster correlation ---> How correlated observations within a cluter are to each other
loneway paid_dum2 a7  /* Intraclass correlation -->  0.17585 ; CI ---> [0.12733   0.22438] */
* Summarize the depend variable 
sum paid_dum2 /* ---> SD = 662.3523 ; Mean = 129.1231 */
*/


*###################################################################

	* Power calculation for the mean paid_dummy (continuous variable)


/* power twomeans Baseline all as Control, Intraclass correlation mean */

	* twomeans power 
* Power for the Intraclass correlation mean 
local suffix "ptmBaseAllAvIntrCorr" 
power twomeans 0.0530853 0.0796, sd(0.2242545) n1(13668) n2(14096) k1(104) k2(109) rho(0.242) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the lower CI of the Intraclass correlation 
local suffix "ptmBaseAllCI1IntrCorr" 
power twomeans 0.0530853 0.0796, sd(0.2242545) n1(13668) n2(14096) k1(104) k2(109) rho(0.18568) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the Intraclass correlation mean 
local suffix "ptmBaseAllCI2IntrCorr" 
power twomeans 0.0530853 0.0796, sd(0.2242545) n1(13668) n2(14096) k1(104) k2(109) rho(0.29822) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


 * proportion power 
* Power for the Intraclass correlation mean 
local suffix "ptpBaseAllAvIntrCorr" 
power twomeans 0.0530853 0.0796, n1(13668) n2(14096) k1(104) k2(109) rho(0.242) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the lower CI of the Intraclass correlation 
local suffix "ptpBaseAllCI1IntrCorr"  
power twomeans 0.0530853 0.0796, n1(13668) n2(14096) k1(104) k2(109) rho(0.18568) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the Intraclass correlation mean 
local suffix "ptpBaseAllCI2IntrCorr"
power twomeans 0.0530853 0.0796, n1(13668) n2(14096) k1(104) k2(109) rho(0.29822) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

gen id = 1
keep id M1* M2* power* alpha* sd* N1* N2* K1* K2* rho* 
duplicates drop 

tempfile BaseAllControl
save `BaseAllControl'

*###############################################################################
*###############################################################################


/*
*###############################################################################
*############### Using Midline Central Dummy as Control #########################
*###############################################################################

	* Loading midline data
use "${repldir}/Data/02_intermediate/midline_cleaned.dta", clear

* Display the label of the variable of taxes payment at the baseline 
describe paid_self 
/*
Variable      Storage   Display    Value
    name         type    format    label      Variable label
--------------------------------------------------------------------------------------
paid_self       byte    %19.0g     yes_no_dk
                                              To date, has your household paid the
                                                property tax in 2018?
*/

* Drop missing from tax13 
drop if paid_self  == .

* Double check if the properties are duplicated 
duplicates report compound1
/*
--------------------------------------
   Copies | Observations       Surplus
----------+---------------------------
        1 |        32623             0
--------------------------------------
*/

* Counting 
count 
/*
32,623
*/

* Counting the number of unique neighborhoods 
egen tag_a7 = tag(a7)
tab treatment tag_a7
/*
. tab treatment tag_a7

           |        tag(a7)
 treatment |         0          1 |     Total
-----------+----------------------+----------
         0 |       515          5 |       520 
         1 |     9,532        109 |     9,641 
         2 |     9,666        110 |     9,776 
         3 |     6,932         79 |     7,011 
         4 |     4,692         50 |     4,742 
         5 |        83          1 |        84 
-----------+----------------------+----------
     Total |    31,420        354 |    31,774 
*/


* Summarize the paid_self variable to get its mean and SD
sum paid_self if inlist(treatment,1)
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   paid_self |      8,303    .1307961    .3371975          0          1
*/

tab treatment
/*
  treatment |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |        520        1.64        1.64
          1 |      9,641       30.34       31.98
          2 |      9,776       30.77       62.75
          3 |      7,011       22.07       84.81
          4 |      4,742       14.92       99.74
          5 |         84        0.26      100.00
------------+-----------------------------------
      Total |     31,774      100.00
*/


* Getting the intra-cluster correlation 
loneway paid_self a7 if inlist(treatment,1)
/*
         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.06549     0.01107       0.04379     0.08719

         Estimated SD of a7 effect               .0863277
         Estimated SD within a7                  .3260988
         Est. reliability of a a7 mean            0.83813
              (evaluated at n=73.88)
*/


	* twomeans power 
* Power for the Intraclass correlation mean 
local suffix "ptmMidCtralAvIntrCorr"
power twomeans 0.131 0.163, sd(0.337) n1(13668) n2(14096) k1(104) k2(109) rho(0.077)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the lower CI of the Intraclass correlation  
local suffix "ptmMidCtralCI1IntrCorr"
power twomeans 0.131 0.163, sd(0.337) n1(13668) n2(14096) k1(104) k2(109) rho(0.063)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the Intraclass correlation mean 
local suffix "ptmMidCtralCI2IntrCorr"
power twomeans 0.131 0.163, sd(0.337) n1(13668) n2(14096) k1(104) k2(109) rho(0.090)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


 * proportion power 
* Power for the Intraclass correlation mean 
local suffix "ptpMidCtralAvIntrCorr"
power twoprop 0.131 0.163, n1(13668) n2(14096) k1(104) k2(109) rho(0.077)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the lower CI of the Intraclass correlation  
local suffix "ptpMidCtralCI1IntrCorr"
power twoprop 0.131 0.163, n1(13668) n2(14096) k1(104) k2(109) rho(0.063)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the Intraclass correlation mean 
local suffix "ptpMidCtralCI2IntrCorr"
power twoprop 0.131 0.163, n1(13668) n2(14096) k1(104) k2(109) rho(0.090)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


gen id = 1
keep id M1* M2* power* alpha* sd* N1* N2* K1* K2* rho* 
duplicates drop 

tempfile MidCtralControl
save `MidCtralControl'

*###############################################################################
*###############################################################################




*###############################################################################
*############### Using Endline Central Dummy as Control #########################
*###############################################################################
* Use clean endline data 
use "${repldir}/Data/01_base/survey_data/endline_round1_noPII.dta", clear
// keep if tot_complete==1 


* Display the label of the variable of taxes payment at the baseline 
describe paid_self 
/*
Variable      Storage   Display    Value
    name         type    format    label      Variable label
--------------------------------------------------------------------------------------
paid_self       byte    %19.0g     yes_no_dk
                                              To date, has your household paid the
                                                property tax in 2018?
*/

* Drop missing from tax13 
drop if paid_self  == .

* Double check if the properties are duplicated 
duplicates report compound_code
/*
--------------------------------------
   Copies | Observations       Surplus
----------+---------------------------
        1 |         2000             0
        2 |           28            14
       38 |           38            37
--------------------------------------
*/

* Dropping duplicated properties 
duplicates drop compound_code, force 

* Counting 
count 
/*
2,015
*/

* Counting the number of unique neighborhoods 
egen tag_a7 = tag(a7)
tab treatment tag_a7
/*
           |        tag(a7)
 treatment |         0          1 |     Total
-----------+----------------------+----------
         0 |        23          5 |        28 
         1 |       419         84 |       503 
         2 |       387         90 |       477 
         3 |       276         55 |       331 
         4 |       190         41 |       231 
-----------+----------------------+----------
     Total |     1,295        275 |     1,570 
*/


* Summarize the paid_self variable to get its mean and SD
sum paid_self if inlist(treatment,1)
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   paid_self |        486    .1893004    .3921507          0          1
*/

* Check the frequencies in the treatments arms 
tab treatment
/*
  treatment |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |         28        1.78        1.78
          1 |        503       32.04       33.82
          2 |        477       30.38       64.20
          3 |        331       21.08       85.29
          4 |        231       14.71      100.00
------------+-----------------------------------
      Total |      1,570      100.00
*/


* Getting the intra-cluster correlation 
loneway paid_self a7 if inlist(treatment,1)
/*
         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.10315     0.04279       0.01929     0.18700

         Estimated SD of a7 effect               .1260216
         Estimated SD within a7                  .3716015
         Est. reliability of a a7 mean            0.34426
              (evaluated at n=4.56)
*/


	* twomeans power 
* Power for the Intraclass correlation mean 
local suffix "ptmEndCtralAvIntrCorr"
power twomeans 0.189 0.221 , sd(0.41) n1(13668) n2(14096) k1(104) k2(109) rho(0.043)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the lower CI of the Intraclass correlation  
local suffix "ptmEndCtralCI1IntrCorr"
power twomeans 0.189 0.221 , sd(0.41) n1(13668) n2(14096) k1(104) k2(109) rho(0.019)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the Intraclass correlation mean 
local suffix "ptmEndCtralCI2IntrCorr"
power twomeans 0.189 0.221 , sd(0.41) n1(13668) n2(14096) k1(104) k2(109) rho(0.187)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


 * proportion power 
* Power for the Intraclass correlation mean 
local suffix "ptpEndCtralAvIntrCorr"
power twoprop 0.189 0.221 , n1(13668) n2(14096) k1(104) k2(109) rho(0.043)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the lower CI of the Intraclass correlation  
local suffix "ptpEndCtralCI1IntrCorr"
power twoprop 0.189 0.221 , n1(13668) n2(14096) k1(104) k2(109) rho(0.019)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'

* Power for the Intraclass correlation mean 
local suffix "ptpEndCtralCI2IntrCorr"
power twoprop 0.189 0.221 , n1(13668) n2(14096) k1(104) k2(109) rho(0.187)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


gen id = 1
keep id M1* M2* power* alpha* sd* N1* N2* K1* K2* rho* 
duplicates drop 

tempfile EndCtralControl
save `EndCtralControl'

*###############################################################################
*###############################################################################




*###############################################################################
*############### Using Endline Control Dummy as Control #########################
*###############################################################################
* Use clean endline data 
use "${repldir}/Data/01_base/survey_data/endline_round1_noPII.dta", clear
// keep if tot_complete==1 


* Display the label of the variable of taxes payment at the baseline 
describe paid_self 
/*
Variable      Storage   Display    Value
    name         type    format    label      Variable label
--------------------------------------------------------------------------------------
paid_self       byte    %19.0g     yes_no_dk
                                              To date, has your household paid the
                                                property tax in 2018?
*/

* Drop missing from tax13 
drop if paid_self  == .

* Double check if the properties are duplicated 
duplicates report compound_code
/*
--------------------------------------
   Copies | Observations       Surplus
----------+---------------------------
        1 |         2000             0
        2 |           28            14
       38 |           38            37
--------------------------------------
*/

* Dropping duplicated properties 
duplicates drop compound_code, force 

* Counting 
count 
/*
2,015
*/

* Counting the number of unique neighborhoods 
egen tag_a7 = tag(a7)
tab treatment tag_a7
/*
           |        tag(a7)
 treatment |         0          1 |     Total
-----------+----------------------+----------
         0 |        23          5 |        28 
         1 |       419         84 |       503 
         2 |       387         90 |       477 
         3 |       276         55 |       331 
         4 |       190         41 |       231 
-----------+----------------------+----------
     Total |     1,295        275 |     1,570 
*/


* Summarize the paid_self variable to get its mean and SD
sum paid_self if inlist(treatment,0)
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   paid_self |         26    .0384615    .1961161          0          1
*/

* Check the frequencies in the treatments arms 
tab treatment
/*
  treatment |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |         28        1.78        1.78
          1 |        503       32.04       33.82
          2 |        477       30.38       64.20
          3 |        331       21.08       85.29
          4 |        231       14.71      100.00
------------+-----------------------------------
      Total |      1,570      100.00
*/


* Getting the intra-cluster correlation 
loneway paid_self a7 if inlist(treatment,0)
/*
         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.00000*    0.15795       0.00000     0.30957

         Estimated SD of a7 effect                      .
         Estimated SD within a7                  .2020305
         Est. reliability of a a7 mean            0.00000*
              (evaluated at n=4.88)
*/


	* twomeans power 
* Power for the Intraclass correlation mean 
local suffix "ptmEndCtrolAvIntrCorr"
power twomeans 0.038 0.07, sd(0.196) n1(13668) n2(14096) k1(104) k2(109) rho(0.158)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the lower CI of the Intraclass correlation  
local suffix "ptmEndCtrolCI1IntrCorr"
power twomeans 0.038 0.07, sd(0.196) n1(13668) n2(14096) k1(104) k2(109) rho(0.000)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the Intraclass correlation mean 
local suffix "ptmEndCtrolCI2IntrCorr"
power twomeans 0.038 0.07, sd(0.196) n1(13668) n2(14096) k1(104) k2(109) rho(0.31)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


 * proportion power 
* Power for the Intraclass correlation mean 
local suffix "ptpEndCtrolAvIntrCorr"
power twoprop 0.038 0.07, n1(13668) n2(14096) k1(104) k2(109) rho(0.158)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the lower CI of the Intraclass correlation  
local suffix "ptpEndCtrolCI1IntrCorr"
power twoprop 0.038 0.07, n1(13668) n2(14096) k1(104) k2(109) rho(0.000)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the Intraclass correlation mean 
local suffix "ptpEndCtrolCI2IntrCorr"
power twoprop 0.038 0.07, n1(13668) n2(14096) k1(104) k2(109) rho(0.31)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


gen id = 1
keep id M1* M2* power* alpha* sd* N1* N2* K1* K2* rho* 
duplicates drop 

tempfile EndCtrolControl
save `EndCtrolControl'

*/


*###############################################################################
*###############################################################################


*###############################################################################
*############# Using Alalysis data Central Dummy as Control ###################
*###############################################################################

use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear

* Define FE
sum today_alt
local tdm_min = `r(min)'
local tdm_max = `r(max)'+1

egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes


eststo clear
label var t_l "Local"


* Display the label of the variable of taxes payment at the baseline 
describe taxes_paid 
/*
Variable      Storage   Display    Value
    name         type    format    label      Variable label
--------------------------------------------------------------------------------------
paid_self       byte    %19.0g     yes_no_dk
                                              To date, has your household paid the
                                                property tax in 2018?
*/


* Double check if the properties are duplicated 
duplicates report compound1
/*
--------------------------------------
   Copies | Observations       Surplus
----------+---------------------------
        1 |        45177             0
--------------------------------------
*/


* Counting 
count 
/*
45177
*/

* Counting the number of unique neighborhoods 
egen tag_a7 = tag(a7)
tab tmt tag_a7
/*

                     |        tag(a7)
   (first) treatment |         0          1 |     Total
---------------------+----------------------+----------
             Control |       792          5 |       797 
             Central |    14,379        110 |    14,489 
               Local |    14,272        111 |    14,383 
Central + Chief Info |     9,342         80 |     9,422 
     Central X Local |     6,021         50 |     6,071 
---------------------+----------------------+----------
               Total |    44,806        356 |    45,162 
*/


* Check the frequencies in the treatments arms in general 
tab tmt
/*
   (first) treatment |      Freq.     Percent        Cum.
---------------------+-----------------------------------
             Control |        797        1.76        1.76
             Central |     14,489       32.08       33.85
               Local |     14,383       31.85       65.69
Central + Chief Info |      9,422       20.86       86.56
     Central X Local |      6,071       13.44      100.00
---------------------+-----------------------------------
               Total |     45,162      100.00
*/


* Double checking the obs and clusters in the preferred specification
reg taxes_paid i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)

* Getting the number of obs in Central and Local in the preferred regression.
tab tmt if e(sample)
/*
   (first) treatment |      Freq.     Percent        Cum.
---------------------+-----------------------------------
             Central |     13,668       49.23       49.23
               Local |     14,096       50.77      100.00
---------------------+-----------------------------------
               Total |     27,764      100.00
*/

* Getting the number of neighborhoods in Central and Local in the preferred regression.
tab tmt tag_a7 if e(sample)
/*
                     |        tag(a7)
   (first) treatment |         0          1 |     Total
---------------------+----------------------+----------
             Central |    13,564        104 |    13,668 
               Local |    13,987        109 |    14,096 
---------------------+----------------------+----------
               Total |    27,551        213 |    27,764 
*/

* Summarize the paid_self variable to get its mean and SD
sum taxes_paid if inlist(tmt,1) & e(sample)
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
  taxes_paid |     13,668    .0634328    .2437488          0          1
*/

* Getting the intra-cluster correlation 
loneway taxes_paid a7 if inlist(tmt,1) 
/*
                 One-way analysis of variance for taxes_paid: 

                                             Number of obs =       14,489
                                                 R-squared =       0.0673

    Source                SS         df      MS            F     Prob > F
-------------------------------------------------------------------------
Between a7             61.994797    109    .56875961      9.52     0.0000
Within a7              858.63382 14,379    .05971443
-------------------------------------------------------------------------
Total                  920.62861 14,488    .06354422

         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.06091     0.00945       0.04239     0.07942

         Estimated SD of a7 effect               .0622322
         Estimated SD within a7                  .2443654
         Est. reliability of a a7 mean            0.89501
              (evaluated at n=131.44)
*/


	* twomeans power 
* Power for the Intraclass correlation mean 
local suffix "ptmAnalDCtralAvIntrCorr"
power twomeans 0.063 0.095, sd(0.244) n1(13564) n2(13987) k1(104) k2(109) rho(0.061) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the lower CI of the Intraclass correlation  
local suffix "ptmAnalDCtralCI1IntrCorr"
power twomeans 0.063 0.095, sd(0.244) n1(13564) n2(13987) k1(104) k2(109) rho(0.042) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the Intraclass correlation mean 
local suffix "ptmAnalDCtralCI2IntrCorr"
power twomeans 0.063 0.095, sd(0.244) n1(13564) n2(13987) k1(104) k2(109) rho(0.079) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


 * proportion power 
* Power for the Intraclass correlation mean 
local suffix "ptpAnalDCtralAvIntrCorr"
power twoprop 0.063 0.095, n1(13564) n2(13987) k1(104) k2(109) rho(0.061) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the lower CI of the Intraclass correlation  
local suffix "ptpAnalDCtralCI1IntrCorr"
power twoprop 0.063 0.095, n1(13564) n2(13987) k1(104) k2(109) rho(0.042) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the Intraclass correlation mean 
local suffix "ptpAnalDCtralCI2IntrCorr"
power twoprop 0.063 0.095, n1(13564) n2(13987) k1(104) k2(109) rho(0.079) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


gen id = 1
keep id M1* M2* power* alpha* sd* N1* N2* K1* K2* rho* 
duplicates drop 

tempfile AnalDCtralControl
save `AnalDCtralControl'

*###############################################################################
*###############################################################################


*###############################################################################
*############# Using Alalysis data Control Dummy as Control ###################
*###############################################################################

use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear

* Define FE
sum today_alt
local tdm_min = `r(min)'
local tdm_max = `r(max)'+1

egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes


eststo clear
label var t_l "Local"


* Counting the number of unique neighborhoods 
egen tag_a7 = tag(a7)
tab tmt tag_a7
/*
                     |        tag(a7)
   (first) treatment |         0          1 |     Total
---------------------+----------------------+----------
             Control |       792          5 |       797 
             Central |    14,379        110 |    14,489 
               Local |    14,272        111 |    14,383 
Central + Chief Info |     9,342         80 |     9,422 
     Central X Local |     6,021         50 |     6,071 
---------------------+----------------------+----------
               Total |    44,806        356 |    45,162 
*/


* Check the frequencies in the treatments arms in general 
tab tmt
/*
   (first) treatment |      Freq.     Percent        Cum.
---------------------+-----------------------------------
             Control |        797        1.76        1.76
             Central |     14,489       32.08       33.85
               Local |     14,383       31.85       65.69
Central + Chief Info |      9,422       20.86       86.56
     Central X Local |      6,071       13.44      100.00
---------------------+-----------------------------------
               Total |     45,162      100.00
*/

* Summarize the paid_self variable to get its mean and SD
sum taxes_paid if inlist(tmt,0)
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
  taxes_paid |        797    .0012547    .0354218          0          1
*/

* Getting the intra-cluster correlation 
loneway taxes_paid a7 if inlist(tmt,0)
/*
                 One-way analysis of variance for taxes_paid: 

                                             Number of obs =          797
                                                 R-squared =       0.0034

    Source                SS         df      MS            F     Prob > F
-------------------------------------------------------------------------
Between a7             .00344013      4    .00086003      0.68     0.6029
Within a7              .99530516    792     .0012567
-------------------------------------------------------------------------
Total                  .99874529    796    .00125471

         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.00000*    0.00453       0.00000     0.00888

         Estimated SD of a7 effect                      .
         Estimated SD within a7                  .0354499
         Est. reliability of a a7 mean            0.00000*
              (evaluated at n=156.45)
*/


	* twomeans power 
* Power for the Intraclass correlation mean 
local suffix "ptmAnalDCtrolAvIntrCorr"
power twomeans 0.0013 0.033, sd(0.035) n1(797) n2(14383) k1(5) k2(111) rho(0) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the lower CI of the Intraclass correlation  
local suffix "ptmAnalDCtrolCI1IntrCorr"
power twomeans 0.0013 0.033, sd(0.035) n1(797) n2(14383) k1(5) k2(111) rho(0) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the Intraclass correlation mean 
local suffix "ptmAnalDCtrolCI2IntrCorr"
power twomeans 0.0013 0.033, sd(0.035) n1(797) n2(14383) k1(5) k2(111) rho(0.009) alpha(0.1)
gen M1`suffix' = `r(m1)' 
gen M2`suffix' = `r(m2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = `r(sd)'
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


 * proportion power 
* Power for the Intraclass correlation mean 
local suffix "ptpAnalDCtrolAvIntrCorr"
power twoprop 0.0013 0.033, n1(797) n2(14383) k1(5) k2(111) rho(0) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the lower CI of the Intraclass correlation  
local suffix "ptpAnalDCtrolCI1IntrCorr"
power twoprop 0.0013 0.033, n1(797) n2(14383) k1(5) k2(111) rho(0) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


* Power for the Intraclass correlation mean 
local suffix "ptpAnalDCtrolCI2IntrCorr"
power twoprop 0.0013 0.033, n1(797) n2(14383) k1(5) k2(111) rho(0.009) alpha(0.1)
gen M1`suffix' = `r(p1)' 
gen M2`suffix' = `r(p2)'
gen power`suffix' = `r(power)' 
gen alpha`suffix' = `r(alpha)'
gen sd`suffix' = .
gen N1`suffix' = `r(N1)'
gen N2`suffix' = `r(N2)'
gen K1`suffix' = `r(K1)'
gen K2`suffix' = `r(K2)'
gen rho`suffix' = `r(rho)'


gen id = 1
keep id M1* M2* power* alpha* sd* N1* N2* K1* K2* rho* 
duplicates drop 

tempfile AnalDCtrolControl
save `AnalDCtrolControl'

*###############################################################################
*###############################################################################

* Merging 

use `BaseAllControl', clear 
merge 1:1 id using `AnalDCtralControl', nogenerate
merge 1:1 id using `AnalDCtrolControl', nogenerate


/*
merge 1:1 id using `MidCtralControl', nogenerate
merge 1:1 id using `EndCtralControl', nogenerate
merge 1:1 id using `EndCtrolControl', nogenerate
*/

reshape long M1 M2 power alpha sd N1 N2 K1 K2 rho , i(id) j(Model) string

*###############################################################################
*###############################################################################














































***********
* Table 4 *
* This table replicates Table 4 using randomized inference approach.
***********

use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear

	* keep if tmt==1 | tmt==2 | tmt==3 // Commented by Sossou
	
	* Define FE
	sum today_alt
	local tdm_min = `r(min)'
	local tdm_max = `r(max)'+1
	
	egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes
	
	
	eststo clear
	label var t_l "Local"
	
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
	Power Calculation with Paul 
*/

	* taxes_paid variable
* 1-) Getting the intra-cluster correlation ---> How correlated observations within a cluter are to each other
loneway taxes_paid a7 if inlist(tmt,1) /* Intraclass correlation -->  0.06091 ; CI ---> [0.04239  0.07942] */

* 2-) Summarize the depend variable and its Mean and SD
sum taxes_paid if inlist(tmt,1) /* Stanrad deviation of the dependand variable --> .2520798*/

* 3-) Power calculation 
* Power calculation for the mean taxes_paid (continuous variable)
power twomeans 0.063 0.095, sd(0.252) n1(13668) n2(14096) k1(104) k2(109) rho(0.061) 

power twomeans ///
0.063 /* Central Mean --> Table 4 */ ///
0.095 /* Central mean + Local effect size: 0.063 + 0.032 */,  ///
sd(0.252) /* SD for Central --> sum taxes_paid if inlist(tmt,1) */ ///
n1(14489) /* number of properties in Central treatments arm */ ///
n2(14383) /* number of properties in Local treatments arm */ ///
k1(110) /* number of neighborhoods in the  Central treatment arm  */ ///
k2(111) /* number of neighborhoods in the Local treatment arm  */ ///
rho(0.042) /* intraclass correlation in Central --> loneway taxes_paid a7 if inlist(tmt,1) */

power twomeans 0.063 0.095, sd(0.252) n1(14489) n2(14383) k1(110) k2(111) rho(0.08)

power twomeans 0.063 0.095, sd(0.252) n1(1234) n2(1296) k1(104) k2(109) rho(0.061) alpha(0.1)
power twomeans 0.063 0.095, sd(0.252) n1(1234) n2(1296) k1(110) k2(111) rho(0.042)
power twomeans 0.063 0.095, sd(0.252) n1(1234) n2(1296) k1(110) k2(111) rho(0.08)

* Power calculation for the proportion taxes_paid
power twoprop 0.06 0.09, n1(14489) n2(14383) k1(110) k2(111) rho(0.061)
power twoprop 0.06 0.09, n1(14489) n2(14383) k1(110) k2(111) rho(0.042)
power twoprop 0.06 0.09, n1(14489) n2(14383) k1(110) k2(111) rho(0.08)

power twoprop 0.06 0.09, n1(1234) n2(1296) k1(110) k2(111) rho(0.061)
power twoprop 0.06 0.09, n1(1234) n2(1296) k1(110) k2(111) rho(0.042)
power twoprop 0.06 0.09, n1(1234) n2(1296) k1(110) k2(111) rho(0.08)



	* taxes_paid_amt variable
* Getting the intra-cluster correlation ---> How correlated observations within a cluter are to each other
loneway taxes_paid_amt a7 if inlist(tmt,1) /* Intraclass correlation -->  0.03843 ; CI ---> [0.02580   0.05106] */
* Summarize the depend variable 
sum taxes_paid_amt if inlist(tmt,1) /* Stanrad deviation of the dependand variable --> 942.2908  */

// 94 28 76 44
// 

* Restricted to the baseline 
* Use the baseline administrative data 

use "/Users/sossousimpliceadjisse/Documents/myfiles/PaulMoussaReplicationProject/147561-V1/Replication Materials/Data/01_base/admin_data/tax_payments_noPII.dta", clear

gen paid_dummy = (paid == 3)
replace paid_dummy = . if  paid != 1 &  paid != 3


	* taxes_paid variable
	
* Getting the intra-cluster correlation ---> How correlated observations within a cluter are to each other
loneway paid_dummy a7  /* Intraclass correlation -->  0.24195 ; CI ---> [ 0.18568   0.29822] */

* Summarize the depend variable 
sum paid_dummy  /* SD --> 0.2242545 ; Mean = 0.0530853 */



gen paid_dum2 = paid_dummy*amountCF

	* taxes_paid variable
* Getting the intra-cluster correlation ---> How correlated observations within a cluter are to each other
loneway paid_dum2 a7  /* Intraclass correlation -->  0.17585 ; CI ---> [0.12733   0.22438] */
* Summarize the depend variable 
sum paid_dum2 /* ---> SD = 662.3523 ; Mean = 129.1231 */

	* Power calculation for the mean paid_dummy (continuous variable)
power twomeans 0.0530853 0.0796, sd(0.2242545) n1(13668) n2(14096) k1(104) k2(109) rho(0.242) alpha(0.1)
power twomeans 0.0530853 0.0796, sd(0.2242545) n1(13668) n2(14096) k1(104) k2(109) rho(0.18568) alpha(0.1)
power twomeans 0.0530853 0.0796, sd(0.2242545) n1(13668) n2(14096) k1(104) k2(109) rho(0.29822) alpha(0.1)

power twomeans 0.0530853 0.0796, sd(0.2242545) n1(1234) n2(1296) k1(104) k2(109) rho(0.242) alpha(0.1)
power twomeans 0.0530853 0.0796, sd(0.2242545) n1(1234) n2(1296) k1(104) k2(109) rho(0.18568) alpha(0.1)
power twomeans 0.0530853 0.0796, sd(0.2242545) n1(1234) n2(1296) k1(104) k2(109) rho(0.29822) alpha(0.1)



	* Power calculation for the proportion paid_dummy
power twoprop 0.0530853 0.0796,  n1(13668) n2(14096) k1(104) k2(109) rho(0.242) alpha(0.1)
power twoprop 0.0530853 0.0796,  n1(13668) n2(14096) k1(104) k2(109) rho(0.18568) alpha(0.1)
power twoprop 0.0530853 0.0796,  n1(13668) n2(14096) k1(104) k2(109) rho(0.29822) alpha(0.1)

power twoprop 0.0530853 0.0796,  n1(1234) n2(1296) k1(104) k2(109) rho(0.242) alpha(0.1)
power twoprop 0.0530853 0.0796,  n1(1234) n2(1296) k1(104) k2(109) rho(0.18568) alpha(0.1)
power twoprop 0.0530853 0.0796,  n1(1234) n2(1296) k1(104) k2(109) rho(0.29822) alpha(0.1)


	* Power calculation for the mean paid_dum2 (continuous variable)
power twomeans 129.1231 186, sd(662.3523) n1(13668) n2(14096) k1(104) k2(109) rho(0.17585) alpha(0.1)
power twomeans 129.1231 186, sd(662.3523) n1(13668) n2(14096) k1(104) k2(109) rho(0.12733) alpha(0.1)
power twomeans 129.1231 186, sd(662.3523) n1(13668) n2(14096) k1(104) k2(109) rho(0.22438) alpha(0.1)

power twomeans 129.1231 186, sd(662.3523) n1(1234) n2(1296) k1(104) k2(109) rho(0.17585) alpha(0.1)
power twomeans 129.1231 186, sd(662.3523) n1(1234) n2(1296) k1(104) k2(109) rho(0.12733) alpha(0.1)
power twomeans 129.1231 186, sd(662.3523) n1(1234) n2(1296) k1(104) k2(109) rho(0.22438) alpha(0.1)






	* taxes_paid_amt variable
* Getting the intra-cluster correlation ---> How correlated observations within a cluter are to each other
loneway taxes_paid_amt a7 if inlist(tmt,1) /* Intraclass correlation -->  0.03843 ; CI ---> [0.02580   0.05106] */
* Summarize the depend variable 
sum taxes_paid_amt if inlist(tmt,1) /* Stanrad deviation of the dependand variable --> 942.2908 */


	* Overall number of neighborhood
* Number of neighborhood for central ---> 110 ; Local ---> 111
* Number of properties for central ---> 14489 ; Local ---> 14383

	* Number of neighborhood and properties restricted to the baseline 
* Number of neighborhood for central ---> 110 ; Local ---> 111
* Number of properties for central ---> 1234 ; Local ---> 1296 /* Get this from Firts part of Table4R4.do*/

	* Number of neighborhood and properties restricted to the baseline (preferred specification)
* Number of neighborhood for central ---> 104 ; Local ---> 109
* Number of properties for central ---> 13668 ; Local ---> 14096 /* Get this from the regression */

	* Number of neighborhood and properties restricted to the baseline (Restricted to the baseline)
* Number of neighborhood for central ---> 104 ; Local ---> 109
* Number of properties for central ---> 1167 ; Local ---> 1272 /* Get this from the regression */

* Detectin neighborhood in the 

reg taxes_paid_amt i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1) , cl(a7) 
reg taxes_paid_amt i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,2) , cl(a7) 

* Baseline regression to the baseline ----> Firt part of the 
reg taxes_paid i.tmt   i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1), cl(a7) 
reg taxes_paid i.tmt   i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,2), cl(a7)



*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


**************
* Compliance *
**************
// tmt = treatments : Control, Central, Local,  CLI, CXL ----> added by Sossou

	* Normal - Compliance - No house FE
	eststo r11: reg taxes_paid i.tmt i.stratum if inlist(tmt,1,2), cl(a7)  
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r11 
		estadd matrix pvalues = pvalues
		esttab r11, cells(b p(par) pvalues(par([ ])))
		su taxes_paid if t_c==1
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - No house FE
	eststo r21: reg taxes_paid i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p)
		mat colnames pvalues = 2.tmt
		est restore r21 
		estadd matrix pvalues = pvalues
		esttab r21, cells(b p(par) pvalues(par([ ])))
		su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - No house FE - Polygon Mean
	preserve
		drop if time_FE_tdm_2mo_CvL==.
		collapse (mean) taxes_paid (min) time_FE_tdm_2mo_CvL (max) t_l t_c stratum,by(a7 tmt)
		eststo r31: reg taxes_paid i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), robust
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
			matrix pvalues = r(p)
			mat colnames pvalues = 2.tmt
			est restore r31 
			estadd matrix pvalues = pvalues
			esttab r31, cells(b p(par) pvalues(par([ ])))
			su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
			estadd local Mean=abs(round(`r(mean)',.001))
			estadd scalar Observations = `e(N)'
			*estadd scalar Clusters = `e(N_clust)'
	restore

	* Month FE - Compliance - House FE
	eststo r41: reg taxes_paid i.tmt i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p)
		mat colnames pvalues = 2.tmt
		est restore r41 
		estadd matrix pvalues = pvalues
		esttab r41, cells(b p(par) pvalues(par([ ])))
		su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance - House FE - Condition Exempt
	eststo r51: reg taxes_paid i.tmt i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2) & exempt!=1, cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p)
		mat colnames pvalues = 2.tmt
		est restore r51 
		estadd matrix pvalues = pvalues
		esttab r51, cells(b p(par) pvalues(par([ ])))
		su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvL!=. & exempt!=1
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
* Latex Output
	esttab r11 r21 r31 r41 r51 using "${reploutdir}/main_compliance_results4R1.tex", ///
	replace label booktabs b(%9.3f) se(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "se(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") /// 
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance", pattern(1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress
	
* CSV  Output 
	esttab r11 r21 r31 r41 r51 using "${reploutdir}/main_compliance_results4R1.csv", ///
	replace label b(%9.3f) se(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "se(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") /// 
	scalar(Clusters Mean) sfmt(0 3 3) ///
	mtitles("Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance" "Tax Compliance") ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress



* END REPLICATION * 	
	
************
* Revenues *
************
	
	eststo clear
	label var t_l "Local"
	
	* Normal - Revenues - No house FE
	eststo r12: reg taxes_paid_amt i.tmt i.stratum if inlist(tmt,1,2), cl(a7)  
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r12 
		estadd matrix pvalues = pvalues
		esttab r12, cells(b p(par) pvalues(par([ ])))
		su taxes_paid_amt if t_c==1
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - No house FE
	eststo r22: reg taxes_paid_amt i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7) 
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r22
		estadd matrix pvalues = pvalues
		esttab r22, cells(b p(par) pvalues(par([ ])))
		su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - No house FE - Polygon Mean
	preserve
		drop if time_FE_tdm_2mo_CvL==.
		collapse (mean) taxes_paid_amt (min) time_FE_tdm_2mo_CvL (max) t_l t_c stratum,by(a7 tmt)
		eststo r32: reg taxes_paid_amt i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), robust 
		ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
			matrix pvalues = r(p) // save the p-values from ritest
			mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
			est restore r32 
			estadd matrix pvalues = pvalues
			esttab r32, cells(b p(par) pvalues(par([ ])))
			su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
			estadd local Mean=abs(round(`r(mean)',.001))
			estadd scalar Observations = `e(N)'
	* estadd scalar Clusters = `e(N_clust)'
	restore
	
	* Month FE - Revenues - House FE
	eststo r42: reg taxes_paid_amt i.tmt i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r42 
		estadd matrix pvalues = pvalues
		esttab r42, cells(b p(par) pvalues(par([ ])))
		su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=.
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues - House FE - Condition Exempt
	eststo r52: reg taxes_paid_amt i.tmt i.stratum i.house i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2) & exempt!=1, cl(a7) 
	ritest tmt _b[2.tmt], reps(1000) seed(125) cluster(a7) strata(stratum): `e(cmdline)'
		matrix pvalues = r(p) // save the p-values from ritest
		mat colnames pvalues = 2.tmt  // name p-values so that esttab knows to which coefficient they belong
		est restore r52 
		estadd matrix pvalues = pvalues
		esttab r52, cells(b p(par) pvalues(par([ ])))
		su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvL!=. & exempt!=1
		estadd local Mean=abs(round(`r(mean)',.001))
		estadd scalar Observations = `e(N)'
		estadd scalar Clusters = `e(N_clust)'
		
* Latex Output
	esttab r12 r22 r32 r42 r52 using "${reploutdir}/main_revenues_results4R1.tex", ///
	replace label booktabs b(%9.3f) se(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "se(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	nomtitles ///
	mgroups("Revenues" "Revenues" "Revenues" "Revenues" "Revenues", pattern(1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

 * CSV Output
	esttab r12 r22 r32 r42 r52 using "${reploutdir}/main_revenues_results4R1.csv", ///
	replace label b(%9.3f) se(%9.3f) ///
	keep (2.tmt) ///
	order(2.tmt) /// 
	cells("b(fmt(a3))"  "se(fmt(a3) par)" "pvalues(fmt(%9.3f) par([ ]))") ///
	scalar(Clusters Mean) sfmt(0 3 3) ///
	mtitles("Revenues" "Revenues" "Revenues" "Revenues" "Revenues") ///
	indicate("Month FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

