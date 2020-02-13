# Hot R.O.D. - Rides on Demand

**NOTE:** this is a copy of Jaeger Hot R.O.D application from here: https://github.com/jaegertracing/jaeger/tree/master/examples/hotrod

This is a demo application that consists of several microservices and illustrates
the use of the OpenTracing API. It can be run standalone, but requires Jaeger backend
to view the traces. A tutorial / walkthough is available:
  * as a blog post [Take OpenTracing for a HotROD ride][hotrod-tutorial],
  * as a video [OpenShift Commons Briefing: Distributed Tracing with Jaeger & Prometheus on Kubernetes][hotrod-openshift].

## Features

* Discover architecture of the whole system via data-driven dependency diagram
* View request timeline & errors, understand how the app works
* Find sources of latency, lack of concurrency
* Highly contextualized logging
* Use baggage propagation to
  * Diagnose inter-request contention (queueing)
  * Attribute time spent in a service
* Use open source libraries with OpenTracing integration to get vendor-neutral instrumentation for free

## Running

### Running from source

Run
```
go run main.go all -m prometheus
```
Now you should be able to access the app at http://localhost:8080

### Run the talk demo

Have not created the containers yet, but the setup for the jaeger example is as specified above. The example
app will expose metrics with trace ID on the `:8083/metrics` endpoint. 

Pull down and run the prometheus instance available at https://github.com/shreyassrivatsan/prometheus/tree/kubecon_final
to scrape the metrics. Build and run prometheus using the below. The config file checked in is setup to scrape
the jaeger example and send remote read/write m3db.

```
GO111MODULE=auto go build -o /Users/shreyas/code/src/github.com/chronosphereio/prometheus/prometheus github.com/prometheus/prometheus/cmd/prometheus
./prometheus --config.file=documentation/examples/prometheus.yml
```

Pull down and run m3db in single node mode from https://github.com/shreyassrivatsan/m3/tree/kubecon_final.

```
make m3dbnode
sudo ./bin/m3dbnode -f ./bin/m3dbnode.yml
```

Run the forked instance of grafana that can parse the query output and display the trace link. 
git@github.com:chronosphereiox/grafana.git

### Preparing the Grafana
The following steps needs to be done to present metrics and tracing integration:
- Create a data source pointing to M3 Query which supports trace IDs in the response
- Create a sample graph querying data with trace IDs. Then you should see trace ID in tooltip when hovering over the graph
- Add "Data Link" to Jaeger UI using the following pattern:
```http://localhost:16686/trace/${__value.exemplar}```