### Tables and Transformation

* The features.txt and activity_labels.txt were read to serve as a reference for the column names of the data sets.
* The x_train, y_train, and subject_train text files were imported using the read.table function. the 3 tables were merge to create the train table.
* Using the same procedure as above, the test data set was created.
* The test and train data were merge using rbind to create a final data set. 
* A table, with columns matching the word "mean" and "std", is created and named mean_sd.
* The activity data was merge to mean_sd to get the description of the activityid.
* A for loop was used to remove the characters \,(,) from the column names.
* Finally, a new table was created were each rows will show the average per subject and activity.
