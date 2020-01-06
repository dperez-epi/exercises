*Daniel Perez
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*	Title: 		povwages.do
*	Date: 		12/19/2019
*	Created by: Daniel Perez
*	Purpose:	Use CPS data to calculate share of workers earning "poverty wages"
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*******************************************************************************

Outline:
	
	1. Preamble
	
	2. File Preparation
		2.1 Load EPI Extracts


							
*******************************************************************************/

*1. Preamble
clear all
cap log close
set more off

*2. File Preparation
    *2.1 Load EPI Extracts

load_epiextracts, begin(2018m1) end(2018,m12) sample(ORG)
keep(famid hhid month personid)


*********************************************
*generate a family size variable, 
*********************************************


/*
Ben Zipperer 3:46 PM
you are close. I think you're trying to do this all in one line of code, which I
guess might be possible, but it's easier to deal with each part of the problem in
separate lines of code (plus your code will be more legible later on) 
so split up the problem
first create nfam correctly when folks have famid != 0
then deal with famid == 0 later
*/

sort month hhid famid personid


bysort month hhid: egen nfam = total(famid!=0)

*In some cases we have households of, for example, 3 people who are not family.
*perhaps these are just cohabiting people, so we can consider each individual a
*family of one. let nfam = 1 if famid==0

replace nfam=1 if famid==0

*in other households, we have individuals who are the sole family member,
*these are also families of 1
label var nfam "Family size"

tab famid
tab nfam


