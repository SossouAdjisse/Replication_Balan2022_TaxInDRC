********************************
* Table Prediction Performance *
********************************

* Merging Prediction datasets
use "${repldir}/Data/03_clean_combined/predictions_FromTable8R1.dta", clear

merge 1:1 compound_code using "${repldir}/Data/03_clean_combined/predictions_FromTable8R2.dta"
keep if _merge == 3
drop _merge

merge 1:1 compound_code using "${repldir}/Data/03_clean_combined/predictions_FromTable8R3.dta"
keep if _merge == 3
drop _merge

order compound_code pay_ease p_reg_pay_ease p_oprob_pay_ease p_oprob_cc_pay_ease


* Pay Ease
foreach varac in p_reg_pay_ease p_oprob_pay_ease p_oprob_cc_pay_ease{
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

* Willingness
foreach varac in p_reg_willingness p_oprob_willingness p_oprob_cc_willingness{
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

keep Accuracy* MSE* MAE* 
duplicates drop
order _all, alphabetic

gen id = 1
reshape long Accuracy MSE MAE , i(id) j(Model) string

replace Model = "Pay Ease - Simple Regression" if Model == "p_reg_pay_ease"
replace Model = "Pay Ease - Ordered Probit" if Model == "p_oprob_pay_ease"
replace Model = "Pay Ease - Ordered Probit + Cheifs Chars" if Model == "p_oprob_cc_pay_ease"

replace Model = "Willingness - Simple Regression" if Model == "p_reg_willingness"
replace Model = "Willingness - Ordered Probit" if Model == "p_oprob_willingness"
replace Model = "Willingness - Ordered Probit + Cheifs Chars" if Model == "p_oprob_cc_willingness"

replace id = 1 if Model == "Pay Ease - Simple Regression"
replace id = 2 if Model == "Pay Ease - Ordered Probit"
replace id = 3 if Model == "Pay Ease - Ordered Probit + Cheifs Chars"

replace id = 4 if Model == "Willingness - Simple Regression"
replace id = 5 if Model == "Willingness - Ordered Probit"
replace id = 6 if Model == "Willingness - Ordered Probit + Cheifs Chars"

sort id 
drop id 

//&&&&&&&&&&&&&&&&&&&&&&&


mat define T1 = J(6,3,.)
local count1 = 1
foreach vars in Accuracy MAE MSE{
forvalues r1 = 1(1)6{
	mat T1[`r1',`count1'] = `vars'[`r1']
}
local  count1 = `count1' + 1
}


* Output

cap ssc install outtable
//mat rownames T1 = registration visits baseline midline endline
mat colnames T1 = Accuracy MAE MSE
mat rownames T1 = PayEaseSimpleRegression PayEaseOProbit PayEaseOProbitChiefs ///
WillingnessSimpleRegression WillingnessOProbit WillingnessOProbitChiefs
outtable using "${reploutdir}/PredictPerformance",mat(T1) replace 

/*

		Pay Ease - Simple Regression (Original) & 49.776661 & .39363486 & .43160245 \\ \hline 
		Pay Ease - Ordered Probit & 50.223339 & .38302624 & .40871021 \\ \hline 
		Pay Ease - Ordered Probit + Chiefs Chars& 51.145893 & .37199554 & .39435437 \\ \hline 
		Willingness - Simple Regression (Original)  & 52.661663 & .50267953 & .56127191 \\ \hline 
		Willingness - Ordered Probit & 52.59021 & .50482315 & .56627369 \\ \hline 
		Willingness - Ordered Probit + Chiefs Chars & 54.983921 & .48338693 & .5498392 \\ \hline 

*/
