Original file is located at
    https://colab.research.google.com/drive/1plqdl33K_HkVx0E0nGJrrkEUssStQsW7

# **Workshop "Data Ingestion with dlt": Homework**

---

## **Dataset & API**

We’ll use **NYC Taxi data** via the same custom API from the workshop:

🔹 **Base API URL:**  
```
https://us-central1-dlthub-analytics.cloudfunctions.net/data_engineering_zoomcamp_api
```
🔹 **Data format:** Paginated JSON (1,000 records per page).  
🔹 **API Pagination:** Stop when an empty page is returned.

## **Question 1: dlt Version**

1. **Install dlt**:


```py
import dlt
print("dlt version:", dlt.__version__)
dlt version: 1.6.1
```
https://github.com/ramirovazq/ramiro-data-engineering-zoomcamp/3_1_dlt_worshop/images/question_1_dlt_version_1_6_1.png




## **Question 2: Define & Run the Pipeline (NYC Taxi API)**

Use dlt to extract all pages of data from the API.

Steps:

1️⃣ Use the `@dlt.resource` decorator to define the API source.

2️⃣ Implement automatic pagination using dlt's built-in REST client.

3️⃣ Load the extracted data into DuckDB for querying.

```py
import dlt
from dlt.sources.helpers.rest_client import RESTClient
from dlt.sources.helpers.rest_client.paginators import PageNumberPaginator


# your code is here
@dlt.resource(name="rides")
def ny_taxi():
    client = RESTClient(
        base_url="https://us-central1-dlthub-analytics.cloudfunctions.net",
        #headers={"User-Agent": "MyApp/1.0"},
        #auth=BearerTokenAuth(token="your_access_token_here"),  # type: ignore
        #paginator=JSONLinkPaginator(next_url_path="pagination.next"),
        paginator=PageNumberPaginator(
            base_page=1,
            total_path=None
        )
        #data_selector="data",
        #session=MyCustomSession()
    )
    for page in client.paginate("data_engineering_zoomcamp_api"):
        yield page


pipeline = dlt.pipeline(
    pipeline_name="ny_taxi_pipeline",
    destination="duckdb",
    dataset_name="ny_taxi_data"
)

load_info = pipeline.run(ny_taxi)
print(load_info)
```


Start a connection to your database using native `duckdb` connection and look what tables were generated:"""

```py
import duckdb
from google.colab import data_table
data_table.enable_dataframe_formatter()

# A database '<pipeline_name>.duckdb' was created in working directory so just connect to it

# Connect to the DuckDB database
conn = duckdb.connect(f"{pipeline.pipeline_name}.duckdb")

# Set search path to the dataset
conn.sql(f"SET search_path = '{pipeline.dataset_name}'")

# Describe the dataset
conn.sql("DESCRIBE").df()

```

How many tables were created?

```
>>> import duckdb
>>> conn = duckdb.connect("ny_taxi_pipeline.duckdb")
>>> conn.sql(f"SET search_path = 'ny_taxi_data'") # as schema
>>> conn.sql("SHOW TABLES")
┌─────────────────────┐
│        name         │
│       varchar       │
├─────────────────────┤
│ _dlt_loads          │
│ _dlt_pipeline_state │
│ _dlt_version        │
│ rides               │
└─────────────────────┘
```
* 4

## **Question 3: Explore the loaded data**

Inspect the table `ride`:

```py

>>> import duckdb
>>> conn = duckdb.connect("ny_taxi_pipeline.duckdb")
>>> conn.sql(f"SET search_path = 'ny_taxi_data'") # as schema
>>> conn.sql("SHOW TABLES")
>>> df = pipeline.dataset(dataset_type="default").rides.df()
>>> df.shape
(10000, 18)
```

What is the total number of records extracted?
* 10000

## **Question 4: Trip Duration Analysis**

Run the SQL query below to:

* Calculate the average trip duration in minutes.

```py
import dlt
pipeline = dlt.pipeline(
    pipeline_name="ny_taxi_pipeline_new",
    destination="duckdb",
    dataset_name="ny_taxi_data"
)
with pipeline.sql_client() as client:
    res = client.execute_sql(
            """
            SELECT
            AVG(date_diff('minute', trip_pickup_date_time, trip_dropoff_date_time))
            FROM rides;
            """
        )
    # Prints column values of the first row
    print(res)
[(12.3049,)]
```

What is the average trip duration?
* 12.3049

## **Submitting the solutions**

* Form for submitting: https://courses.datatalks.club/de-zoomcamp-2025/homework/workshop1

## **Solution**

We will publish the solution here after deadline.
