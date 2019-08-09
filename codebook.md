Tidydata Codebook
=================

The variables selected for the "tidydata.txt" data set in this
repository come from applying the "run\_analysis.R" script file to an
intital data set taken from the Machine Learning Repository from
University of California Irvine. A link to the original data is below,
followed by further explanation of the data set including some of the
original text from UC Irvine and my own explanation of the new data
resulting from run\_analysis.R.

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

### From the original explanation of the data set from UC Irvine:

"The features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain
signals (prefix 't' to denote time) were captured at a constant rate of
50 Hz. Then they were filtered using a median filter and a 3rd order low
pass Butterworth filter with a corner frequency of 20 Hz to remove
noise. Similarly, the acceleration signal was then separated into body
and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)
using another low pass Butterworth filter with a corner frequency of 0.3
Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to
indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for
each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ tGravityAcc-XYZ tBodyAccJerk-XYZ tBodyGyro-XYZ
tBodyGyroJerk-XYZ tBodyAccMag tGravityAccMag tBodyAccJerkMag
tBodyGyroMag tBodyGyroJerkMag fBodyAcc-XYZ fBodyAccJerk-XYZ
fBodyGyro-XYZ fBodyAccMag fBodyAccJerkMag fBodyGyroMag fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

mean(): Mean value std(): Standard deviation mad(): Median absolute
deviation max(): Largest value in array min(): Smallest value in array
sma(): Signal magnitude area energy(): Energy measure. Sum of the
squares divided by the number of values. iqr(): Interquartile range
entropy(): Signal entropy arCoeff(): Autorregresion coefficients with
Burg order equal to 4 correlation(): correlation coefficient between two
signals maxInds(): index of the frequency component with largest
magnitude meanFreq(): Weighted average of the frequency components to
obtain a mean frequency skewness(): skewness of the frequency domain
signal kurtosis(): kurtosis of the frequency domain signal
bandsEnergy(): Energy of a frequency interval within the 64 bins of the
FFT of each window. angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window
sample. These are used on the angle() variable:

gravityMean tBodyAccMean tBodyAccJerkMean tBodyGyroMean
tBodyGyroJerkMean"

### An explanation of the variables remaining after the "run\_analysis.R" script

The requirement for the result of the run\_analysis script was a tidy
data file that featured variables containing the mean for each of the
six activities for each subject on a subset of measurements from the
original data set. That subset was first created by only using
measurements on the mean and standard deviation of each measurement in
the original full data set. So, for each of the six activities for each
of the six subjects, there is a variable respresenting the mean for the
set of original variables listed below. There are also variables
containing the subject id numbers and the activity names.

*TimeBodyAccmean\_X 
*TimeBodyAccmean\_Y 
*TimeBodyAccmean\_Z
*TimeGravityAccmean\_X 
*TimeGravityAccmean\_Y 
*TimeGravityAccmean\_Z
*TimeBodyAccJerkmean\_X 
*TimeBodyAccJerkmean\_Y 
*TimeBodyAccJerkmean\_Z
*TimeBodyGyromean\_X 
*TimeBodyGyromean\_Y 
*TimeBodyGyromean\_Z
*TimeBodyGyroJerkmean\_X 
*TimeBodyGyroJerkmean\_Y 
*TimeBodyGyroJerkmean\_Z
*TimeBodyAccMagmean 
*TimeGravityAccMagmean 
*TimeBodyAccJerkMagmean
*TimeBodyGyroMagmean 
*TimeBodyGyroJerkMagmean 
*FreqBodyAccmean\_X
*FreqBodyAccmean\_Y 
*FreqBodyAccmean\_Z 
*FreqBodyAccmeanFreq\_X
*FreqBodyAccmeanFreq\_Y 
*FreqBodyAccmeanFreq\_Z 
*FreqBodyAccJerkmean\_X
*FreqBodyAccJerkmean\_Y 
*FreqBodyAccJerkmean\_Z 
*FreqBodyAccJerkmeanFreq\_X
*FreqBodyAccJerkmeanFreq\_Y 
*FreqBodyAccJerkmeanFreq\_Z
*FreqBodyGyromean\_X 
*FreqBodyGyromean\_Y 
*FreqBodyGyromean\_Z
*FreqBodyGyromeanFreq\_X 
*FreqBodyGyromeanFreq\_Y 
*FreqBodyGyromeanFreq\_Z
*FreqBodyAccMagmean 
*FreqBodyAccMagmeanFreq 
*FreqBodyBodyAccJerkMagmean
*FreqBodyBodyAccJerkMagmeanFreq 
*FreqBodyBodyGyroMagmean
*FreqBodyBodyGyroMagmeanFreq 
*FreqBodyBodyGyroJerkMagmean
*FreqBodyBodyGyroJerkMagmeanFreq 
*TimeBodyAccstd\_X 
*TimeBodyAccstd\_Y
*TimeBodyAccstd\_Z 
*TimeGravityAccstd\_X 
*TimeGravityAccstd\_Y
*TimeGravityAccstd\_Z 
*TimeBodyAccJerkstd\_X 
*TimeBodyAccJerkstd\_Y
*TimeBodyAccJerkstd\_Z 
*TimeBodyGyrostd\_X 
*TimeBodyGyrostd\_Y
*TimeBodyGyrostd\_Z 
TimeBodyGyroJerkstd_X 
TimeBodyGyroJerkstd\_Y
TimeBodyGyroJerkstd\_Z 
TimeBodyAccMagstd 
TimeGravityAccMagstd
TimeBodyAccJerkMagstd 
TimeBodyGyroMagstd 
TimeBodyGyroJerkMagstd
FreqBodyAccstd\_X 
FreqBodyAccstd\_Y 
FreqBodyAccstd\_Z
FreqBodyAccJerkstd\_X 
FreqBodyAccJerkstd\_Y 
FreqBodyAccJerkstd\_Z
FreqBodyGyrostd\_X 
FreqBodyGyrostd\_Y 
FreqBodyGyrostd\_Z
FreqBodyAccMagstd 
FreqBodyBodyAccJerkMagstd 
FreqBodyBodyGyroMagstd
FreqBodyBodyGyroJerkMagstd
