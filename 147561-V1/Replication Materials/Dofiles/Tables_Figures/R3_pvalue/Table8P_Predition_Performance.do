********************************
* Table Prediction Performance *
********************************

* Merging Prediction datasets
use "${repldir}/Data/03_clean_combined/predictions_FromTable8R1.dta", clear /* Table 8 */
* use "${repldir}/Data/03_clean_combined/predictions_FromTable8R2.dta", clear 

merge 1:1 compound_code using "${repldir}/Data/03_clean_combined/predictions_FromTable8R3i.dta"
keep if _merge == 3
drop _merge

/*
merge 1:1 compound_code using "${repldir}/Data/03_clean_combined/predictions_FromTable8R2_top5.dta"
keep if _merge == 3
drop _merge
*/

merge 1:1 compound_code using "${repldir}/Data/03_clean_combined/predictions_FromTable8R3ii.dta"
keep if _merge == 3
drop _merge


/*
rename p_linear_cc_pay_ease p_l_cc_pay_ease
rename p_linear_cc_willingness p_l_cc_willingness
*/


//order compound_code pay_ease p_reg_pay_ease p_linear_cc_pay_ease p_oprob_pay_ease p_oprob_cc_pay_ease

				* Against the true Value

* Against the True Pay Ease
foreach varac in p_reg_pay_ease /* p_l_cc_pay_ease */  p_oprob_pay_ease  p_oprob_cc_pay_ease{
	keep if  pay_ease >= 0 & pay_ease <= 2 & `varac' != .
	
	* Accuracy 
	egen `varac'_dum = total(`varac' == pay_ease)
	egen `varac'_N = total(pay_ease != . & `varac' != .)
	gen Accuracy`varac' = 100*(`varac'_dum/`varac'_N)
	
	* MSE
	gen y1`varac' = pay_ease - `varac'
	gen y2`varac' = y1`varac'^2
	egen y3`varac' = total(y2`varac')
	gen MSE`varac' = (1/`varac'_N)*y3`varac'
	
	* MAE
	gen y4`varac'  = abs(y1`varac')
	egen y5`varac' = total(y4`varac')
	gen MAE`varac' = (1/`varac'_N)*y5`varac'
	
	drop `varac'_dum `varac'_N y1`varac' y2`varac' y3`varac' y4`varac' y5`varac'
}

* Against the true Willingness
foreach varac in p_reg_willingness /* p_l_cc_willingness */ p_oprob_willingness p_oprob_cc_willingness{
	keep if  willingness >= 0 & willingness <= 2 & `varac' != .
	
	* Accuracy 
	egen `varac'_dum = total(`varac' == willingness)
	gen `varac'_N = _N
	gen Accuracy`varac' = 100*(`varac'_dum/`varac'_N)
	
	* MSE
	gen y1`varac' = willingness - `varac'
	gen y2`varac' = y1`varac'^2
	egen y3`varac' = total(y2`varac')
	gen MSE`varac' = (1/`varac'_N)*y3`varac'
	
	* MAE
	gen y4`varac'  = abs(y1`varac')
	egen y5`varac' = total(y4`varac')
	gen MAE`varac' = (1/`varac'_N)*y5`varac'
	
	drop `varac'_dum `varac'_N y1`varac' y2`varac' y3`varac' y4`varac' y5`varac'
}



* Against the Original Prediction 

* Against the original prediction of Pay Ease
foreach varac in  /* p_l_cc_pay_ease */ p_oprob_pay_ease p_oprob_cc_pay_ease{
	keep if  p_reg_pay_ease >= 0 & p_reg_pay_ease <= 2 & `varac' != .
	
	* Accuracy 
	egen `varac'_dum = total(`varac' == p_reg_pay_ease)
	egen `varac'_N = total(p_reg_pay_ease != . & `varac' != .)
	gen Accuracy`varac'ag = 100*(`varac'_dum/`varac'_N)
	
	* MSE
	gen y1`varac' = p_reg_pay_ease - `varac'
	gen y2`varac' = y1`varac'^2
	egen y3`varac' = total(y2`varac')
	gen MSE`varac'ag = (1/`varac'_N)*y3`varac'
	
	* MAE
	gen y4`varac'  = abs(y1`varac')
	egen y5`varac' = total(y4`varac')
	gen MAE`varac'ag = (1/`varac'_N)*y5`varac'
	
	drop `varac'_dum `varac'_N y1`varac' y2`varac' y3`varac' y4`varac' y5`varac'
}

* Willingness
foreach varac in  /* p_l_cc_willingness */ p_oprob_willingness p_oprob_cc_willingness{
	keep if  p_reg_willingness >= 0 & p_reg_willingness <= 2 & `varac' != .
	
	* Accuracy 
	egen `varac'_dum = total(`varac' == p_reg_willingness)
	gen `varac'_N = _N
	gen Accuracy`varac'ag = 100*(`varac'_dum/`varac'_N)
	
	* MSE
	gen y1`varac' = p_reg_willingness - `varac'
	gen y2`varac' = y1`varac'^2
	egen y3`varac' = total(y2`varac')
	gen MSE`varac'ag = (1/`varac'_N)*y3`varac'
	
	* MAE
	gen y4`varac'  = abs(y1`varac')
	egen y5`varac' = total(y4`varac')
	gen MAE`varac'ag = (1/`varac'_N)*y5`varac'
	
	drop `varac'_dum `varac'_N y1`varac' y2`varac' y3`varac' y4`varac' y5`varac'
}

keep Accuracy* MSE* MAE* 
duplicates drop


gen id = 1
reshape long Accuracy MSE MAE , i(id) j(Model) string
 

replace Model = "PayEase-Table8" if Model == "p_reg_pay_ease"
replace Model = "PayEase-Table8R3i" if Model == "p_oprob_pay_ease"
// replace Model = "PE-OP" if Model == "p_oprob_pay_ease"
replace Model = "PayEase-Table8R3ii" if Model == "p_oprob_cc_pay_ease"

replace Model = "PayEase: Table8R3i vs Table8" if Model == "p_oprob_pay_easeag"
// replace Model = "PE-OP vs PE-LR" if Model == "p_oprob_pay_easeag"
replace Model = "PayEase: Table8R3ii vs Table8" if Model == "p_oprob_cc_pay_easeag"


replace Model = "Willingness-Table8" if Model == "p_reg_willingness"
replace Model = "Willingness-Table8R3i" if Model == "p_oprob_willingness"
//replace Model = "W-OP" if Model == "p_oprob_willingness"
replace Model = "Willingness-Table8R3ii" if Model == "p_oprob_cc_willingness"

replace Model = "Willingness: Table8R3i vs Table8" if Model == "p_oprob_willingnessag"
//replace Model = "W-OP vs W-LR" if Model == "p_oprob_willingnessag"
replace Model = "Willingness: Table8R3ii vs Table8" if Model == "p_oprob_cc_willingnessag"

replace id = 1 if Model == "PayEase-Table8"
replace id = 2 if Model == "PayEase-Table8R3i"
// replace id = 3 if Model == "PE-OP"
replace id = 3 if Model == "PayEase-Table8R3ii"

replace id = 4 if Model == "Willingness-Table8"
replace id = 5 if Model == "Willingness-Table8R3i"
// replace id = 7 if Model == "W-OP"
replace id = 6 if Model == "Willingness-Table8R3ii"


replace id = 7 if Model == "PayEase: Table8R3i vs Table8"
// replace id = 10 if Model == "PE-OP vs PE-LR"
replace id = 8 if Model == "PayEase: Table8R3ii vs Table8"

replace id = 9 if Model == "Willingness: Table8R3i vs Table8"
// replace id = 13 if Model == "W-OP vs W-LR"
replace id = 10 if Model == "Willingness: Table8R3ii vs Table8"


sort id 
// replace Model = subinstr(Model, " ", "", .)

replace Model = string(0)+string(id)+Model if id < 10
replace Model = string(id)+Model if id >= 10

rename id No

//&&&&&&&&&&&&&&&&&&&&&&&


mat define T1 = J(10,4,.)
local count1 = 1
foreach vars in No Accuracy MSE MAE{
forvalues r1 = 1(1)10{
	mat T1[`r1',`count1'] = `vars'[`r1']
}
local  count1 = `count1' + 1
}


* Output
* This Table is manually re-arranged and named PredictPerformance_m.tex in the output folder

levelsof Model 
cap ssc install outtable
mat colnames T1 = No Accuracy MSE MAE 
mat rownames T1 = `r(levels)' 
outtable using "${reploutdir}/PredictPerformance",mat(T1) replace  
