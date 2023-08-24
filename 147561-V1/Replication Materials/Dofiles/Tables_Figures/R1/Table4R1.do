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
power twomeans 0.063 /* Central Mean --> Table 4 */ 0.095, ///
sd(0.252) /* SD for Central --> sum taxes_paid if inlist(tmt,1) */ ///
n1(14489) /* number of properties in Central treatments arm */ ///
n2(14383) /* number of properties in Local treatments arm */ ///
k1(110) /* number of neighborhoods in the  Central treatment arm  */ ///
k2(111) /* number of neighborhoods in the Local treatment arm  */ ///
rho(0.042) /* intraclass correlation --> loneway taxes_paid a7 if inlist(tmt,1) */

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

