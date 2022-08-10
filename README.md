# xml_parser

The Idea of the project is to get a dump of data from stackexchange website, parse it, store it in transformed form for analysis.

Parsing an XML file can be challenging sometimes because of the size of files and less compute power.

I started by using a very basic pandas method read_xml which works well on short datasets, but for larger ones it gives error. Hence as also mentioned in the task, the idea is to treat the bigger files as streaming event and after some digging i found that create an etree to be parsed is ideal here. It can also run into memory related issues because of document object model(DOM) and during parsing the DOM grows in memory and it can crash the system. Workaround for that can be cleaning up the DOM as the parsing in progress.

This code creates a CSV out of the dataframes which i then load in s3(can be a datalake) and run a crawler on top of those CSV's to get the metadata of the table and with a spectrum schema on top of this glue catalog, i can query and transform my data easily in my case AWS redshift.

Here is a small diagramatic representation of the pipeline:

![Screenshot 2022-08-10 at 02 30 36](https://user-images.githubusercontent.com/49339348/183784768-4c059c1b-ddf3-413b-949e-ed5256dc8302.png)

Note! = I have represented lambda here for running the code. The prototype was done in a notebook! 

For ML purposes or to make the code faster, we can leverage pyspark dataframes too in a glue job as well and the notebooks can be used in sagemaker for the customer segmentation or other advanced analytics.


All in all, here are few things can be optimized and done differently overall:

1) The consumption of files can be automated by crawling the website or with an API.
2) The run time can be improved by using numpy arrays or leveraging advanced big data tools(spark).
3) Data from DF's can be directly pushed to any relational database with a JDBC connection but it is extremely slow.
4) More data transformation for text readability can be deployed.
5) Error handling for data quality or system performace can be deployed.
6) The code be more organised, functional and dynamic.

At last, for the data transformation, i have included a small SQL query for 2 cases:

 - Number of posts in the last 30 days
 - Two separate columns for badges “Critic” and “Editor” with boolean flags (1/0 or true/false),
i.e. “is_critic” and “is_editor”

P.S - i have masked my s3 connection details and the data is not available on a DB that you can access. I used my private resources for this but i am attaching some screenshots for references.

s3 bucket: 


![Screenshot 2022-08-10 at 02 40 24](https://user-images.githubusercontent.com/49339348/183785705-225971a3-c595-4811-9991-f3c654e7c835.png)


Glue catalog: 

![Screenshot 2022-08-10 at 02 42 22](https://user-images.githubusercontent.com/49339348/183785843-87debc53-a08d-4da5-bf2c-e9575f5e4252.png)

Transformed data in datagrip:

![Screenshot 2022-08-10 at 02 43 46](https://user-images.githubusercontent.com/49339348/183786040-7d52abc8-d36a-4848-8c18-0c228e856229.png)


Please let me know if any other information is required or if i am missing anything! Thanks.










