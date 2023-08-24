	
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$$ BASELINE DATA $$$$$$$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
		
use "${repldir}/Data/01_base/admin_data/tax_payments_noPII.dta", clear

recode paid (3 = 1 "Yes")(1 = 0 "No")(else = .), gen(paid_dummy)

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

	* Generating the revenues 
gen paid_amt = paid_dummy*amountCF

* Summarize the depend variable 
sum paid_amt 
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
    paid_amt |      2,201    129.1231    662.3523          0      13200
*/

* Getting the intra-cluster correlation
loneway paid_amt a7 
/*
                  One-way analysis of variance for paid_amt: 

                                             Number of obs =        2,200
                                                 R-squared =       0.2686

    Source                SS         df      MS            F     Prob > F
-------------------------------------------------------------------------
Between a7             2.592e+08    250    1036892.5      2.86     0.0000
Within a7              7.059e+08  1,949    362197.75
-------------------------------------------------------------------------
Total                  9.651e+08  2,199    438902.47

         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.17585     0.02476       0.12733     0.22438

         Estimated SD of a7 effect                    278
         Estimated SD within a7                  601.8287
         Est. reliability of a a7 mean            0.65069
              (evaluated at n=8.73)
*/



		
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$$ MAIN ANALYSIS DATA $$$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

		 
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

* Double checking the obs and clusters in the preferred specification
reg taxes_paid i.tmt i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2), cl(a7)

* Number of Obs and neighborhoods in Central and Local in the preferred regression.
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


	* REVENUES 
	
sum taxes_paid_amt if inlist(tmt,1) & e(sample)
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
taxes_paid~t |     13,668    182.2359    928.2958          0      13200
*/

* Getting the intra-cluster correlation 
loneway taxes_paid_amt a7 if inlist(tmt,1) 
/*
                One-way analysis of variance for taxes_paid~t: 

                                             Number of obs =       14,489
                                                 R-squared =       0.0453

    Source                SS         df      MS            F     Prob > F
-------------------------------------------------------------------------
Between a7             5.822e+08    109    5340837.6      6.25     0.0000
Within a7              1.228e+10 14,379    854156.51
-------------------------------------------------------------------------
Total                  1.286e+10 14,488    887911.91

         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.03843     0.00644       0.02580     0.05106

         Estimated SD of a7 effect               184.7566
         Estimated SD within a7                  924.2059
         Est. reliability of a a7 mean            0.84007
              (evaluated at n=131.44)
*/




* Summarize the paid_self variable to get its mean and SD
sum taxes_paid_amt if inlist(tmt,0) 
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
taxes_paid~t |        797    8.281054     233.784          0       6600
*/

* Getting the intra-cluster correlation 
loneway taxes_paid_amt a7 if inlist(tmt,0) 
/*
                One-way analysis of variance for taxes_paid~t: 

                                             Number of obs =          797
                                                 R-squared =       0.0034

    Source                SS         df      MS            F     Prob > F
-------------------------------------------------------------------------
Between a7             149852.09      4    37463.022      0.68     0.6029
Within a7               43355493    792    54741.784
-------------------------------------------------------------------------
Total                   43505345    796    54654.956

         Intraclass       Asy.        
         correlation      S.E.       [95% conf. interval]
         ------------------------------------------------
            0.00000*    0.00453       0.00000     0.00888

         Estimated SD of a7 effect                      .
         Estimated SD within a7                  233.9696
         Est. reliability of a a7 mean            0.00000*
              (evaluated at n=156.45)
*/



*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$$ GETTIN Ns and KS from Small SAmple  $$$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


	use "${repldir}/Data/01_base/survey_data/baseline_noPII.dta", clear
	keep if tot_complete==1 
	drop possessions

	* Education variables
	g edu_yrs = .
	replace edu_yrs = 0 if edu==0
	replace edu_yrs = 1 if edu==1
	replace edu_yrs = 6 if edu==2
	replace edu_yrs = 1+edu2 if edu2!=. & edu==2 & edu2<7 // not counting repeating grade
	replace edu_yrs = 13 if edu==3
	replace edu_yrs = 7+edu2 if edu2!=. & edu==3 & edu2<5 // not counting repeating grade
	replace edu_yrs = 17 if edu==4
	replace edu_yrs = 13+edu2 if edu2!=. & edu==4 // allow for higher values for masters/PhD
		
	* Normalized possessions
	global possessions = "possessions_1 possessions_2 possessions_3 possessions_4 possessions_5 possessions_6"
	foreach index in possessions{
	foreach var in $`index'{
	cap replace `var' = `var'_orig
	cap gen `var'_orig = `var'
	sum `var'
	replace `var' = (`var'-`r(mean)')/(`r(sd)') //standardize
	}
	egen `index' = rowtotal($`index'), missing
	sum `index'
	replace `index' = (`index' -`r(mean)')/(`r(sd)')  //standardize index
	}

	foreach var in possessions{
	sum `var', d
	g `var'_norm = (`var'-`r(min)')/(`r(max)'-`r(min)') //normalize variables
	}
	
	* Gender dummy
	gen male = sex
	replace male = 0 if male==2
	
	* log of income
	gen lg_inc_mo = log(inc_mo+1)
	
	* log of transport
	gen lg_transport = log(transport+1)
	
	* trust variables
	revrs trust8 trust4 trust5 trust6
	rename revtrust8 trust_chief
	rename revtrust4 trust_nat_gov
	rename revtrust5 trust_prov_gov
	rename revtrust6 trust_tax_min
	
	duplicates drop compound_code, force 		
	* tempfile 
	tempfile bl
	save `bl'

* Merging the main analysis data with the baseline data.
use "${repldir}/Data/03_clean_combined/analysis_data.dta", clear
rename compound1 compound_code
merge 1:1 compound_code using `bl', force 
keep if _merge > 2
drop _merge


// keep if tmt==1 | tmt==2 | tmt==3

* Define FE
sum today_alt
local tdm_min = `r(min)'
local tdm_max = `r(max)'+1

egen time_FE_tdm_2mo_CvL = cut(today_alt),at(21355 21415 21475 21532) icodes

	
	
eststo clear
label var t_l "Local"
label var t_c "Central"
label var trust_chief "Trust Chief"

egen tag_a7 = tag(a7)

reg taxes_paid t_l   i.stratum i.time_FE_tdm_2mo_CvL if inlist(tmt,1,2) & trust_chief != ., cl(a7)

tab tmt tag_a7 if e(sample)

/*
                     |        tag(a7)
   (first) treatment |         0          1 |     Total
---------------------+----------------------+----------
             Central |     1,063        104 |     1,167 
               Local |     1,163        109 |     1,272 
---------------------+----------------------+----------
               Total |     2,226        213 |     2,439 
*/


