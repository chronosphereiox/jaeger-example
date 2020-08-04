module github.com/chronosphereio/hotrod

go 1.13

require (
	github.com/apache/thrift v0.0.0-20151001171628-53dd39833a08
	github.com/bmizerany/perks v0.0.0-20141205001514-d9a9656a3a4b // indirect
	github.com/opentracing-contrib/go-stdlib v0.0.0-20190519235532-cf7a6c988dc9
	github.com/opentracing/opentracing-go v1.1.0
	github.com/prashantv/protectmem v0.0.0-20171002184600-e20412882b3a // indirect
	github.com/prometheus/client_golang v1.4.1
	github.com/spf13/cobra v0.0.5
	github.com/streadway/quantile v0.0.0-20150917103942-b0c588724d25 // indirect
	github.com/uber/jaeger-client-go v2.19.0+incompatible
	github.com/uber/jaeger-lib v2.2.0+incompatible
	github.com/uber/tchannel-go v1.16.0
	go.uber.org/zap v1.11.0
	golang.org/x/tools v0.0.0-20191113055240-e33b02e76616 // indirect
)

replace github.com/uber/jaeger-client-go => github.com/chronosphereiox/jaeger-client-go v0.0.0-20200206033107-97b1194d6ec6

replace github.com/uber/jaeger-lib => github.com/chronosphereiox/jaeger-lib v0.0.0-20200207172834-a0eb3002cdea
