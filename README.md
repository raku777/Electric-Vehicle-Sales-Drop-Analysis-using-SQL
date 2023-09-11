# Electric-Vehicle-Sales-Drop-Analysis-using-SQL
This SQL project is part of https://www.bluetick.ai/ microexperience. Refer to this page https://app.bluetick.ai/workstation/104 to download the files required to complete this project.
# Problem Statement
Zoom electric(ZE) had launched there Sprint scooter model in the 2-wheeler market. The initial sales for the first two weeks were promising, but it had a sudden drop in sales when it had entered the third week. Now we need to validate this drop in sales and identify reasons if any for the decline in sales.
# Quantifying the Sales Drop
Here, we need to examine the cumulative sales volume over a rolling 7-day period to validate the sales drop, this approach will help in evaluating the sales performance throughout a week. We need to validate the decline the sales to understand the current sales performance. This can help us in identifying any potential issuses or trends affecting sales.

The formula used to help us in calculating the change in cummulative sales volume over a 7-day rolling period is as follows:
ΔSales = ((Sales at t - Sales at t-1) / Sales at t-1) Where Sales" represents the cumulative sales volume over the last 7 days, "t" refers to the current time period, and "t-1" represents the previous time period

To visualize this drop in sales, I have plotted a line chart with the help of Excel
# Launch Date Assumption
The objective of this assumption is to find if there is any correlation between the the sales growth experienced in first two to three weeks and launch date. We are doing this analysis since ZE launched all their products before Sprint in the first half of the year and Sprint is their first product to be launched in the second half of the year. We do this by comparing the sales growth volume of an another scooter called Sprint LE which was launched in the first half of the year with the sales growth volume of Sprint. This can help us in determining the impact of launch date and therfore help in determining the launch date for future products.

I have also used Excel to show comparsion of the sales growth volume of the two scooters with help of line charts

# E-mail Campaign Analysis
Analyzing the effectiveness of the e-mail campaign can give us insights in influencing customers purchasing decisions. By analyzing the e-mail opening rate and click-through rates we can understand how well the campaign engages recipients, whether they open the e-mail, click on the provided links and compare them with a benchmark rate to assess the overall impact and success of the campaign

To calculate the Click Rate, Refer to the following formula: Click Rate = ( E-mails Clicked ) / (E-mail sent - Bounced)

While calculating these it is essential to follow these:
Collect email campaign-related data for Sprint Scooters from email-subject.csv and compare them with the data from emails.csv

Typically the industry benchmark for a quality campaign is an 18% email opening rate and an 8% Click Rate
