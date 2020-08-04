// Copyright (c) 2019 The Jaeger Authors.
// Copyright (c) 2017 Uber Technologies, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package customer

import (
	"context"
	"errors"
	"sync"

	"github.com/opentracing/opentracing-go"
	"github.com/opentracing/opentracing-go/ext"
	"github.com/uber/jaeger-lib/metrics"

	"github.com/chronosphereio/hotrod/pkg/delay"
	"github.com/chronosphereio/hotrod/pkg/log"
	"github.com/chronosphereio/hotrod/pkg/tracing"
	"github.com/chronosphereio/hotrod/services/config"
)

var errTimeout = errors.New("redis timeout")

// Redis is a simulator of remote Redis cache
type Redis struct {
	tracer opentracing.Tracer // simulate redis as a separate process
	logger log.Factory
	errorSimulator
}

func newRedis(metricsFactory metrics.Factory, logger log.Factory) *Redis {
	return &Redis{
		tracer: tracing.Init("redis", metricsFactory, logger),
		logger: logger,
	}
}

// GetCustomer returns the customer for the given ID.
func (r *Redis) GetCustomer(ctx context.Context, id string) (*Customer, error) {
	if span := opentracing.SpanFromContext(ctx); span != nil {
		span := r.tracer.StartSpan("GetCustomer", opentracing.ChildOf(span.Context()))
		span.SetTag("param.id", id)
		ext.SpanKindRPCClient.Set(span)
		defer span.Finish()
		ctx = opentracing.ContextWithSpan(ctx, span)
	}
	// simulate RPC delay
	delay.Sleep(config.RedisFindDelay, config.RedisFindDelayStdDev)

	if err := r.checkError(); err != nil {
		if span := opentracing.SpanFromContext(ctx); span != nil {
			ext.Error.Set(span, true)
		}
		return  nil, err
	}
	return &Customer{
		ID: id,
	}, nil
}

type errorSimulator struct {
	sync.Mutex
	countTillError int
}

func (es *errorSimulator) checkError() error {
	es.Lock()
	es.countTillError--
	if es.countTillError > 0 {
		es.Unlock()
		return nil
	}
	es.countTillError = 2
	es.Unlock()
	delay.Sleep(2*config.RedisGetDelay, 0) // add more delay for "timeout"
	return errTimeout
}
