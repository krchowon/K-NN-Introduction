# K-NN-Introduction

In this repo, I will demonstrate a simple Classification Problem of fruits across height, width, mass, and color using the K-NearestNeighbours algorithm. In this script I hope to guide you through how I enjoy structuring this problem.

To begin, run through <A href='https://github.com/krchowon/K-NN-Introduction/blob/master/FruitClassifier.m'>FruitClassifier</A> script for a useful guide on the process.

The data we are experientating with is avilable via <A href='https://github.com/krchowon/K-NN-Introduction/blob/master/data/fruit_data_with_colors.txt'>fruit data text file</A>. Fruits Data contains mass, height, and width of a selection of oranges, lemons and apples.  The heights were measured along the core of the fruit. The widths were the widest width perpendicular to the height.

| fruit_label | fruit_name | fruit_subtype | mass | width | height | color_score |
| ------------| :--------: | :-----------: | :--: | :---: | :----: | ----------: |
| 1 | apple | granny_smith | 192 | 8.4 | 7.3 | 0.55 |
| 1 | apple | granny_smith | 180 | 8.0 | 6.8 | 0.59 |
| 1 | apple | granny_smith | 176 | 7.4 | 7.2 | 0.60 |
| 2 | mandarin | mandarin | 86  | 6.2 | 4.7 | 0.80 |
| 2 | mandarin | mandarin | 84  | 6.0 | 4.6 | 0.79 |
| 2 | mandarin | mandarin | 80  | 5.8 | 4.3 | 0.77 |
| 2 | mandarin | mandarin | 80  | 5.9  | 4.3 | 0.81 |
| 2 | mandarin | mandarin | 76 | 5.8 | 4.0 | 0.81 |
| 1 | apple | braeburn | 178 | 7.1 | 7.8 | 0.92 |

The above data exists in txt file so the first step would be to retrieve, scrape and clean the data. This will prepare it for our analysis.

# Review/Explore Data sets. 
In any data science exercise, inspecting the data first is critical in  finding strong relationships in data and/or finding anomalies in the data set.

<IMG src="https://github.com/krchowon/K-NN-Introduction/blob/master/out/scatter.bmp">
  
  At first glimpse, all these dimensions are quite overwhelming. Good sanity check is to scan for potential outliers in the matrix. Perhaps investigate if there may be any discernable  clusters or groups that can emerge from the features. One in particular I thought was noticeable is this small cluster on the bottom left region of Height vs. Width or Height vs. Mass.
  
  So I decided to dig a lil further.  
  
<IMG src="https://github.com/krchowon/K-NN-Introduction/blob/master/out/WidthVsHeight.bmp">  
  
  What I found particularly interesting when leveraging my years of fruit expertise is across the height = weight, we see very round fruits, but particularly the light blue cluster is particularly much smaller overall than the cluster of purple and green cluster in the centre. Even more interesting is a cluster of yellow fruits seem to be noticeably more oval in shape than the rest of the fruits. These 2 clusters gives me confidence that classifying points by width and height in those 2 local domains will yield accurate predictions. However I anticipate KMeans to struggle moreso slicing the cloud purple & green fruits in the centre.
  
  # Applying the Algorithm
  As We fit the Knn model with a parameter K=5, we see the following results
  
  <IMG src="https://github.com/krchowon/K-NN-Introduction/blob/master/out/predict_example.PNG">  
  
  
  # Sensitivity Analysis
  The accuracy of the algorithm seems healthy but we can see how sensitive these results are to the choice of K

  <IMG src="https://github.com/krchowon/K-NN-Introduction/blob/master/out/KSensitivity.bmp">
    K Nearest Neighbours appears very sensitive to choice of K. Shape of accuracy across choice of N has large variance in accuracy. However, the algorithm seems optimal around 5-7 nearest neighbours.
  
  
