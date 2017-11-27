## D3 Project about armories migration using data of the ATF
### Pedro Armengol

This project use the Listing of Federal Firearms Licensees (FFLs) published by the Bureau of Alcohol, Tobacco, 
Firearms and Explosives (ATF) to track the armories migration(merchants related to production, imports and exports of firearms).
For this purpose, I filter the data to keep just the armories that changed of address in any of the following years: 2014,2015,2016 and 2017. 
I used snapshot of the data (june of each year) to observe the address of the armory in that year. Also, for "practical" purposes
I just keep those armories that change across states one or more times. 

Later on, a D3 visualization dynamic scatterplot was built to show the paths that the armories are following over those years.

Source:

https://www.atf.gov/firearms/listing-federal-firearms-licensees-ffls-2016
