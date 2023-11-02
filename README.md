
# RaceCounts Package

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## About The Package


The RaceCounts Package contains user-defined functions for analysis we do repeatedly when prepping an indicator script. For example, calculating an index of disparity or a quadrant value.


## Installation

You can install the development version of RaceCounts like so:

```{r}
#remotes::install_github("catalystcalifornia/RC")
library(RC)

```

# About The Functions

This is a personal package we use for Race Counts indicator prep. It contains 10 helpful functions that allows us to be more efficient with our code. These functions are: 

* count_values: Calculate the number of raced rate values.*
* calc_best: Calculate the best rate.
* calc_diff: Calculate the difference from the best.
* calc_avg_diff: Calculate average difference from the best.
* calc_s_var: Calculate sample variance of differences from the best.
* calc_p_var: Calculate population variance of differences from the best.
* calc_id: Calculate index of disparity.
* calc_state_z: Calculate state disparity z-scores.
* calc_z: Calculate county disparity and performance z-scores.
* calc_ranks: Calculate disparity and performance ranks and quadrants. 


To use the following RC Functions, 'd' will need the following columns at minimum:

* geoid and total and raced "_rate" and total and raced "_raw" (following RC naming conventions) columns. If you use a rate calc function, you will need _pop and _raw columns as well.
* Any pop screens or data reliability screens (like CV) should be complete before you get to RC Functions.
* Your dataframe must also contain both county and state (eventually city where available) data.
* Your final table export(s) must have either county_id/county_name, state_id/state_name, or city_id/city_name fields.
* Your final table export(s) should contain cv values if you used a cv screen, same for _pop columns if you used a pop screen.


Suppose we have these values: 

```{r}
d <- data.frame (geoid = c("06037", "06001", "06113", "06101", "06091"),
                    geoname = c("Los Angeles", "Alameda", "Yolo", "Sutter", "Sierra"),
                    total_rate = c("35.70", "70.03", "23.99", "65.93", "29.55"), 
                    aian_rate = c("44.9", "45", "48.99", "77", "86.55"),
                    black_rate = c("65.70", "40.03", "42.99", "54.93", "82.55"),
                    latino_rate = c("77.70", "48.04", "40.99", "82.93", "92.55"),
                    nh_white_rate = c("23.70", "50.03", "45.99", "23.93", "12.55"),
                    asian_rate = c(NA, "80.03", "2.99", "2.93", "32.55"))

```

county_id     | county_name   | total_rate    | aian_rate    | black_rate   | latino_rate   | nh_white_rate | asian_rate
------------- | ------------- | ------------- |------------- |------------- | ------------- | ------------- |-------------
06037         | Los Angeles   | 35.70         | 44.9         | 65.70        | 77.70         | 23.70         | NA
06001         | Alameda       | 70.03         | 45           | 40.03        | 48.04         | 50.03         | 80.03
06113         | Yolo          | 28.99         | 48.99        | 42.99        | 40.99         | 45.99         | 2.99
06101         | Sutter        | 65.93         | 77           | 54.93        | 82.93         | 23.93         | 2.93
06091         | Sierra        | 29.55         | 86.55        | 82.55        | 92.55         | 12.55         | 32.55


Now let's use one of the functions. For example, let's calculate the number of raced rate values per county.  


```{r}

d$asbest = 'max'    #YOU MUST UPDATE THIS FIELD AS NECESSARY: assign 'min' or 'max'

d <- count_values(d) #calculate number of "_rate" values



```

 We should now have this:
 
county_id     | county_name   | total_rate    | aian_rate    | black_rate   | latino_rate   | nh_white_rate | asian_rate  | values_count
------------- | ------------- | ------------- |------------- |------------- | ------------- | ------------- |-------------| -------------
06037         | Los Angeles   | 35.70         | 44.9         | 65.70        | 77.70         | 23.70         | 0           | 4
06001         | Alameda       | 70.03         | 45           | 40.03        | 48.04         | 50.03         | 80.03       | 5
06113         | Yolo          | 28.99         | 48.99        | 42.99        | 40.99         | 45.99         | 2.99        | 5
06101         | Sutter        | 65.93         | 77           | 54.93        | 82.93         | 23.93         | 2.93        | 5
06091         | Sierra        | 29.55         | 86.55        | 82.55        | 92.55         | 12.55         | 32.55       | 5


## Contact Us
[Chris Ringewald](https://www.linkedin.com/in/chris-ringewald-6766369/) - cringewald[at]catalystcalifornia.org  <br>


[Leila Forouzan](https://www.linkedin.com/in/leilaforouzan/) - lforouzan[at]catalystcalifornia.org

## Github Link
[Click here to view the RACE COUNTS Github Repo](https://github.com/catalystcalifornia/RaceCounts)

<p align="right">(<a href="#top">back to top</a>)</p>


## Citation
To cite RACE COUNTS, please use the following:

Catalyst California; RACE COUNTS, racecounts.org, [current year].


## License

[License](License.md)

<p align="right">(<a href="#top">back to top</a>)</p>






