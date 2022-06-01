package tracing

import (
	"context"
	"errors"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/exporters/otlp/otlpmetric"
	"go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetricgrpc"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
	"go.opentelemetry.io/otel/metric/global"
	"go.opentelemetry.io/otel/propagation"
	controller "go.opentelemetry.io/otel/sdk/metric/controller/basic"
	processor "go.opentelemetry.io/otel/sdk/metric/processor/basic"
	"go.opentelemetry.io/otel/sdk/metric/selector/simple"
	"go.opentelemetry.io/otel/sdk/resource"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	semconv "go.opentelemetry.io/otel/semconv/v1.4.0"
	"google.golang.org/grpc"
	"os"
	"strconv"
	"time"
)

func EnableTracing() bool {
	enableTracing, ok := os.LookupEnv("ENABLE_TRACING")
	if !ok {
		return false
	}
	parseBool, err := strconv.ParseBool(enableTracing)
	if err != nil {
		return false
	}
	return parseBool
}

func OtelExporterEndpoint() (string, error) {
	endpoint, ok := os.LookupEnv("OTEL_EXPORTER_OTLP_ENDPOINT")
	if !ok {
		return "", errors.New("OTEL_EXPORTER_OTLP_ENDPOINT env not found")
	}
	if len(endpoint) == 0 {
		return "", errors.New("OTEL_EXPORTER_OTLP_ENDPOINT len is 0")
	}

	return endpoint, nil
}

func Trace(ctx context.Context, name string) (*otlptrace.Exporter, error) {
	endpoint, err := OtelExporterEndpoint()
	if err != nil {
		return nil, err
	}
	c := otlptracegrpc.NewClient(
		otlptracegrpc.WithInsecure(),
		otlptracegrpc.WithEndpoint(endpoint),
		otlptracegrpc.WithDialOption(grpc.WithBlock()))
	trace, err := otlptrace.New(ctx, c)
	if err != nil {
		return nil, err
	}

	res, err := resource.New(ctx,
		resource.WithFromEnv(),
		//resource.WithProcess(),
		resource.WithHost(),
		resource.WithAttributes(
			// the service name used to display traces in backends
			semconv.ServiceNameKey.String(name),
		),
	)

	if err != nil {
		return nil, err
	}
	bsp := sdktrace.NewBatchSpanProcessor(trace)
	tracerProvider := sdktrace.NewTracerProvider(
		sdktrace.WithSampler(sdktrace.AlwaysSample()),
		sdktrace.WithResource(res),
		sdktrace.WithSpanProcessor(bsp),
	)

	// set global propagator to tracecontext (the default is no-op).
	otel.SetTextMapPropagator(propagation.NewCompositeTextMapPropagator(propagation.TraceContext{}, propagation.Baggage{}))
	otel.SetTracerProvider(tracerProvider)
	return trace, nil
}

func Metric(ctx context.Context, period time.Duration) (*controller.Controller, error) {
	endpoint, err := OtelExporterEndpoint()
	if err != nil {
		return nil, err
	}
	client := otlpmetricgrpc.NewClient(
		otlpmetricgrpc.WithInsecure(),
		otlpmetricgrpc.WithEndpoint(endpoint))
	metricExp, err := otlpmetric.New(ctx, client)
	if err != nil {
		return nil, err
	}

	pusher := controller.New(
		processor.NewFactory(
			simple.NewWithHistogramDistribution(),
			metricExp,
		),
		controller.WithExporter(metricExp),
		controller.WithCollectPeriod(period),
	)
	global.SetMeterProvider(pusher)
	return pusher, nil
}
