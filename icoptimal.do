set more off
#delimit;
*set data as panel
xtset panel_id year
set more off
#delimit;
log using lag.log, replace;
scalar aicbest= 1000000;
scalar bicbest= 1000000;
mat aic=J(1,5,0);
mat bic=J(1,6,0);

forv i=1(1)5{;
	forv j=1(1)5{;
			forv k=1(1)5{;
				forv m=1(1)5{;
					areg y l(1/`i').x1 l(1/`j').x2 l(1/`k').x3 l(1/`m').x4,  absorb(panel_id) cluster(panel_id);
					estat ic;
					mat aicbic = r(S);
					*mat aic[1, 5]= aicbic[1, 5];
					*mat bic[1, 6]= aicbic[1, 6];
					if aicbic[1, 5] <aicbest {;
						scalar aicbest =aicbic[1, 5];
						est store aicbest;
						};
					if aicbic[1, 6] <bicbest {;
						scalar bicbest =aicbic[1, 6];
						est store bicbest;
						};
					};
				};
			};
		};
est replay aicbest;
est replay bicbest;
log close;
