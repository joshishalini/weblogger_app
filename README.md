# Weblogger
### Approach
1. Getting data from webserver.log file and in case file doesnt exist it will raise error.
2. While initialize create a data hash where hash look like key will have the page and value will have 2 things IP and count.
3. Ip saves every unique ip so at the end we can sort and use then to print unique values
4. Count is generic count to show total visites it will always added by 1
5. then i irritated the file value and in case i dont get the ip or page data it might be worng file so added the check
6. Then i am checking if ip is not present in the data then i just need to push the ip for first time
7. it will make sure i wont push same ip multiple times
8. and again count + 1 always to find out total Visits 
9. Then i added unique_pages and most_visited_pages to print data 
10. as the print will look similar so i used same private method to print stuff
11. Sorting the data according to unique or most visited one and sending it to print

### How to test?
1. To test you can run rspec spec/parser_spec.rb
2. I added so many test cases to make sure i am not doing anything wrong
3. added 4 files to make sure to get diff diff outputs

### How to run
1. To run the code you can uncomment the lines 50 to 53 in parser.rb
2. and then run ruby lib/parser.rb webserver.log
3. You will get following output
-------------------- list of webpages with most unique page --------------------


/index 23 Unique views

/home 23 Unique views

/contact 23 Unique views

/help_page/1 23 Unique views

/about/2 22 Unique views

/about 21 Unique views

-------------------- list of webpages with most page views page --------------------

/about/2 90 Unique views

/contact 89 Unique views

/index 82 Unique views

/about 81 Unique views

/help_page/1 80 Unique views

/home 78 Unique views 
