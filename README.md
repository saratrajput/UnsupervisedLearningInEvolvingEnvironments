# Unsupervised Learning in Evolving Environments

This is the code for my final semester project at University of Genoa. It was done under
the supervision of Professor Stefano Rovetta.

We were given a streaming dataset of 2D position of vehicles at a traffic junction in
Genoa, Italy. Our goal was to detect any anomaly in the dataset. You can find more details
to our approach at this
[link](https://www.pattarsuraj.com/assets/unsupervised_learning_in_evolving_environments_paper.pdf).

## Notes

### Literature Review
* Anomaly detection based eccentricity analysis.
* Data stream clustering.
* Data stream mining.
* Anomaly detection: A survey.

#### Anomaly Detection based on Eccentricity Analysis
* TEDA framework
    * Theory for detecting outliers in traditional anomaly detection using threshold.
* n-sigma principle.
* Chebyshev inequality.
* 3-sigma: "Nearly all" values are taken to lie withing three standard deviations of the mean i.e. it is emprically useful to treat 99.7% probability as "near certainty".
* Sigma gap.
* Epsilon vicinity.
* Eccentric points.
* Neighbourhood: is a set of points containing that point where one can move some amount away from that point without leaving the set.

* rho(variable): Measure of adequacy of the current clustering to the most 
                recent data.
    * "Outlier density" (in physics often densities are indicated with letter rho.
    * Its values over time are collected in an array rhovals that is plotted at the end of training.
    * Its value is computed as a time-weighted average over recent data of another, instantaneous quantity called Omega.
    * Omega: Outlierness.

### Scripts

* showdriftdata.m: At a certain point we can see some outlier points which are far from the rest of the data points.


* olgpcm: OnLine Graded Possibilistic C Means
	* Output:
		- rhovals
		- summembership
		- U
		- Youtn
		- Y
		- Normvals
		- bend
	
	* Input: 
		- X
		- Y
		- bi0
		- K
		- eta0
		- alphamin

* olgpcm(X,rand(4,2),.005,4,1,.8)
	- X is given
		- to get X we need to run showdriftdata first before running above 
			command
	- Y is given as a random matrix of (4,2) dimension of values b/w 0 and 1
	- bi0: 0.005
	- K: 4
	- eta0: 1
	- alphamin: 0.8

* b: More or less sensitive to distance.
	- If b is more then membership is more sensitive to distance.
	- If b is less then membership is less sensitive to distance.

* If alpha is 0 = possiblistic case
    - alpha is 1 = probablistic case; they behave like probablistic.
    - alpha in between = partially probabilstic.