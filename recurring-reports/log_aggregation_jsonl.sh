today=`date +%Y-%m-%d`
echo $today

HOME=/home/hadro/

cd /home/hadro/ghfc/recurring-reports/

# Download the log files from the GHFC server
echo "Pulling log files..."
cp /home/christopher/check-in-stats/shop_log.jsonl /home/hadro/ghfc/recurring-reports/logs/shop_log.jsonl

# Use some pandas to extract stuff we know we'll need
echo "Processing logs into log.csv..."
python3 /home/hadro/ghfc/recurring-reports/process_logs_jsonl.py

echo "Running RMarkdown script..."
#Rscript -e "rmarkdown::render('report.Rmd', 
#				output_file = paste('report.', Sys.Date(), 
#				'.html', sep=''
#				))"

Rscript -e "rmarkdown::render('/home/hadro/ghfc/recurring-reports/report.Rmd',
                  output_file = paste('/home/hadro/ghfc/recurring-reports/reports/report_', Sys.Date(), 
                                      '.html', sep=''))"


				      
# Send it via email until we get an http version set up
#echo "Sending an email now"
#echo "Sending the report for" $today | mailx -A report_$today.html -s "Subject" josh.hadro@gmail.com
#echo "Sending the report for" $today | mailx -s "GHFC Report for $today" -A ./report_$today.html josh.hadro@gmail.com

# Push to git repo
git add /home/hadro/ghfc/recurring-reports/reports/report_$today.html
git commit -m "Add report for $today"
git push


echo "Done!"
