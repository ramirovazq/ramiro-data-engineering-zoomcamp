import dlt
from dlt.sources.helpers.rest_client import RESTClient
from dlt.sources.helpers.rest_client.paginators import PageNumberPaginator

# my code
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

# explore loaded data
pipeline.dataset(dataset_type="default").rides.df()