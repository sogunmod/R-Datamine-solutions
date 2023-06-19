system("hostname", intern=TRUE)

#The name of the node on Anvil that you are running on is "a240.anvil.rcac.purdue.edu"!

# Subcluster A
1000 * 128

# Subcluster B
32 * 128

# Subcluster G
16 * 128

128000+4096+2048

#In the sub cluster on anvil, since there are three of them (A, B & C), there are 134144 (128000 + 4096 +2048) cores using R.

# Subcluster A
1000*256

# Subcluster B
32*1

# Subcluster G
16*512

#In the sub cluster on anvil, since there are three of them (A, B & C), there are 296.192TB (256000GB + 32TB + 8192GB) using R.

dat <- read.csv("/anvil/projects/tdm/data/disney/flight_of_passage.csv")

head(dat)

#date            datetime SACTMIN SPOSTMIN
1 05/26/2017 2017-05-26 09:06:38      NA     -999
2 05/26/2017 2017-05-26 09:10:11      47       NA
3 05/26/2017 2017-05-26 09:10:12      NA        5
4 05/26/2017 2017-05-26 09:17:09      NA       60
5 05/26/2017 2017-05-26 09:24:07      NA       60
6 05/26/2017 2017-05-26 09:30:10      NA       60

flight_of_passage <- read.csv("/anvil/projects/tdm/data/disney/flight_of_passage.csv")

head(flight_of_passage)

   #date            datetime SACTMIN SPOSTMIN
1 05/26/2017 2017-05-26 09:06:38      NA     -999
2 05/26/2017 2017-05-26 09:10:11      47       NA
3 05/26/2017 2017-05-26 09:10:12      NA        5
4 05/26/2017 2017-05-26 09:17:09      NA       60
5 05/26/2017 2017-05-26 09:24:07      NA       60
6 05/26/2017 2017-05-26 09:30:10      NA       60

