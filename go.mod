module github.com/chronosphereio/hotrod

go 1.12

require (
	github.com/apache/thrift v0.0.0-20151001171628-53dd39833a08
	github.com/bmizerany/perks v0.0.0-20141205001514-d9a9656a3a4b // indirect
	github.com/jaegertracing/jaeger v1.14.0
	github.com/mjibson/esc v0.2.0 // indirect
	github.com/opentracing-contrib/go-stdlib v0.0.0-20190519235532-cf7a6c988dc9
	github.com/opentracing/opentracing-go v1.1.0
	github.com/prashantv/protectmem v0.0.0-20171002184600-e20412882b3a // indirect
	github.com/prometheus/client_golang v1.2.1
	github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4
	github.com/prometheus/common v0.7.0
	github.com/spf13/cobra v0.0.5
	github.com/streadway/quantile v0.0.0-20150917103942-b0c588724d25 // indirect
	github.com/uber-go/atomic v1.4.0 // indirect
	github.com/uber/jaeger-client-go v2.19.0+incompatible
	github.com/uber/jaeger-lib v2.2.0+incompatible
	github.com/uber/tchannel-go v1.16.0
	go.uber.org/zap v1.11.0
	golang.org/x/tools v0.0.0-20191113055240-e33b02e76616 // indirect
)

replace github.com/prometheus/client_golang => github.com/chronosphereiox/prometheus_client_golang v0.0.0-20191115110020-73bbf623f24f

replace github.com/prometheus/client_model => github.com/chronosphereiox/prometheus_client_model v0.0.0-20191115110231-46879917edea

replace github.com/prometheus/common => github.com/chronosphereiox/prometheus_common v0.0.0-20191115104641-99b2c53c4a70

replace github.com/uber/jaeger-client-go => github.com/chronosphereiox/jaeger-client-go v0.0.0-20191120210011-fca20902d9da

replace github.com/uber/jaeger-lib => github.com/chronosphereiox/jaeger-lib v0.0.0-20191121135957-7a8cd5a49e97
