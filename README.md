mobiledata
==========

Code to read in mobile wearable computing data (the UCI HAR dataset)

8/21/2014

--------------------

This code block starts with a direct link to go get the data and put it in a temp folder. The temp folder is then accessed using the unzip() function to load all of the data into your working directory. Please ignore these steps if you already have the data, and obviously, you'll have to change your wd to something that makes sense for you.

The script then accesses the relevant files from the dataset. It creates dataframes out of the X_ data, and vectors for everything else.

First, rbind() is used to bind the training and test data together. Then, colnames are added from the features vector. At this point, a loop is run on the "string_search" character vector to find all of the instances of mean() and std() in the colnames for the merged data frame. grep() is used to create a index vector which is then used to subset the relevant columns.

Once this is done, the subject and activity columns are added at the far left of the data frame. Activity is matched to the appropriate labels using activity_labels and the latent factor abilities in R.

At this point, we have a tidy data set. All that is left is to aggregate by subject and activity. We use the aggregate() function for this, using . for the variable arguments. This creates the final tidy dataframe, which is written out using write.table to "aggregated_data.txt"

------------------




