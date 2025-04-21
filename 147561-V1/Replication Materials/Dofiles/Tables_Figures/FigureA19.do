
********************************************************************************
*************** How much Information do Central Collectors Have? ***************
********************************************************************************

forvalue i=1(1)15{
u "${repldir}/Data/01_base/survey_data/collector_knowledge_clean.dta",clear
keep a7 code photo`i' person`i'_know person`i'_showname /*person`i'_name*/  person`i'_realname person`i'_job person`i'_edu
rename code colcode
replace photo`i'=subinstr(photo`i',"."," ",.)
rename photo`i' photo
rename (person`i'_know person`i'_showname /*person`i'_name*/  person`i'_realname person`i'_job person`i'_edu) (person_know person_showname /*person_name*/  person_realname person_job person_edu)
split photo
drop photo photo2
rename photo1 photo
destring photo, replace force
gen photo_num=`i'

tempfile obs_`i'
save `obs_`i''
}
use `obs_1', clear
forvalue i=1(1)15{
append using `obs_`i'', force
}
duplicates drop
rename photo code
tempfile photos_all
save `photos_all'

* Baseline survey
u "${repldir}/Data/01_base/survey_data/baseline_noPII.dta",clear
keep if tot_complete==1 
keep code /*name_survey1*/ edu job1 
tempfile baseline
save `baseline'

* merge
use `photos_all', clear
drop if code==. | colcode==. | a7==.
merge m:1 code using `baseline'
drop photo_num _merge


* Knows Name
gen name_knows= person_realname
replace name_knows=0 if person_know==0

* knows Education
replace edu=. if edu==888
gen edu_knows=0 if edu!=. 
replace edu_knows=1 if edu==person_edu

* Knows job
gen job_knows=0 if job1!=. 
replace job_knows=1 if job1==person_job

* Generate knowledge index
	global C_knows = "name_knows edu_knows job_knows"
		
		foreach index in C_knows{ 
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

		foreach var in C_knows{
		sum `var', d
		g `var'_norm = (`var'-`r(min)')/(`r(max)'-`r(min)') //normalize variables
		}

	tempfile central_info
	save `central_info'

********************************************************************************
****************** How much Information do City Chiefs have? *******************
********************************************************************************

* Chief's Information about citizens
use "${repldir}/Data/01_base/survey_data/chief_knowledge.dta", clear
keep a7 person*
forvalue i=1(1)15{
rename person`i'_need person_need`i'
rename person`i'_edu person_edu`i'
rename person`i'_job person_job`i'
rename person`i'_realname person_realname`i'
*rename person`i'_name person_name`i'
rename person`i'_showname person_showname`i'
rename person`i'_know person_know`i'
}
reshape long person_need person_edu person_job person_realname /*person_name*/ person_showname person_know, i(a7) j(photo_num)
tempfile chief_goods
save `chief_goods'

* Info on respondents 
forvalue i=1(1)15{
insheet using "${repldir}/Data/01_base/survey_data/resident_info_quiz.csv", clear
keep a7 photo`i'
replace photo`i'=subinstr(photo`i',"."," ",.)
rename photo`i' photo
split photo
drop photo photo2
rename photo1 photo
destring photo, replace force
gen photo_num=`i'
tempfile obs_`i'
save `obs_`i''
}
use `obs_1', clear
forvalue i=1(1)15{
append using `obs_`i''
}
duplicates drop
rename photo code
tempfile photos_all
save `photos_all'

* Baseline survey
u "${repldir}/Data/01_base/survey_data/baseline_noPII.dta",clear
keep if tot_complete==1 
keep code /*name_survey1*/ edu job1 
tempfile baseline
save `baseline'

* merge
use `photos_all', clear
merge 1:1 a7 photo_num using `chief_goods', nogen
drop if code==. 
merge 1:1 code using `baseline'
drop photo_num _merge


* Knows Name
gen name_knows= person_realname
replace name_knows=0 if person_know==0

* knows Education
replace edu=. if edu==888
gen edu_knows=0 if edu!=. 
replace edu_knows=1 if edu==person_edu

* Knows job
gen job_knows=0 if job1!=. 
replace job_knows=1 if job1==person_job

* Generate knowledge index
	global L_knows = "name_knows edu_knows job_knows"
		
		foreach index in L_knows{ 
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
 
		foreach var in L_knows{
		sum `var', d
		g `var'_norm = (`var'-`r(min)')/(`r(max)'-`r(min)') //normalize variables
		}


********************************************************************************
******************* Central Vs Local Information - Comparison ******************
********************************************************************************

use `central_info',clear
drop if colcode==.
rename (name_knows edu_knows job_knows) (C_name_knows C_edu_knows C_job_knows)
merge m:1 code using "${repldir}/Data/01_base/survey_data/chief_info.dta"
rename (name_knows edu_knows job_knows) (L_name_knows L_edu_knows L_job_knows)
keep if _merge==3
collapse (mean) C_name_knows C_edu_know C_job_knows C_knows C_knows_norm L_name_know L_edu_know L_job_knows L_knows  L_knows_norm, by(a7) 

merge 1:1 a7 using "${repldir}/Data/01_base/admin_data/campaign_collector_info.dta"
keep if _m == 3 

twoway ( kdensity  C_knows_norm) ( kdensity  L_knows_norm if (Tmt!=2 & Tmt!=4))  , ///
graphregion(fcolor(white)) plotregion(color(white)) ///
xtitle("% Knowledge Index (Normalized)") ytitle("Density") legend(label(1 "Central Collectors") label(2 "Non-Collector Chiefs") ring(0) position(1) region(lstyle(none)))
graph export "$reploutdir/KnowsIndex_C_vs_L_NonCollectorChiefs.pdf", replace

