
* COMPLIANCE 
	

*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$ Baseline Administrative - Compliance $$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

clear all 
set obs 1

local alps "5 10"
foreach i of local alps{
	
	local alp = 0.01*`i'
	
		* twomeans power 
		
	* Mean Big
	local suffix "ptmBaseAdminAvInCor`i'b"
	power twomeans 0.053 0.085, sd(0.224) n1(13668) n2(14096) k1(104) k2(109) rho(0.242) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptmBaseAdminAvInCor`i's"
	power twomeans 0.053 0.085, sd(0.224) n1(1167) n2(1272) k1(104) k2(109) rho(0.242) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptmBaseAdminCI1InCor`i'b"
	power twomeans 0.053 0.085, sd(0.224) n1(13668) n2(14096) k1(104) k2(109) rho(0.186) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptmBaseAdminCI1InCor`i's"
	power twomeans 0.053 0.085, sd(0.224) n1(1167) n2(1272) k1(104) k2(109) rho(0.186) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptmBaseAdminCI2InCor`i'b"
	power twomeans 0.053 0.085, sd(0.224) n1(13668) n2(14096) k1(104) k2(109) rho(0.298) alpha(`alp')
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

		* CI2 Small
	local suffix "ptmBaseAdminCI2InCor`i's"
	power twomeans 0.053 0.085, sd(0.224) n1(1167) n2(1272) k1(104) k2(109) rho(0.298) alpha(`alp')
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

	
		* twoprop power 
			
	* Mean Big
	local suffix "ptpBaseAdminAvInCor`i'b"
	power twoprop 0.053 0.085, n1(13668) n2(14096) k1(104) k2(109) rho(0.242) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptpBaseAdminAvInCor`i's"
	power twoprop 0.053 0.085, n1(1167) n2(1272) k1(104) k2(109) rho(0.242) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptpBaseAdminCI1InCor`i'b"
	power twoprop 0.053 0.085, n1(13668) n2(14096) k1(104) k2(109) rho(0.186) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptpBaseAdminCI1InCor`i's"
	power twoprop 0.053 0.085, n1(1167) n2(1272) k1(104) k2(109) rho(0.186) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptpBaseAdminCI2InCor`i'b"
	power twoprop 0.053 0.085, n1(13668) n2(14096) k1(104) k2(109) rho(0.298) alpha(`alp')
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

		* CI2 Small
	local suffix "ptpBaseAdminCI2InCor`i's"
	power twoprop 0.053 0.085, n1(1167) n2(1272) k1(104) k2(109) rho(0.298) alpha(`alp')
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
}

gen id = 1
keep id M1* M2* sd* N1* N2* K1* K2* rho*  alpha* power*
reshape long M1 M2 sd N1 N2 K1 K2 rho alpha power, i(id) j(Model) string
// gen outcomevar = "Compliance"

drop id 
gen No = _n
order No Model M1 M2 sd N1 N2 K1 K2 rho alpha power

mat define T1 = J(24,11,.)
local count1 = 1
foreach vars in No M1 M2 sd N1 N2 K1 K2 rho alpha power{
forvalues r1 = 1(1)24{
	mat T1[`r1',`count1'] = `vars'[`r1']
}
local  count1 = `count1' + 1
}

levelsof Model 
cap ssc install outtable
mat colnames T1 =  No M1 M2 sd N1 N2 K1 K2 rho alpha power 
mat rownames T1 = `r(levels)' 
outtable using "${reploutdir}/BaseAdminCompliance",mat(T1) replace  


/*

tempfile BaseAdminControl
save `BaseAdminControl'
*/


*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$ Central Analysis data - Compliance $$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


clear all 
set obs 1
local alps "5 10"
foreach i of local alps{
	
	local alp = 0.01*`i'
	
		* twomeans power 
		
	* Mean Big
	local suffix "ptmAnalDCtralAvInCor`i'b"
	power twomeans 0.063 0.095, sd(0.244) n1(13668) n2(14096) k1(104) k2(109) rho(0.061) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptmAnalDCtralAvInCor`i's"
	power twomeans 0.063 0.095, sd(0.244) n1(1167) n2(1272) k1(104) k2(109) rho(0.061) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptmAnalDCtralCI1InCor`i'b"
	power twomeans 0.063 0.095, sd(0.244) n1(13668) n2(14096) k1(104) k2(109) rho(0.042) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptmAnalDCtralCI1InCor`i's"
	power twomeans 0.063 0.095, sd(0.244) n1(1167) n2(1272) k1(104) k2(109) rho(0.042) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptmAnalDCtralCI2InCor`i'b"
	power twomeans 0.063 0.095, sd(0.244) n1(13668) n2(14096) k1(104) k2(109) rho(0.079) alpha(`alp')
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

		* CI2 Small
	local suffix "ptmAnalDCtralCI2InCor`i's"
	power twomeans 0.063 0.095, sd(0.244) n1(1167) n2(1272) k1(104) k2(109) rho(0.079) alpha(`alp')
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

	
		* twoprop power 
			
	* Mean Big
	local suffix "ptpAnalDCtralAvInCor`i'b"
	power twoprop 0.063 0.095, n1(13668) n2(14096) k1(104) k2(109) rho(0.061) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptpAnalDCtralAvInCor`i's"
	power twoprop 0.063 0.095, n1(1167) n2(1272) k1(104) k2(109) rho(0.061) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptpAnalDCtralCI1InCor`i'b"
	power twoprop 0.063 0.095, n1(13668) n2(14096) k1(104) k2(109) rho(0.042) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptpAnalDCtralCI1InCor`i's"
	power twoprop 0.063 0.095, n1(1167) n2(1272) k1(104) k2(109) rho(0.042) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptpAnalDCtralCI2InCor`i'b"
	power twoprop 0.063 0.095, n1(13668) n2(14096) k1(104) k2(109) rho(0.079) alpha(`alp')
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

		* CI2 Small
	local suffix "ptpAnalDCtralCI2InCor`i's"
	power twoprop 0.063 0.095, n1(1167) n2(1272) k1(104) k2(109) rho(0.079) alpha(`alp')
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
}

gen id = 1
keep id M1* M2* sd* N1* N2* K1* K2* rho*  alpha* power*
reshape long M1 M2 sd N1 N2 K1 K2 rho alpha power, i(id) j(Model) string
// gen outcomevar = "Compliance"

drop id 
gen No = _n
order No Model M1 M2 sd N1 N2 K1 K2 rho alpha power

mat define T1 = J(24,11,.)
local count1 = 1
foreach vars in No M1 M2 sd N1 N2 K1 K2 rho alpha power{
forvalues r1 = 1(1)24{
	mat T1[`r1',`count1'] = `vars'[`r1']
}
local  count1 = `count1' + 1
}

levelsof Model 
cap ssc install outtable
mat colnames T1 =  No M1 M2 sd N1 N2 K1 K2 rho alpha power 
mat rownames T1 = `r(levels)' 
outtable using "${reploutdir}/AnalDCentralCompliance",mat(T1) replace  

/*
tempfile AnalDCtralControl
save `AnalDCtralControl'
*/


*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$ Control Analysis data - Compliance $$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

clear all 
set obs 1
local alps "5 10"
foreach i of local alps{
	
	local alp = 0.01*`i'
	
		* twomeans power 
		
	* Mean Big
	local suffix "ptmAnalDCtrolAvInCor`i'b"
	power twomeans 0.0013 0.033, sd(0.035) n1(13668) n2(14096) k1(104) k2(109) rho(0) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptmAnalDCtrolAvInCor`i's"
	power twomeans 0.0013 0.033, sd(0.035) n1(1167) n2(1272) k1(104) k2(109) rho(0) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptmAnalDCtrolCI1InCor`i'b"
	power twomeans 0.0013 0.033, sd(0.035) n1(13668) n2(14096) k1(104) k2(109) rho(0) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptmAnalDCtrolCI1InCor`i's"
	power twomeans 0.0013 0.033, sd(0.035) n1(1167) n2(1272) k1(104) k2(109) rho(0) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptmAnalDCtrolCI2InCor`i'b"
	power twomeans 0.0013 0.033, sd(0.035) n1(13668) n2(14096) k1(104) k2(109) rho(0.009) alpha(`alp')
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

		* CI2 Small
	local suffix "ptmAnalDCtrolCI2InCor`i's"
	power twomeans 0.0013 0.033, sd(0.035) n1(1167) n2(1272) k1(104) k2(109) rho(0.009) alpha(`alp')
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

	
		* twoprop power 
			
	* Mean Big
	local suffix "ptpAnalDCtrolAvInCor`i'b"
	power twoprop 0.0013 0.033, n1(13668) n2(14096) k1(104) k2(109) rho(0) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptpAnalDCtrolAvInCor`i's"
	power twoprop 0.0013 0.033, n1(1167) n2(1272) k1(104) k2(109) rho(0) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptpAnalDCtrolCI1InCor`i'b"
	power twoprop 0.0013 0.033, n1(13668) n2(14096) k1(104) k2(109) rho(0) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptpAnalDCtrolCI1InCor`i's"
	power twoprop 0.0013 0.033, n1(1167) n2(1272) k1(104) k2(109) rho(0) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptpAnalDCtrolCI2InCor`i'b"
	power twoprop 0.0013 0.033, n1(13668) n2(14096) k1(104) k2(109) rho(0.009) alpha(`alp')
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

		* CI2 Small
	local suffix "ptpAnalDCtrolCI2InCor`i's"
	power twoprop 0.0013 0.033, n1(1167) n2(1272) k1(104) k2(109) rho(0.009) alpha(`alp')
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
}

gen id = 1
keep id M1* M2* sd* N1* N2* K1* K2* rho*  alpha* power*
reshape long M1 M2 sd N1 N2 K1 K2 rho alpha power, i(id) j(Model) string

drop id 
gen No = _n
order No Model M1 M2 sd N1 N2 K1 K2 rho alpha power

mat define T1 = J(24,11,.)
local count1 = 1
foreach vars in No M1 M2 sd N1 N2 K1 K2 rho alpha power{
forvalues r1 = 1(1)24{
	mat T1[`r1',`count1'] = `vars'[`r1']
}
local  count1 = `count1' + 1
}

levelsof Model 
cap ssc install outtable
mat colnames T1 =  No M1 M2 sd N1 N2 K1 K2 rho alpha power 
mat rownames T1 = `r(levels)' 
outtable using "${reploutdir}/AnalDControlCompliance",mat(T1) replace  

/*
tempfile AnalDCtrolControl
save `AnalDCtrolControl'
*/



*###############################################################################
*###############################################################################




 
	* REVENUES 

	
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$ Baseline Administrative - Revenues $$$$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

clear
set obs 1
local alps "5 10"
foreach i of local alps{
	
	local alp = 0.01*`i'
	
		* twomeans power 
		
	* Mean Big
	local suffix "ptmBaseAdminAvInCor`i'b"
	power twomeans 129.12 208.76, sd(662.35) n1(13668) n2(14096) k1(104) k2(109) rho(0.176) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptmBaseAdminAvInCor`i's"
	power twomeans 129.12 208.76, sd(662.35) n1(1167) n2(1272) k1(104) k2(109) rho(0.176) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptmBaseAdminCI1InCor`i'b"
	power twomeans 129.12 208.76, sd(662.35) n1(13668) n2(14096) k1(104) k2(109) rho(0.127) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptmBaseAdminCI1InCor`i's"
	power twomeans 129.12 208.76, sd(662.35) n1(1167) n2(1272) k1(104) k2(109) rho(0.127) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptmBaseAdminCI2InCor`i'b"
	power twomeans 129.12 208.76, sd(662.35) n1(13668) n2(14096) k1(104) k2(109) rho(0.224) alpha(`alp')
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

		* CI2 Small
	local suffix "ptmBaseAdminCI2InCor`i's"
	power twomeans 129.12 208.76, sd(662.35) n1(1167) n2(1272) k1(104) k2(109) rho(0.224) alpha(`alp')
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
}

gen id = 1
keep id M1* M2* sd* N1* N2* K1* K2* rho*  alpha* power*
reshape long M1 M2 sd N1 N2 K1 K2 rho alpha power, i(id) j(Model) string
gen outcomevar = "Revenues"

tempfile BaseAdminControl_amt
save `BaseAdminControl_amt'


*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$ Central Analysis data - Revenues $$$$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

clear 
set obs 1
local alps "5 10"
foreach i of local alps{
	
	local alp = 0.01*`i'
	
		* twomeans power 
		
	* Mean Big
	local suffix "ptmAnalDCtralAvInCor`i'b"
	power twomeans 182.24 261.88, sd(928.3) n1(13668) n2(14096) k1(104) k2(109) rho(0.038) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptmAnalDCtralAvInCor`i's"
	power twomeans 182.24 261.88, sd(928.3) n1(1167) n2(1272) k1(104) k2(109) rho(0.038) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptmAnalDCtralCI1InCor`i'b"
	power twomeans 182.24 261.88, sd(928.3) n1(13668) n2(14096) k1(104) k2(109) rho(0.026) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptmAnalDCtralCI1InCor`i's"
	power twomeans 182.24 261.88, sd(928.3) n1(1167) n2(1272) k1(104) k2(109) rho(0.026) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptmAnalDCtralCI2InCor`i'b"
	power twomeans 182.24 261.88, sd(928.3) n1(13668) n2(14096) k1(104) k2(109) rho(0.051) alpha(`alp')
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

		* CI2 Small
	local suffix "ptmAnalDCtralCI2InCor`i's"
	power twomeans 182.24 261.88, sd(928.3) n1(1167) n2(1272) k1(104) k2(109) rho(0.051) alpha(`alp')
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

}

gen id = 1
keep id M1* M2* sd* N1* N2* K1* K2* rho*  alpha* power*
reshape long M1 M2 sd N1 N2 K1 K2 rho alpha power, i(id) j(Model) string
gen outcomevar = "Revenues"

tempfile AnalDCtralControl_amt
save `AnalDCtralControl_amt'


*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*$$$$$$$$$ Control Analysis data - Revenues $$$$$$$$$$
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

clear
set obs 1

local alps "5 10"
foreach i of local alps{
	
	local alp = 0.01*`i'
	
		* twomeans power 
		
	* Mean Big
	local suffix "ptmAnalDCtrolAvInCor`i'b"
	power twomeans 8.28 87.92, sd(233.784) n1(13668) n2(14096) k1(104) k2(109) rho(0) alpha(`alp')
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
	
		* Mean Small
	local suffix "ptmAnalDCtrolAvInCor`i's"
	power twomeans 8.28 87.92, sd(233.784) n1(1167) n2(1272) k1(104) k2(109) rho(0) alpha(`alp')
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
	
		* CI1 Big 
	local suffix "ptmAnalDCtrolCI1InCor`i'b"
	power twomeans 8.28 87.92, sd(233.784) n1(13668) n2(14096) k1(104) k2(109) rho(0) alpha(`alp')
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


		* CI1 Small 
	local suffix "ptmAnalDCtrolCI1InCor`i's"
	power twomeans 8.28 87.92, sd(233.784) n1(1167) n2(1272) k1(104) k2(109) rho(0) alpha(`alp')
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
	
	
		* CI2 Big
	local suffix "ptmAnalDCtrolCI2InCor`i'b"
	power twomeans 8.28 87.92, sd(233.784) n1(13668) n2(14096) k1(104) k2(109) rho(0.009) alpha(`alp')
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

		* CI2 Small
	local suffix "ptmAnalDCtrolCI2InCor`i's"
	power twomeans 8.28 87.92, sd(233.784) n1(1167) n2(1272) k1(104) k2(109) rho(0.009) alpha(`alp')
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
}

gen id = 1
keep id M1* M2* sd* N1* N2* K1* K2* rho*  alpha* power*
reshape long M1 M2 sd N1 N2 K1 K2 rho alpha power, i(id) j(Model) string
// gen outcomevar = "Compliance"

tempfile AnalDCtrolControl_amt
save `AnalDCtrolControl_amt'

*###############################################################################

use `BaseAdminControl_amt', clear 
append using `AnalDCtralControl_amt'
append using `AnalDCtrolControl_amt'


drop id 
gen No = _n
order No Model M1 M2 sd N1 N2 K1 K2 rho alpha power

mat define T1 = J(36,11,.)
local count1 = 1
foreach vars in No M1 M2 sd N1 N2 K1 K2 rho alpha power{
forvalues r1 = 1(1)36{
	mat T1[`r1',`count1'] = `vars'[`r1']
}
local  count1 = `count1' + 1
}

levelsof Model 
cap ssc install outtable
mat colnames T1 =  No M1 M2 sd N1 N2 K1 K2 rho alpha power 
mat rownames T1 = `r(levels)' 
outtable using "${reploutdir}/AnalDAllRevenues",mat(T1) replace  


*###############################################################################
