***********
* Table 7 *
***********


	* use "${repldir}/Data/01_base/survey_data/baseline_noPII.dta", clear
	
	
* Using baseline data and part of the code from the Table3.do file. 

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

	
	//keep if tmt==1 | tmt==2 | tmt==3
	* keep if baseline == 1
	
	cap drop visit_post_carto
	gen visit_post_carto=0 if visited==0 | (visits!=0 & visits!=.)
	replace visit_post_carto=1 if visits!=. & visits>1
	
	cap drop nb_visit_post_carto
	gen nb_visit_post_carto=0 if visits!=. | visited==0
	replace nb_visit_post_carto=visits-1 if visits!=. & visits>1
	replace nb_visit_post_carto=. if nb_visit_post_carto==99998
	replace nb_visit_post_carto = . if visit_post_carto==.

	egen time_FE_tdm_2mo_CvCLI = cut(today_alt),at(21365.5 21425.5 21485.5 21519) icodes
	egen time_FE_tdm_2mo_LvCLI = cut(today_alt),at(21370.5 21430.5 21490.5 21522) icodes
	egen time_FE_tdm_2mo_CvLvCLI = cut(today_alt),at(21363.6 21423.6 21483.6 21524.3) icodes
	
	eststo clear
	// label var t_cli "Central Plus Local Info"
	
	* Month FE - Compliance
	eststo r1: reg taxes_paid i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3) & trust_chief != ., cl(a7)
		ritest tmt _b[3.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 3.tmt  
		est restore r1 
		estadd matrix pvalues = pvalues
		esttab r1, cells(b p(par) pvalues(par([ ])))
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Revenues
	eststo r2: reg taxes_paid_amt i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3) & trust_chief != ., cl(a7)
		ritest tmt _b[3.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 3.tmt  
		est restore r2 
		estadd matrix pvalues = pvalues
		esttab r2, cells(b p(par) pvalues(par([ ])))
	su taxes_paid_amt if t_c==1 & time_FE_tdm_2mo_CvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Visited
	eststo r3: reg visit_post_carto i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3) & trust_chief != ., cl(a7)
		ritest tmt _b[3.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 3.tmt  
		est restore r3 
		estadd matrix pvalues = pvalues
		esttab r3, cells(b p(par) pvalues(par([ ])))
	su visit_post_carto if t_c==1 & time_FE_tdm_2mo_CvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Visits
	eststo r4: reg nb_visit_post_carto i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3) & trust_chief != ., cl(a7)
		ritest tmt _b[3.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 3.tmt  
		est restore r4
		estadd matrix pvalues = pvalues
		esttab r4, cells(b p(par) pvalues(par([ ])))
	su nb_visit_post_carto if t_c==1 & time_FE_tdm_2mo_CvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance Conditional on Visited
	eststo r5: reg taxes_paid i.tmt i.house i.stratum i.time_FE_tdm_2mo_CvCLI if inlist(tmt,1,3) & visit_post_carto==1 & trust_chief != ., cl(a7)
		ritest tmt _b[3.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 3.tmt  
		est restore r5 
		estadd matrix pvalues = pvalues
		esttab r5, cells(b p(par) pvalues(par([ ])))
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvCLI!=. & visit_post_carto==1
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	
	* Month FE - Compliance CvLvCLI
	eststo r6: reg taxes_paid i.tmt t_l i.house i.stratum i.time_FE_tdm_2mo_CvLvCLI if inlist(tmt,1,2,3) & trust_chief != ., cl(a7)
		ritest tmt _b[3.tmt], reps(1000) seed(125) cluster(a7) strata(stratum) nodots: `e(cmdline)'
		matrix pvalues = r(p) 
		mat colnames pvalues = 3.tmt  
		est restore r6 
		estadd matrix pvalues = pvalues
		esttab r6, cells(b p(par) pvalues(par([ ])))
	test 3.tmt = t_l
	local p_CLIvC = `r(p)'
	su taxes_paid if t_c==1 & time_FE_tdm_2mo_CvLvCLI!=.
	estadd local Mean=abs(round(`r(mean)',.001))
	estadd scalar Observations = `e(N)'
	estadd scalar Clusters = `e(N_clust)'
	estadd local CLIvC_p = `p_CLIvC'
	
	esttab r1 r2 r3 r4 r5 r6 using "${reploutdir}/main_centralwinfo_results7R4_pv.tex", ///
	replace label b(%9.3f) p(%9.3f) booktabs ///
	keep (3.tmt 2.tmt) ///
	order(3.tmt 2.tmt) ///
	cells("b(fmt(a6))"  "p(fmt(a3) par)" "pvalues(fmt(%9.6f) par([ ]))") ///
	scalar(Clusters Mean CLIvC_p) sfmt(0 3 3 3 3) ///
	nomtitles ///
	mgroups("Tax Compliance" "Tax Amount" "Visited" "Visits" "Compliance" "Compliance", pattern(1 1 1 1 1 1) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
	indicate("Time FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress
	
	 * CSV Format 
	esttab r1 r2 r3 r4 r5 r6 using "${reploutdir}/main_centralwinfo_results7R4_pv.csv", ///
	replace label b(%9.3f) p(%9.3f) ///
	keep (3.tmt 2.tmt) ///
	order(3.tmt 2.tmt) ///
	cells("b(fmt(a6))"  "p(fmt(a3) par)" "pvalues(fmt(%9.6f) par([ ]))") ///
	scalar(Clusters Mean CLIvC_p) sfmt(0 3 3 3 3) ///
	mtitles("Tax Compliance" "Tax Amount" "Visited" "Visits" "Compliance" "Compliance") ///
	indicate("Time FE = *2mo*""House FE = *house*""Stratum FE = *stratum*") ///
	star(* 0.10 ** 0.05 *** 0.001) ///
	nogaps nonotes compress

